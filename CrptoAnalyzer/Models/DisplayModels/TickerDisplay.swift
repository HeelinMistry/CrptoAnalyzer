//
//  TickerDisplay.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/11.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import UIKit

class TickerDisplay {
    var fromName: String
    var toName: String
    var id: String
    var last: String
    var lowestAsk: String
    var highestBid: String
    var percentChange: String
    var baseVolume: String
    var quoteVolume: String
    var isFrozen: String
    var high24Hr: String
    var low24Hr: String
    
    init(ticker : Ticker) {
        self.fromName = ticker.fromName
        self.toName = ticker.toName
        self.id = ticker.id.description
        self.last = ticker.last.description
        self.lowestAsk = ticker.lowestAsk.description
        self.highestBid = ticker.highestBid.description
        self.percentChange = ticker.percentChange.description
        self.baseVolume = ticker.baseVolume.description
        self.quoteVolume = ticker.quoteVolume.description
        self.isFrozen = ticker.isFrozen.description
        self.high24Hr = ticker.high24Hr.description
        self.low24Hr = ticker.low24Hr.description
    }
    
}
