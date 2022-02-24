//
//  CoreDataManager.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/21.
//

import CoreData
import OSLog
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    private let logger = Logger()
    
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate?.persistentContainer.viewContext
    lazy var searchDataList = [SearchDataList]()
    
    func fetchRecentSearchData() {
        let request = SearchDataList.fetchRequest()
        let sortByDateDesc = NSSortDescriptor(key: "searchDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        guard let context = context else { return }
        do {
            searchDataList = try context.fetch(request)
        } catch {
            logger.log("An error occurred!")
        }
    }
    
    func saveContext() {
        guard let context = context, context.hasChanges else { return }
        
        do {
            try context.save()
        } catch {
            logger.log("An error occurred!")
        }
    }
    
    func addRecentSearchData(spelling: String, dateString: String) {
        guard let context = context else { return }
        
        let newData = SearchDataList(context: context)
        newData.spelling = spelling
        newData.searchDate = dateString
        searchDataList.insert(newData, at: 0)
        saveContext()
    }
    
    func deleteRecentSearchData(spelling: String, dateString: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchDataList")
        fetchRequest.predicate = NSPredicate(format: "spelling == %@", NSString(string: spelling))
        
        guard let context = context else { return }
        do {
            guard let results = try context.fetch(fetchRequest) as? [SearchDataList] else { return }
            results.filter { $0.spelling == spelling }.forEach { context.delete($0) }
        } catch {
            logger.log("An error occurred!")
        }
        saveContext()
    }
}
