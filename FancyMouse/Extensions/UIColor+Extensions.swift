//
//  UIColor+Extensions.swift
//  FancyMouse
//
//  Created by seunghwan Lee on 2022/02/06.
//

import UIKit

typealias WordDetailColor = UIColor

extension UIColor {
    static let gray10 = UIColor(named: "gray10") ?? #colorLiteral(red: 0.9882352941, green: 0.9882352941, blue: 0.9882352941, alpha: 1)
    static let gray20 = UIColor(named: "gray20") ?? #colorLiteral(red: 0.9764705882, green: 0.9843137255, blue: 0.9921568627, alpha: 1)
    static let gray30 = UIColor(named: "gray30") ?? #colorLiteral(red: 0.9333333333, green: 0.9450980392, blue: 0.9568627451, alpha: 1)
    static let gray40 = UIColor(named: "gray40") ?? #colorLiteral(red: 0.8196078431, green: 0.8431372549, blue: 0.8666666667, alpha: 1)
    static let gray50 = UIColor(named: "gray50") ?? #colorLiteral(red: 0.631372549, green: 0.6705882353, blue: 0.7098039216, alpha: 1)
    static let gray60 = UIColor(named: "gray60") ?? #colorLiteral(red: 0.4078431373, green: 0.4470588235, blue: 0.5058823529, alpha: 1)
    static let gray70 = UIColor(named: "gray70") ?? #colorLiteral(red: 0.2509803922, green: 0.2941176471, blue: 0.3529411765, alpha: 1)
    static let gray80 = UIColor(named: "gray80") ?? #colorLiteral(red: 0.1725490196, green: 0.2156862745, blue: 0.2784313725, alpha: 1)
    static let gray90 = UIColor(named: "gray90") ?? #colorLiteral(red: 0.09019607843, green: 0.1254901961, blue: 0.1764705882, alpha: 1)
    static let folder00 = UIColor(named: "folder00") ?? #colorLiteral(red: 0.7490196078, green: 0.8039215686, blue: 0.8705882353, alpha: 1)
    static let folder01 = UIColor(named: "folder01") ?? #colorLiteral(red: 0.2470588235, green: 0.7803921569, blue: 0.8588235294, alpha: 1)
    static let folder02 = UIColor(named: "folder02") ?? #colorLiteral(red: 0.4470588235, green: 0.7529411765, blue: 0.9921568627, alpha: 1)
    static let folder03 = UIColor(named: "folder03") ?? #colorLiteral(red: 0.568627451, green: 0.6509803922, blue: 0.9882352941, alpha: 1)
    static let folder04 = UIColor(named: "folder04") ?? #colorLiteral(red: 0.6941176471, green: 0.5882352941, blue: 0.9921568627, alpha: 1)
    static let folder05 = UIColor(named: "folder05") ?? #colorLiteral(red: 0.8941176471, green: 0.6, blue: 0.9647058824, alpha: 1)
    static let folder06 = UIColor(named: "folder06") ?? #colorLiteral(red: 0.9607843137, green: 0.6470588235, blue: 0.7607843137, alpha: 1)
    static let folder07 = UIColor(named: "folder07") ?? #colorLiteral(red: 0.9882352941, green: 0.5333333333, blue: 0.5333333333, alpha: 1)
    static let folder08 = UIColor(named: "folder08") ?? #colorLiteral(red: 1, green: 0.7568627451, blue: 0.4666666667, alpha: 1)
    static let folder09 = UIColor(named: "folder09") ?? #colorLiteral(red: 1, green: 0.8941176471, blue: 0.4588235294, alpha: 1)
    static let folder10 = UIColor(named: "folder10") ?? #colorLiteral(red: 0.7450980392, green: 0.8588235294, blue: 0.5176470588, alpha: 1)
    static let folder11 = UIColor(named: "folder11") ?? #colorLiteral(red: 0.4549019608, green: 0.8549019608, blue: 0.662745098, alpha: 1)
    static let folderBorder = UIColor(named: "folderBorder") ?? #colorLiteral(red: 0.8823529412, green: 0.8980392157, blue: 0.9176470588, alpha: 1)
    static let primaryColor = UIColor(named: "primary") ?? #colorLiteral(red: 0.1607843137, green: 0.1843137255, blue: 0.2156862745, alpha: 1)
    static let primaryWeek = UIColor(named: "primary_week") ?? #colorLiteral(red: 0.8588235294, green: 0.8745098039, blue: 0.8980392157, alpha: 1)
    static let primaryDark = UIColor(named: "primary_dark") ?? #colorLiteral(red: 0.09803921569, green: 0.1058823529, blue: 0.1176470588, alpha: 1)
    static let secondaryColor = UIColor(named: "secondary") ?? #colorLiteral(red: 0.9176470588, green: 1, blue: 0.6823529412, alpha: 1)
    static let secondaryWeek = UIColor(named: "secondary_week") ?? #colorLiteral(red: 0.9607843137, green: 1, blue: 0.8470588235, alpha: 1)
    static let secondaryDark = UIColor(named: "secondary_dark") ?? #colorLiteral(red: 0.8156862745, green: 0.8980392157, blue: 0.5803921569, alpha: 1)
    static let explainColor = UIColor(named: "explain") ?? #colorLiteral(red: 0.08235294118, green: 0.1019607843, blue: 0.1294117647, alpha: 1)
    static let gradientEnd = UIColor(named: "gradient_end") ?? #colorLiteral(red: 0.3891513646, green: 0.4650174975, blue: 0.2865740061, alpha: 1)
    static let gradientBack = UIColor(named: "gradient_back") ?? #colorLiteral(red: 0.07226986438, green: 0.1028464511, blue: 0.1279123127, alpha: 1)
    
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
