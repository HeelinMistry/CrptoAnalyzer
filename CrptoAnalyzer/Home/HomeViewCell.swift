//
//  HomeViewCell.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/12.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import UIKit

class HomeViewCell : UITableViewCell {
   
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var high: UILabel!
    @IBOutlet weak var low: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
//        self.contentView.layer.sublayers?.forEach {
//            $0.removeFromSuperlayer()
//        }
        self.name.text = ""
        self.fullName.text = ""
        self.price.text = ""
        self.fullName.text = ""
        self.high.text = ""
        self.low.text = ""
    }
    
    func setDisplayValues(value : TickerDisplay) {
        self.name.text = value.toName
        setPriceString(percentage: value.percentChange, price: value.last)
        self.percentage.text = value.percentChange.toPercentage()
        self.fullName.text = localizedString(forKey: value.toName)
        self.high.text = value.high24Hr
        self.low.text = value.low24Hr
    }
    
    func setPriceString(percentage : String, price : String){
        if let value = Double(percentage){
            if (value < 0.0){
                self.percentage.textColor = UIColor(red:0.80, green:0.00, blue:0.00, alpha:1.0)
            } else if (value > 0.0) {
                self.percentage.textColor = UIColor(red:0.00, green:0.60, blue:0.00, alpha:1.0)
            }
        }
        if let priceValue = Double(price){
            self.price.text = String(format: "%.6f", priceValue)
        }
    }
    
    func localizedString(forKey key: String) -> String {
        var result = Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        
        if result == key {
            result = Bundle.main.localizedString(forKey: key, value: nil, table: "Names")
        } 
        
        return result
    }
}
