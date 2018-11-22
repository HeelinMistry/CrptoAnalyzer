//
//  PublicServicesRepository.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/07.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import Signals

class PublicServicesRepository {
    let onTickerData = Signal<(data:[Ticker], error:Error?)>()
        
    func getTickerData(){
        let tickerService = TickerServiceImplementation(serviceHandler: self)
        tickerService.getTickerData()
    }
    
}

extension PublicServicesRepository : ServiceHandler {
    
    func failure(error: Error) {
        print("Request failed with error: \(error.localizedDescription)")
        self.onTickerData.fire((data:[], error:error))
    }
    
    func success(tickersResponse : [TickerResponse]) {
        var tickers : [Ticker] = []
        for ticker in tickersResponse {
            tickers.append(Ticker(ticker: ticker))
        }
        self.onTickerData.fire((data:tickers, error:nil))
    }
    
}
