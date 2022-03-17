//
//  FolderUseCase.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/24.
//

import Firebase
import RxSwift

struct FolderUseCase: FolderUseCaseProtocol {
    func createFolder(foldersCount: Int, folderName: String, folderColor: String) {
        let uuidReference = CFUUIDCreate(nil)
        let uuidStringReference = CFUUIDCreateString(nil, uuidReference)
        let uuid = uuidStringReference as String? ?? ""
        
        var itemsReference = Database.database().reference(withPath: "sangjin/folders")
        var userItemReference = itemsReference.child("\(foldersCount)")
        
        let nowDate = Date()
        let values: [String: Any] = [
            "color": folderColor,
            "createdAt": "\(nowDate)",
            "id": uuid,
            "name": folderName,
            "wordsCount": 0
        ]
        userItemReference.setValue(values)
        
        itemsReference = Database.database().reference(withPath: "sangjin")
        userItemReference = itemsReference.child("foldersCount")
        userItemReference.setValue(foldersCount)
    }
    
    func fetchFolder() -> Observable<[Folder?]> {
        var folderList: Observable<[Folder?]>
        var folderArray: [Folder?] = []
        var data = Data()
        //TODO: 구글 로그인 연동 후 url 수정 예정
        let urlString = "https://fancymouse-cb040-default-rtdb.firebaseio.com/sangjin/folders.json"
        guard let url = URL(string: urlString) else { return Observable<[Folder?]>.of([]) }
        
        do {
            data = try Data(contentsOf: url)
        } catch {
            print(error)
        }
        
        guard let folderResponse = try? JSONDecoder().decode(FolderResponseList.self, from: data)
        else { return Observable<[Folder?]>.of([]) }
        
        folderResponse.forEach { response in
            folderArray.append(response.mappedFolder)
        }
        
        if folderArray.count < 12 {
            folderArray.append(nil)
        }
        
        folderList = Observable<[Folder?]>.of(folderArray)
        return folderList
    }
    
    func update(folderID: FolderID, folderColor: String, folderName: String) {
        //TODO: 작업 예정
    }
    
    func delete(_ folderID: String) {
        //TODO: 작업 예정
        
//        let reference = Database.database().reference(withPath: "sangjin/folders")
//        reference.observeSingleEvent(of: .value, with: { snapshot in
//            snapshot.children.forEach {
//                guard let snap = $0 as? DataSnapshot else { return }
//                guard let dictionary = snap.value as? NSDictionary else { return }
//
//                if dictionary["id"] as? String == folderID {
//                    reference.child(snap.key).removeValue()
//                    return
//                }
//            }
//        })
    }
}
