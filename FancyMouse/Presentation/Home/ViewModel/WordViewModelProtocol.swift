//
//  WordViewModelProtocol.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import Foundation

protocol WordViewModelProtocol {
    func updateWord(_ word: Word)
}

protocol WordCellViewModelProtocol {
    func toggleMemorizationStatus()
}
