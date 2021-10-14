//
//  BrandViewController.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit
import PKHUD

class BrandViewController: UIViewController {
    
    //MARK: -Properties
    
    let cellReuseID = "cell"
    var products:[Product] = []
    let dc = ApiDataSource()
    var brand:String = "almay"
    
    //MARK: -Outlets
    
    @IBOutlet weak var heightCollection: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ItemTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellReuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        dc.getProduct(from: .topHeadLines, with: ["brand":brand]) {[weak self] prodct, err in
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
            HUD.flash(.success, delay: 1)
            tableView.reloadData()
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? BrandCollectionViewController{
            dest.deledate = self
        }
        if let dest = segue.destination as? DetailsViewController{
            if let id = sender as? Int{
                dest.id = id
            }
        }
    }
    
    
}

// MARK: - extension

extension BrandViewController: UITableViewDelegate, UITableViewDataSource{
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
extension BrandViewController:BrandCollectionViewControllerDelegate{
    func sendBrand(name: String) {
        dc.getProduct(from: .topHeadLines, with: ["brand" :name]) {
            [weak self] prodct, err in
            guard let products = prodct else {
                print("Error!! Null product array")
                return}
            self?.products = products
            HUD.flash(.success, delay: 1)
            self?.tableView.reloadData()
            
        }
    }
    
    
}
