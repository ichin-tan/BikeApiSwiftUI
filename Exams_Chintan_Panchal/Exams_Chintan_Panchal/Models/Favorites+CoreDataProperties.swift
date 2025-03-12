//
//  Favorites+CoreDataProperties.swift
//  Exams_Chintan_Panchal
//
//  Created by CP on 12/03/25.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var city: String?
    @NSManaged public var companies: String?

}

extension Favorites : Identifiable {

}
