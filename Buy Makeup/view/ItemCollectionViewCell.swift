//
//  ItemCollectionViewCell.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    //MARK: -Outlets

    @IBOutlet weak var itemImageView: UIImageView!
  
    //MARK: -Function

    func populeteCell(){
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9616516232, green: 0.956600368, blue: 0.9652935863, alpha: 1)
        selectedBackgroundView = v
        itemImageView.layer.cornerRadius = 40
        itemImageView.layer.borderColor = #colorLiteral(red: 0.7829808593, green: 0.5554391742, blue: 0.7652695775, alpha: 1)
        itemImageView.layer.borderWidth = 2
    }

}
