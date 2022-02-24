//
//  FolderUseCase.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/24.
//

import Firebase
import RxSwift

struct FolderUseCase: FolderUseCaseProtocol {
    func createFolder(folderName: String, folderColor: UIColor) {
        let testItemsReference = Database.database().reference(withPath: "users/sangjin/folders")
        let userItemRef = testItemsReference.child("3")
        let values: [String: Any] = [
            "color": "folder03",
            "createdAt": 12345,
            "folderId": "3",
            "folderName": "테스트폴더3"
        ]
        userItemRef.setValue(values)
    }
    
    func fetchFolder() -> Observable<[Folder]> {
        let folderList = BehaviorSubject<[Folder]>(value: [])
        var folderArray: [Folder] = []
        
        var data = Data()
        let urlString = "https://fancymouse-cb040-default-rtdb.firebaseio.com/users/sangjin/folders.json"
        guard let url = URL(string: urlString) else { return folderList }
        
        do { data = try Data(contentsOf: url) }
        catch { print(error) }
        
        guard let folderResponse = try? JSONDecoder().decode(FolderResponseList.self, from: data)
        else { return folderList }
        
        folderResponse.filter { $0 != nil }
        .forEach { response in
            if let folderData = response?.mappedFolder {
                folderArray.append(folderData)
            }
        }
        folderList.onNext(folderArray)
        return folderList
    }
    
    func update(folderID: FolderID, folderColor: String, folderName: String) {
        //TODO: 리팩 기간에 네이밍 수정 예정
        let testItemsReference = Database.database().reference(withPath: "users/sangjin/folders")
        let userItemRef = testItemsReference.child("\(folderID)")
        userItemRef.updateChildValues(["folderName": folderName, "color": folderColor])
    }
    
    func delete(_ folderID: FolderID) {
        let testItemsReference = Database.database().reference(withPath: "users/sangjin/folders")
        testItemsReference.child("\(folderID)").removeValue()
    }
}
