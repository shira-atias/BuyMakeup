//
//  ProductD+CoreDataProperties.swift
//  Buy Makeup
//
//  Created by שירה אטיאס on 01/08/2021.
//
//

import Foundation
import CoreData


extension ProductD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductD> {
        return NSFetchRequest<ProductD>(entityName: "ProductD")
    }

    @NSManaged public var id: Int32
    @NSManaged public var brand: String?
    @NSManaged public var imageLink: String?
    @NSManaged public var name: String?
    @NSManaged public var price: String?
    @NSManaged public var priceSign: String?
    @NSManaged public var productDescription: String?
    @NSManaged public var productColor: NSSet?

}

// MARK: Generated accessors for productColor
extension ProductD {

    @objc(addProductColorObject:)
    @NSManaged public func addToProductColor(_ value: ProductColorD)

    @objc(removeProductColorObject:)
    @NSManaged public func removeFromProductColor(_ value: ProductColorD)

    @objc(addProductColor:)
    @NSManaged public func addToProductColor(_ values: NSSet)

    @objc(removeProductColor:)
    @NSManaged public func removeFromProductColor(_ values: NSSet)

}

extension ProductD : Identifiable {

}
