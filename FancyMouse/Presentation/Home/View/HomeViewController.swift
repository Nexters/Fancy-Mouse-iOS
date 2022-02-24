//
//  HomeViewController.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/01/22.
//

import Firebase
import UIKit

class HomeViewController: UIViewController {
    var folder: Folder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("😭")
        guard
            let jsonData = loadUrlData(),
            let folderResponse = try? JSONDecoder().decode(FolderResponseList.self, from: jsonData)
        else { return }
        folderResponse.filter { $0 != nil }
        .forEach { response in
            if let folderData = response?.mappedFolder {
                print(folderData)
            }
        }
        print("😭😭😭😭😭😭😭😭")

//        let testItemsReference = Database.database().reference(withPath: "users/sangjin/folders")
//        let userItemRef = testItemsReference.child("3")
//        let values: [String: Any] = [
//            "color": "folder03",
//            "createdAt": 12345,
//            "folderId": "3",
//            "folderName": "테스트폴더3"
//        ]
//        userItemRef.setValue(values)
    }
    
    private func loadUrlData() -> Data? {
        let url = "https://fancymouse-cb040-default-rtdb.firebaseio.com/users/sangjin/folders.json"
        do {
            let data = try Data(contentsOf: URL(string: url)!)
            return data
        } catch {
            return nil
        }
    }
}
