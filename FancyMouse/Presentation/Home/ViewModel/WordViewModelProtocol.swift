//
//  WordViewModelProtocol.swift
//  FancyMouse
//
//  Created by itzel.du on 2022/02/25.
//

import Foundation

protocol ViewModelBindable {
    func bindViewModel()
}

protocol WordViewModelProtocol: ViewModelBindable {
    func updateWord(_ word: Word)
}

protocol WordCellViewModelProtocol: ViewModelBindable {
    func updateWord(_ word: Word)
}

