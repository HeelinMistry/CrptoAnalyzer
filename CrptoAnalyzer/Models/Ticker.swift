//
//  Ticker.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/07.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import UIKit

class Ticker {
    var fromName: String
    var toName: String
    var id: Int
    var last: Decimal
    var lowestAsk: Decimal
    var highestBid: Decimal
    var percentChange: Decimal
    var baseVolume: Decimal
    var quoteVolume: Decimal
    var isFrozen: Bool
    var high24Hr: Decimal
    var low24Hr: Decimal
    
    init(ticker : TickerResponse) {
        self.fromName = ""
        self.toName = ""
        if let point = ticker.name.index(of: "_"){
            let indexFromText = ticker.name.index(ticker.name.startIndex, offsetBy:point.encodedOffset - 1)
            let indexToText = ticker.name.index(point, offsetBy: 1)
            
            self.fromName = String(ticker.name[...indexFromText])
            self.toName = String(ticker.name[indexToText...])
        }
        self.id = ticker.id
        self.last = ticker.last
        self.lowestAsk = ticker.lowestAsk
        self.highestBid = ticker.highestBid
        self.percentChange = ticker.percentChange
        self.baseVolume = ticker.baseVolume
        self.quoteVolume = ticker.quoteVolume
        self.isFrozen = ticker.isFrozen
        self.high24Hr = ticker.high24Hr
        self.low24Hr = ticker.low24Hr
    }
    
}
