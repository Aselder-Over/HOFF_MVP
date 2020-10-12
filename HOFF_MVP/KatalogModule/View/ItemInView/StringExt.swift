//
//  StringExt.swift
//  HOFF_MVP
//
//  Created by Асельдер on 17.09.2020.
//  Copyright © 2020 Асельдер. All rights reserved.
//

import UIKit

extension String {

    //Перечеркнутый символ
func strikeThrough() -> NSAttributedString {
  let attributeString = NSMutableAttributedString(string: self)
  attributeString.addAttribute(
    NSAttributedString.Key.strikethroughStyle,
    value: 1,
    range: NSRange(location: 0, length: attributeString.length))

    return attributeString
   }
 }

//Пробел после тыссячи
struct Number {
    static let formatterWithSepator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = " "
        formatter.numberStyle = .decimal
        return formatter
    }()
}

extension BinaryInteger {
    var stringFormatedWithSepator: String {
        return Number.formatterWithSepator.string(from: NSNumber(value: self as! Int)) ?? ""
    }
}
