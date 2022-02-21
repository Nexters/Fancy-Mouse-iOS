//
//  User+CoreDataProperties.swift
//  
//
//  Created by 한상진 on 2022/02/21.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var dateStringList: [String]?
    @NSManaged public var spellingList: [String]?

}
