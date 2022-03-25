//
//  FolderUseCase.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/24.
//

import Firebase
import RxSwift

struct FolderUseCase: FolderUseCaseProtocol {
    func createFolder(name: String, color: String) {
        let uuidReference = CFUUIDCreate(nil)
        let uuidStringReference = CFUUIDCreateString(nil, uuidReference)
        let uuid = uuidStringReference as String? ?? ""
        
        let itemsReference = Database.database().reference(withPath: "sangjin/folders")
        let userItemReference = itemsReference.child(uuid)
        
        let nowDate = Date()
        let values: [String: Any] = [
            "color": color,
            "createdAt": "\(nowDate)",
            "id": uuid,
            "name": name,
            "wordsCount": 0
        ]
        userItemReference.setValue(values)
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
          guard let responseValue = response.value else { return }
          folderArray.append(responseValue.mappedFolder)
        }
        
        if folderArray.count > 1 {
            folderArray.sort { first, second in
                first?.createdAt ?? "" < second?.createdAt ?? ""
            }
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
