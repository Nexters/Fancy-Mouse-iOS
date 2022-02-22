//
//  UIColor+Extensions.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/06.
//

import UIKit

extension UIColor {
    static let gray10 = UIColor(named: "gray10")
    static let gray20 = UIColor(named: "gray20")
    static let gray30 = UIColor(named: "gray30")
    static let gray40 = UIColor(named: "gray40")
    static let gray50 = UIColor(named: "gray50")
    static let gray60 = UIColor(named: "gray60")
    static let gray70 = UIColor(named: "gray70")
    static let gray80 = UIColor(named: "gray80")
    static let gray90 = UIColor(named: "gray90")
    static let folder00 = UIColor(named: "folder00")
    static let folder01 = UIColor(named: "folder01")
    static let folder02 = UIColor(named: "folder02")
    static let folder03 = UIColor(named: "folder03")
    static let folder04 = UIColor(named: "folder04")
    static let folder05 = UIColor(named: "folder05")
    static let folder06 = UIColor(named: "folder06")
    static let folder07 = UIColor(named: "folder07")
    static let folder08 = UIColor(named: "folder08")
    static let folder09 = UIColor(named: "folder09")
    static let folder10 = UIColor(named: "folder10")
    static let folder11 = UIColor(named: "folder11")
    static let folderBorder = UIColor(named: "folderBorder")
    static let primaryColor = UIColor(named: "primary")
    static let primaryWeek = UIColor(named: "primary_week")
    static let primaryDark = UIColor(named: "primary_dark")
    static let secondaryColor = UIColor(named: "secondary")
    static let secondaryWeek = UIColor(named: "secondary_week")
    static let secondaryDark = UIColor(named: "secondary_dark")
    
    var name: String? {
        switch self {
        case UIColor.folder00: return "folder00"
        case UIColor.folder01: return "folder01"
        case UIColor.folder02: return "folder02"
        case UIColor.folder03: return "folder03"
        case UIColor.folder04: return "folder04"
        case UIColor.folder05: return "folder05"
        case UIColor.folder06: return "folder06"
        case UIColor.folder07: return "folder07"
        case UIColor.folder08: return "folder08"
        case UIColor.folder09: return "folder09"
        case UIColor.folder10: return "folder10"
        case UIColor.folder11: return "folder11"
        default: return nil
        }
    }
}
