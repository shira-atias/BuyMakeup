//
//  ItemTableViewCell.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit
import SDWebImage
protocol ItemTableViewcellDelegate {
    func didRemoveProduct()
}

class ItemTableViewCell: UITableViewCell {
    //MARK: -Properties

    var product:Product?
    //MARK: -Outlets

    @IBOutlet weak var tableImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    var delegate:ItemTableViewcellDelegate?
    //MARK: - Action
    
    @IBAction func heartButtonTapped(_ sender: UIButton) {
        if heartButton.image(for: .normal) == UIImage(systemName: "heart"){
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if let newProduct = product{
                let newProductD = ProductD(product: newProduct)
                CoreDataManager.shared.add(product:newProductD)
                delegate?.didRemoveProduct()
            }
        } else{
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            if let pro = product{
                CoreDataManager.shared.delete(product:pro)
                delegate?.didRemoveProduct()
            }
        }
    }
    
    //MARK: -Function
    
    func populate(product: Product){
        self.product = product
        if CoreDataManager.shared.isExists(product:  product){
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{

            self.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        
        brandLabel.text = product.brand?.uppercased()
        nameLabel.text = product.name
        priceLabel.text = product.price
        signLabel.text = product.priceSign ?? "$"
        guard let str = product.imageLink,
              let url = URL(string: str) else {return}
        tableImageView.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "buymackup1"))
        tableImageView.layer.cornerRadius = 55
        tableImageView.layer.borderWidth = 1.5
        tableImageView.layer.borderColor = #colorLiteral(red: 0.7829808593, green: 0.5554391742, blue: 0.7652695775, alpha: 1)
        tableImageView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        backgroundColor = #colorLiteral(red: 0.9616516232, green: 0.956600368, blue: 0.9652935863, alpha: 1)
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderWidth = 5
        layer.cornerRadius = 8
        clipsToBounds = true
    }
    
}
