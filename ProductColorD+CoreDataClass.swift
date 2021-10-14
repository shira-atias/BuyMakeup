//
//  ProductColorD+CoreDataClass.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 01/08/2021.
//
//

import Foundation
import CoreData

@objc(ProductColorD)
public class ProductColorD: NSManagedObject {
    
    convenience init(productColor:ProductColor){
           self.init(context:CoreDataManager.shared.context)
           self.hexValue = productColor.hexValue ?? ""
           self.colorName = productColor.colorName ?? ""
       }

}
