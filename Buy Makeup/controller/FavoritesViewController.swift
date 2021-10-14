//
//  FavoritesViewController.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: -Properties
    
    let cellReuseID = "cell"
    var productD:[Product] = []
    
    //MARK: -Outlets
    
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ItemTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: cellReuseID)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

        productD = CoreDataManager.shared.fetchProductsForView()
        countLabel.text = "you heve \(productD.count) favorites"
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? DetailsViewController{
            if let id = sender as? Int{
                dest.id = id
            }
        }
    }
    
    
}
// MARK: - extension
extension FavoritesViewController : ItemTableViewcellDelegate {
    func didRemoveProduct() {
        CoreDataManager.shared.saveContext()
        productD = CoreDataManager.shared.fetchProductsForView()
        self.tableView.reloadData()
    }
}
extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        productD.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID, for: indexPath)
        if let cell = cell as? ItemTableViewCell{
            cell.populate(product: productD[indexPath.row])
            cell.delegate = self
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = Int(productD[indexPath.row].id)
        performSegue(withIdentifier: "toDetail", sender: id)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
   
    
}
