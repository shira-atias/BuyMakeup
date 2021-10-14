//
//  CategoriesViewController.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit
import PKHUD
class CategoriesViewController: UIViewController {
    
    //MARK: -Properties
    
    let cellReuseID = "cell"
    var products:[Product] = []
    let dc = ApiDataSource()
    var category:String = ProductType.eyeshadow.rawValue
    
    //MARK: -Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: "ItemTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellReuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        dc.getProduct(from: .topHeadLines, with: ["product_type" :category]) {[weak self] prodct, err in
            self?.updateUi(with: prodct, error: err)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        
        tableView.reloadData()
    }
    //MARK: -Function
    
    func updateUi(with product: [Product]?, error:VendingMachineError?){
        if let product = product{
            products += product
            tableView.reloadData()
            
            HUD.flash(.success, delay: 1)
        }else if let error = error{
            print(error)
            
            HUD.flash(.labeledError(title: "Will try later", subtitle: "Connection error"), delay: 3)
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ItemCollectionViewController{
            dest.delegate = self
            
        }
        if let dest = segue.destination as? DetailsViewController{
            if let id = sender as? Int{
                dest.id = id
            }
        }
    }
    
    
}
// MARK: - extension
extension CategoriesViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        if let cell = cell as? ItemTableViewCell{
            cell.product = products[indexPath.row]
            cell.populate(product: products[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = products[indexPath.row].id
        performSegue(withIdentifier: "toDetail", sender: id)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
    
    
}
extension CategoriesViewController:ItemCollectionViewControllerDeledate{
    func addItem(name: String) {
        print(name)
        dc.getProduct(from: .topHeadLines, with: ["product_type" :name]) {
            [weak self] prodct, err in
            guard let products = prodct else {
                print("Error!! Null product array")
                return}
            HUD.flash(.success, delay: 1)
            self?.products = products
            self?.tableView.reloadData()
        }
    }
    
    
}
