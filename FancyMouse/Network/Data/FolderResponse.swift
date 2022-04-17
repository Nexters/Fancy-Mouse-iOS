//
//  FolderResponse.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/23.
//

import Foundation

typealias FolderResponseList = [String: FolderResponse?]

struct FolderResponse: Decodable {
    let folderID: FolderID
    let color, createdAt, folderName: String
    let words: [WordList]?
    let wordsCount: Int

    enum CodingKeys: String, CodingKey {
        case color, createdAt, words, wordsCount
        case folderID = "id"
        case folderName = "name"
    }

    //TODO: 일단 간단한 방어코드 넣어놓고 추후 리팩토링 예정
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        folderID = try container.decode(FolderID.self, forKey: .folderID) //TODO: 추후 FolderID 타입으로 반영 예정
        folderName = try container.decode(String.self, forKey: .folderName)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        color = try container.decode(String.self, forKey: .color)
        words = try container.decodeIfPresent([WordList]?.self, forKey: .words) ?? []
        wordsCount = try container.decode(Int.self, forKey: .wordsCount)
    }
}

//TODO: Word 유스케이스 및 response 부분 수정 완료되면 삭제 예정
struct WordList: Decodable {
    let createdAt, folderID, id: String
    let meanings: [String]
    let memo: String?
    let pronounce, spelling: String
    let synonyms: [String]

    enum CodingKeys: String, CodingKey {
        case createdAt
        case folderID = "folderId"
        case id, meanings, memo, pronounce, spelling, synonyms
    }
}
