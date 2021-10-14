//
//  Product.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 31/07/2021.
//

import UIKit
struct Product: Codable {
    let id: Int
    let brand, name, price: String?
    let priceSign: String?
    let imageLink: String?
    let productLink: String?
    let productDescription: String?
    let productType: ProductType?
    let productColors: [ProductColor]?

    enum CodingKeys: String, CodingKey {
        case id, brand, name, price
        case priceSign = "price_sign"
        case imageLink = "image_link"
        case productLink = "product_link"
        case productDescription = "description"
        case productType = "product_type"
        case productColors = "product_colors"
        
    }
    
     init(productD:ProductD) {
        self.id = Int(productD.id)
        self.brand = productD.brand
        self.name = productD.name
        self.price = productD.price
        self.priceSign = productD.priceSign
        self.imageLink = productD.imageLink
        self.productLink = ""
        self.productDescription = productD.productDescription
        if let color = productD.productColor {
        self.productColors = Array(_immutableCocoaArray: color)
        }else {
            self.productColors = []
        }
        self.productType = nil
    }
}
struct ProductColor: Codable {
    let hexValue, colorName: String?

    enum CodingKeys: String, CodingKey {
        case hexValue = "hex_value"
        case colorName = "colour_name"
    }
}
enum ProductType: String, Codable {
    case blush = "blush"
    case bronzer = "bronzer"
    case eyebrow = "eyebrow"
    case eyeliner = "eyeliner"
    case eyeshadow = "eyeshadow"
    case foundation = "foundation"
    case lipLiner = "lip_liner"
    case lipstick = "lipstick"
    case mascara = "mascara"
    case nailPolish = "nail_polish"
}
