//
//  FolderResponse.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/23.
//

import Foundation

typealias FolderResponseList = [String: FolderResponse?]

struct FolderResponse: Decodable {
    let color: FolderColorResponse
    let createdAt, folderID, folderName: String
    let words: [WordList]?
    let wordsCount: Int

    enum CodingKeys: String, CodingKey {
        case color, createdAt, words, wordsCount
        case folderID = "id"
        case folderName = "name"
    }

    var mappedFolder: Folder {
        Folder(
            folderID: folderID,
            folderColor: color.mappedFolderColor,
            folderName: folderName,
            wordCount: wordsCount
        )
    }

    //TODO: 일단 간단한 방어코드 넣어놓고 추후 리팩토링 예정
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        folderID = try container.decode(String.self, forKey: .folderID) //TODO: 추후 FolderID 타입으로 반영 예정
        folderName = try container.decode(String.self, forKey: .folderName)
        createdAt = try container.decode(String.self, forKey: .createdAt)
        color = (try? container.decode(FolderColorResponse.self, forKey: .color)) ?? .folder00
        words = try container.decodeIfPresent([WordList]?.self, forKey: .words) ?? []
        wordsCount = try container.decode(Int.self, forKey: .wordsCount)
    }
}

//TODO: Word 유스케이스 및 response 부분 수정 완료되면 삭제 예정
struct WordList: Decodable {
    let createdAt, folderID, id: String
    let meanings: [String]
    let memo, pronounce, spelling: String
    let synonyms: [String]

    enum CodingKeys: String, CodingKey {
        case createdAt
        case folderID = "folderId"
        case id, meanings, memo, pronounce, spelling, synonyms
    }
}

extension FolderResponse {
    enum FolderColorResponse: String, Decodable {
        case folder00, folder01, folder02, folder03, folder04,
             folder05, folder06, folder07, folder08, folder09,
             folder10, folder11
        
        var mappedFolderColor: FolderColor? {
            switch self {
            case .folder00: return .folder00
            case .folder01: return .folder01
            case .folder02: return .folder02
            case .folder03: return .folder03
            case .folder04: return .folder04
            case .folder05: return .folder05
            case .folder06: return .folder06
            case .folder07: return .folder07
            case .folder08: return .folder08
            case .folder09: return .folder09
            case .folder10: return .folder10
            case .folder11: return .folder11
            }
        }
    }
}
