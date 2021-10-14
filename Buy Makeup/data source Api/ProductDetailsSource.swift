//
//  ProductDetailsSource.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import Foundation
class ProductDetailsSource {
    let host = "makeup-api.herokuapp.com"
    
    func getDetailsProduct(id:Int, callBack:@escaping (Product)-> Void){
        var componets = URLComponents()
        componets.host = host
        componets.scheme = "http"
        componets.path = "/api/v1/products/\(id).json"
        
        guard let url = componets.url else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let data = data else {return}
            
            let decoder = JSONDecoder()
            
            guard let apiResponse = try? decoder.decode(Product.self, from: data) else {return}
            callBack(apiResponse)
            
        }.resume()
    }
    
    func getProducts(ids:[Int64],callBack:@escaping ([Product]) -> Void) {
        var products:[Product] = []
        var i = 0
        var got:Bool = true
        while i < ids.count-1 {
            if got {
                got = false
                getDetailsProduct(id: Int(ids[i])) { p in
                    products.append(p)
                    got = true
                    i += 1
                }
            }
        }
        callBack(products)
    }
}
