//
//  User+CoreDataProperties.swift
//  
//
//  Created by 한상진 on 2022/02/21.
//
//

import CoreData
import Foundation

extension SearchDataList {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<SearchDataList> {
        return NSFetchRequest<SearchDataList>(entityName: "SearchDataList")
    }

    @NSManaged public var spelling: String?
    @NSManaged public var searchDate: String?
}
