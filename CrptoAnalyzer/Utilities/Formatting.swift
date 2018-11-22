//
//  Formatting.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/07.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//
import UIKit

extension String {
    func toDecimal() -> Decimal{
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        guard let value = formatter.number(from: self) else {
            return 0.0
        }
        return value.decimalValue
    }
    
    func toPercentage() -> String{
        if var value = Double(self) {
            value *= 100.0
            return String(format: "%.2f%%", abs(value))
        } else {
            return ""
        }
    }
    
    func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "Default")
        }
        
        return result
    }
}

extension Array where Element: Equatable{
    func deduplicate() -> [Element]{
        return reduce([Element]()) { (accumulation: [Element], find: Element) -> [Element] in
            guard accumulation.index(of: find) == nil else {return accumulation}
            return accumulation + [find]
        }
    }
}
