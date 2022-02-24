//
//  FolderResponse.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/23.
//

import Foundation

typealias FolderResponseList = [FolderResponse?]

struct FolderResponse: Decodable {
    let color: FolderColorResponse
    let createdAt, folderID: Int
    let folderName: String
    let wordList: [WordList]
    
    enum CodingKeys: String, CodingKey {
        case color, createdAt
        case folderID = "folderId"
        case folderName, wordList
    }
    
    var mappedFolder: Folder {
        Folder(folderID: folderID, folderColor: color.mappedFolderColor, folderName: folderName, wordCount: wordList.count)
    }
    
    //TODO: 일단 간단한 방어코드 넣어놓고 추후 리팩토링 예정
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        folderID = try container.decode(Int.self, forKey: .folderID)
        folderName = try container.decode(String.self, forKey: .folderName)
        createdAt = try container.decode(Int.self, forKey: .createdAt)
        color = (try? container.decode(FolderColorResponse.self, forKey: .color)) ?? .folder00
        wordList = try container.decode([WordList].self, forKey: .wordList)
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

//MARK: - 데이터구조 잡힌 뒤 삭제할 코드입니다 (임시 구조체임)
struct WordList: Codable {
    let createdAt: Int
    let examples: [String]
    let folderID: Int
    let meaning: [String]
    let memo, spelling: String
    let synonyms: [String]
    let wordID: Int

    enum CodingKeys: String, CodingKey {
        case createdAt, examples
        case folderID = "folderId"
        case meaning, memo, spelling, synonyms
        case wordID = "wordId"
    }
}
