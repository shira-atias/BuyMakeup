//
//  ProductColorD+CoreDataProperties.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 01/08/2021.
//
//

import Foundation
import CoreData


extension ProductColorD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductColorD> {
        return NSFetchRequest<ProductColorD>(entityName: "ProductColorD")
    }

    @NSManaged public var colorName: String?
    @NSManaged public var hexValue: String?

}

extension ProductColorD : Identifiable {

}
