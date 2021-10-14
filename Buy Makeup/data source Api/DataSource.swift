//
//  DataSource.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import Foundation
//http://makeup-api.herokuapp.com/api/v1/products.json?product_type=blush

struct ApiDataSource {
    private static let baseURL = "http://makeup-api.herokuapp.com"
    
    enum EndPoint:String {
        case topHeadLines = "/api/v1/products.json"
    }
    func getProduct(from: EndPoint, with params: [String:Any], callbace:@escaping Callbace){
        
        let urlComponents = biuilUrlComponents(from: from, with: params)
        
        guard let url = urlComponents?.url else {
            callbace(nil, .invalidUrl(url: urlComponents))
            return}
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let response = response as? HTTPURLResponse{
                if !(200...299).contains(response.statusCode){
                    DispatchQueue.main.async {
                        callbace(nil, .statusError(code: response.statusCode))
                        print("statusCode not good  \(response.statusCode)")
                    }
                }
            }
            guard error == nil else {
                DispatchQueue.main.async {
                    callbace(nil, .connectionFailed(error: error))
                }
                return
            }
            guard let data = data else{
                DispatchQueue.main.async {
                    callbace(nil, .noData)
                    print("no data")
                }
                return}
            let decoder = JSONDecoder()
            do{
                let result = try decoder.decode([Product].self, from: data)
                DispatchQueue.main.async {
                    callbace(result.reversed(), nil)
                }
            }catch let errDecoder{
                DispatchQueue.main.async {
                    callbace(nil,.jsonDecoding(cause: errDecoder))
                    print("json not good \(errDecoder)")
                }
            }
        }.resume()
    }
    
    private func biuilUrlComponents(from: EndPoint, with params: [String:Any]) -> URLComponents?{
        var urlComponents = URLComponents(string: ApiDataSource.baseURL)
        urlComponents?.path = from.rawValue
        
        let params = params
        var queryItems: [URLQueryItem] = []
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: "\(value)"))
        }
        urlComponents?.queryItems = queryItems
        return urlComponents
    }
    
}


typealias Callbace = (_ prodact:[Product]?, _ error:VendingMachineError?)-> Void

enum VendingMachineError: Error {
    case invalidUrl(url:URLComponents?)
    case jsonDecoding(cause: Error)
    case connectionFailed(error: Error?)
    case statusError(code: Int)
    case noData
}
