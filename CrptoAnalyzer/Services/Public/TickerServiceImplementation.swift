//
//  TickerServiceImplementation.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/04.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import Alamofire

class TickerServiceImplementation : PostService{
    
    private var tickersData : [TickerResponse] = []
    private let serviceHandler : ServiceHandler
    
    init(serviceHandler : ServiceHandler) {
        self.serviceHandler = serviceHandler
    }
    
    func getTickerData(){
        print("\(getURL())")
        makeCall()
    }
    
    override func getURL() -> String {
        return "https://poloniex.com/public?command=returnTicker"
    }
    
    override func extract(response: NSDictionary) {
        tickersData = response.map({ (key, value) -> TickerResponse in
            let dict = value as!NSDictionary
            let ticker = TickerResponse(name: key as! String,
                                        id: dict.value(forKey: "id") as! Int,
                                        last: dict.value(forKey: "last") as! String,
                                        lowestAsk: dict.value(forKey: "lowestAsk") as! String,
                                        highestBid: dict.value(forKey: "highestBid") as! String,
                                        percentChange: dict.value(forKey: "percentChange") as! String,
                                        baseVolume: dict.value(forKey: "baseVolume") as! String,
                                        quoteVolume: dict.value(forKey: "quoteVolume") as! String,
                                        isFrozen: dict.value(forKey: "isFrozen") as! String,
                                        high24Hr: dict.value(forKey: "high24hr") as! String,
                                        low24Hr: dict.value(forKey: "low24hr") as! String)
            return ticker
        })
    }
    
    override func success() {
        //delegate to other place
        serviceHandler.success(tickersResponse: tickersData)
    }
    
    override func failure(error: Error){
        //delegate to other place
        serviceHandler.failure(error: error)
    }
    
}

