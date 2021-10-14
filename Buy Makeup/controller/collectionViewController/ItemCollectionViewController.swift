//
//  ItemCollectionViewController.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit

private let reuseIdentifier = "cell"

class ItemCollectionViewController: UICollectionViewController {
    
    //MARK: -Properties
    let itemImages:[UIImage] = [#imageLiteral(resourceName: "5"),#imageLiteral(resourceName: "4"),#imageLiteral(resourceName: "13"),#imageLiteral(resourceName: "1"),#imageLiteral(resourceName: "11"),#imageLiteral(resourceName: "7"),#imageLiteral(resourceName: "12"),#imageLiteral(resourceName: "9"),#imageLiteral(resourceName: "10"),#imageLiteral(resourceName: "3")]
    let itemName:[ProductType] = [.eyeshadow, .eyeliner, .mascara, .foundation, .eyebrow, .lipstick, .lipLiner, .bronzer, .blush, .nailPolish]
    
    var delegate:ItemCollectionViewControllerDeledate?
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: Bundle.main)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let itemName = itemName[indexPath.item].rawValue
        delegate?.addItem(name: itemName)
        
    }
    
    
    // MARK: -UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemImages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let cell = cell as? ItemCollectionViewCell{
            cell.itemImageView.image = itemImages[indexPath.row]
            cell.populeteCell()
        }
        
        return cell
    }
    
    
}
protocol ItemCollectionViewControllerDeledate {
    func addItem(name:String)
}
