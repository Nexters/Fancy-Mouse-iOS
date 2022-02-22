//
//  CoreDataManager.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/21.
//

import CoreData
import UIKit

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private weak var appDelegate = UIApplication.shared.delegate as? AppDelegate
    lazy var context = appDelegate!.persistentContainer.viewContext
    lazy var searchDataList = [SearchDataList]()
    
    func fetchData() {
        let request = SearchDataList.fetchRequest()
        let sortByDateDesc = NSSortDescriptor(key: "searchDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            searchDataList = try context.fetch(request)
        } catch {
            print(error)
        }
    }
    
    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addData(spelling: String, dateString: String) {
        let newData = SearchDataList(context: context)
        newData.spelling = spelling
        newData.searchDate = dateString
        searchDataList.insert(newData, at: 0)
        saveContext()
    }
    
    func deleteData(spelling: String, dateString: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SearchDataList")
        fetchRequest.predicate = NSPredicate(format: "spelling == %@", NSString(string: spelling))
        do {
            guard let results = try context.fetch(fetchRequest) as? [SearchDataList] else { return }
            results.filter { $0.spelling == spelling }.forEach { context.delete($0) }
        } catch {
            print(error)
        }
        saveContext()
    }
}
