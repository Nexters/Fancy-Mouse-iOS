//
//  MemorizationViewModel.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/01/31.
//

import Foundation

struct MemorizationStatus {
    enum Status {
        case unknown
        case memorizing
        case complete
    }

    let title: String
    let status: Status
}
