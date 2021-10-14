//
//  ProductD+CoreDataClass.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 01/08/2021.
//
//

import Foundation
import CoreData

@objc(ProductD)
public class ProductD: NSManagedObject {
    
    convenience init(product:Product){
         self.init(context:CoreDataManager.shared.context)
         self.id = Int32(product.id)
         self.brand = product.brand ?? ""
         self.name = product.name ?? ""
         self.price = product.price ?? ""
        self.priceSign = product.priceSign ?? ""
         self.imageLink = product.imageLink ?? ""
        self.productDescription = product.productDescription ?? ""
        let colors = product.productColors?.compactMap { color in
             ProductColorD(context: CoreDataManager.shared.context)
        }
        if let colors = colors{
            let set  = NSSet(array: colors)
            self.productColor = set
        }
    }

}
