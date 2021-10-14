//
//  BrandCollectionViewController.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit

private let reuseIdentifier = "cell"

class BrandCollectionViewController: UICollectionViewController {
    
    //MARK: -Properties
    
    var deledate:BrandCollectionViewControllerDelegate?
    let brandImage:[UIImage] = [#imageLiteral(resourceName: "almay1"),#imageLiteral(resourceName: "anna sui"),#imageLiteral(resourceName: "annabelle"),#imageLiteral(resourceName: "benefit1"),#imageLiteral(resourceName: "c'est_moi2"),#imageLiteral(resourceName: "cargocosmetics"),#imageLiteral(resourceName: "clinique"),#imageLiteral(resourceName: "colourpop1"),#imageLiteral(resourceName: "covergirl"),#imageLiteral(resourceName: "dior"),#imageLiteral(resourceName: "dr.hauschka"),#imageLiteral(resourceName: "e.l.f.2"),#imageLiteral(resourceName: "glossier"),#imageLiteral(resourceName: "l'oreal"),#imageLiteral(resourceName: "lotus_cosmeticsusa"),#imageLiteral(resourceName: "marcelle"),#imageLiteral(resourceName: "marienatie"),#imageLiteral(resourceName: "maybelline"),#imageLiteral(resourceName: "milani"),#imageLiteral(resourceName: "mineral fusion"),#imageLiteral(resourceName: "nyx"),#imageLiteral(resourceName: "pacifica"),#imageLiteral(resourceName: "physicians_formula2"),#imageLiteral(resourceName: "pure_anada"),#imageLiteral(resourceName: "rejuva_minerals"),#imageLiteral(resourceName: "revlon"),#imageLiteral(resourceName: "sante"),#imageLiteral(resourceName: "smashbox"),#imageLiteral(resourceName: "stila"),#imageLiteral(resourceName: "suncoat"),#imageLiteral(resourceName: "wet_n_wild")]
    
    let brandName:[ProductBrand] = [.almay, .annaSui, .annabelle, .benefit, .cestMoi, .cargoCosmetics, .clinique, .colourpop, .covergirl, .dior, .drHauschka, .elf, .glossier, .loreal, .lotusCosmeticsUsa, .marcelle, .marienatie, .maybelline, .milani, .mineralFusion, .nyx, .pacifica, .physiciansFormula, .pureAnada, .rejuvaMinerals, .revlon, .sante, .smashbox, .stila, .suncoat, .wetNwild]
    
    //MARK: -LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "ItemCollectionViewCell", bundle: Bundle.main)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        
    }
    
    
    // MARK: -UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return brandName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        if let cell = cell as? ItemCollectionViewCell{
            cell.itemImageView.image = brandImage[indexPath.item]
            cell.populeteCell()
        }
        
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        deledate?.sendBrand(name: brandName[indexPath.row].rawValue)
    }
    
}
protocol BrandCollectionViewControllerDelegate {
    func sendBrand(name:String)
}
enum ProductBrand:String {
    case almay, annabelle, benefit, clinique, colourpop, covergirl, dior, glossier, marcelle, marienatie, maybelline, milani, nyx, pacifica, revlon, sante, smashbox, stila, suncoat
    case annaSui = "anna sui" ,cestMoi = "c'est moi", cargoCosmetics = "cargo cosmetics", drHauschka = "dr. hauschka", elf = "e.l.f.", loreal = "l'oreal" , lotusCosmeticsUsa = "lotus cosmetics usa", mineralFusion = "mineral fusion", physiciansFormula = "physicians formula", pureAnada = "pure anada", rejuvaMinerals = "rejuva minerals", wetNwild = "wet n wild"
}
