//
//  DetailsViewController.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {
    //MARK: -Properties
    
    var label = UILabel()
    var product:Product?
    var productD:[ProductD] = []
    var id:Int = 0
    var detailsProduct = ProductDetailsSource()
    
    //MARK: -Outlets
    
    @IBOutlet weak var brandImage: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var signLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var scrolView: UIScrollView!
    @IBOutlet weak var nameColorLabel: UILabel!
    @IBOutlet weak var heartButton: UIButton!
    
    //MARK: - Action
    
    @IBAction func heartButton(_ sender: UIButton) {
        
        if heartButton.image(for: .normal) == UIImage(systemName: "heart"){
            heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            if let newProduct = product{
                let newProductD = ProductD(product: newProduct)
                CoreDataManager.shared.add(product:newProductD)
                productD.append(newProductD)
                productD = CoreDataManager.shared.fetchProducts()
                print(newProduct)
            }
        } else{
            heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
            
            if let pro = product{
                CoreDataManager.shared.delete(product:pro)
            }
        }
    }
    
    @IBAction func goToWebButton(_ sender: UIButton) {
        guard let urlProduct = product?.productLink else {return}
        guard let url = URL(string: urlProduct) else {return}
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailsProduct.getDetailsProduct(id: id) {[weak self] product in
            DispatchQueue.main.async { [self] in
                // configurePage(product: product)
                if CoreDataManager.shared.isExists(product: product){
                    self?.heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                }else{
                    
                    self?.heartButton.setImage(UIImage(systemName: "heart"), for: .normal)
                }
                self?.product = product
                self?.brandLabel.text = product.brand
                self?.priceLabel.text = product.price
                self?.nameLabel.text = product.name
                self?.signLabel.text = product.priceSign ?? "$"
                self?.descriptionTextView.text = product.productDescription
                
                if let str = product.imageLink{
                    let url = URL(string: str)
                    self?.brandImage.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "buymackup1"))
                }
                self?.addDynamicButton()
            }
        }
        
    }
    //MARK: -Function
    
    func configurePage(product:Product){
        brandLabel.text = product.brand
        priceLabel.text = product.price
        signLabel.text = product.priceSign
        descriptionTextView.text = product.productDescription
        if let str = product.imageLink{
            let url = URL(string: str)
            brandImage.sd_setImage(with: url, placeholderImage: UIImage(imageLiteralResourceName: "buymackup1"))
        }
        
    }
    
    func addDynamicButton(){
        var contY = 0
        var contX = 0
        guard let colors = product?.productColors else {return}
        
        if colors.count == 0{
            nameColorLabel.text = "No color"
        }
        for item in colors{
            var button = UIButton()
            button = UIButton(frame: CGRect(x: 16 + contX, y: 900 + contY, width: 55, height: 55))
            
            button.backgroundColor = UIColor(hexString: item.hexValue ?? "")
            button.layer.cornerRadius = 27
            
            button.addAction(UIAction(handler: {_ in
                self.nameColorLabel.text = item.colorName
            }), for: .touchUpInside)
            
            self.scrolView.addSubview(button)
            if contX < 300{
                contY += 0
                contX += 63
            }else{
                contY += 65
                contX = 0
            }
        }
    }
}
