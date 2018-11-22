//
//  TickerResponse.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/04.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import UIKit

class TickerResponse {
    
    private (set) var name: String
    private (set) var id: Int
    private (set) var last: Decimal
    private (set) var lowestAsk: Decimal
    private (set) var highestBid: Decimal
    private (set) var percentChange: Decimal
    private (set) var baseVolume: Decimal
    private (set) var quoteVolume: Decimal
    private (set) var isFrozen: Bool
    private (set) var high24Hr: Decimal
    private (set) var low24Hr: Decimal
    
        
    init(name: String, id: Int, last: String, lowestAsk: String, highestBid: String, percentChange: String, baseVolume: String, quoteVolume: String, isFrozen: String, high24Hr: String, low24Hr: String) {
        self.name = name
        self.id = id
        self.last = last.toDecimal()
        self.lowestAsk = lowestAsk.toDecimal()
        self.highestBid = highestBid.toDecimal()
        self.percentChange = percentChange.toDecimal()
        self.baseVolume = baseVolume.toDecimal()
        self.quoteVolume = quoteVolume.toDecimal()
        self.isFrozen = isFrozen == "0" ? false : true
        self.high24Hr = high24Hr.toDecimal()
        self.low24Hr = low24Hr.toDecimal()
    }
    
}
