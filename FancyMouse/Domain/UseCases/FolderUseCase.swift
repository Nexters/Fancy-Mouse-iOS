//
//  FolderUseCase.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/24.
//

import Firebase
import RxSwift

struct FolderUseCase: FolderUseCaseProtocol {
    func createFolder(name: String, color: String) -> Observable<Folder> {
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
        
        let folderObservable = Observable<Folder>.create { createResponse in
            userItemReference.setValue(values) { error, reference in
                if let error = error {
                    print(error)
                } else {
                    var data = Data()
                    guard let url = URL(string: "\(reference.url).json") else { return }
                    do {
                        data = try Data(contentsOf: url)
                    } catch {
                        print(error)
                    }

                    guard let folderResponse = try? JSONDecoder().decode(
                        FolderResponse.self,
                        from: data
                    ) else { return }
                    
                    let folder = Folder(
                        folderID: folderResponse.folderID,
                        folderColor: folderResponse.color,
                        folderName: folderResponse.folderName,
                        wordCount: folderResponse.wordsCount,
                        createdAt: folderResponse.createdAt
                    )
                    createResponse.onNext(folder)
                }
            }
            return Disposables.create()
        }
        return folderObservable
    }
    
    func fetchFolder() -> Observable<[Folder?]> {
        var folders = Folders()
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
            let folder = Folder(
                folderID: responseValue.folderID,
                folderColor: responseValue.color,
                folderName: responseValue.folderName,
                wordCount: responseValue.wordsCount,
                createdAt: responseValue.createdAt
            )
            folders.add(folder)
        }
        
        return Observable<[Folder?]>.of(folders.values)
    }
    
    func update(folderID: String, folderColor: String, folderName: String) -> Observable<Folder> {
        //TODO: 구글 로그인 연동 후 path 수정 예정
        let itemsReference = Database.database().reference(withPath: "sangjin/folders")
        let userItemReference = itemsReference.child(folderID)
        let folderObservable = Observable<Folder>.create { updateResponse in
            userItemReference.updateChildValues([
                "name": folderName,
                "color": folderColor
            ]) { error, reference in
                if let error = error {
                    print(error)
                } else {
                    var data = Data()
                    guard let url = URL(string: "\(reference.url).json") else { return }
                    do {
                        data = try Data(contentsOf: url)
                    } catch {
                        print(error)
                    }

                    guard let folderResponse = try? JSONDecoder().decode(
                        FolderResponse.self,
                        from: data
                    ) else { return }
                    
                    let folder = Folder(
                        folderID: folderResponse.folderID,
                        folderColor: folderResponse.color,
                        folderName: folderResponse.folderName,
                        wordCount: folderResponse.wordsCount,
                        createdAt: folderResponse.createdAt
                    )
                    updateResponse.onNext(folder)
                }
            }
            return Disposables.create()
        }
        
        return folderObservable
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
