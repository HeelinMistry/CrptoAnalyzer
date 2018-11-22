//
//  HomeViewModel.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/10.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import Foundation
import Signals

class HomeViewModel {
    
    private var services : PublicServicesRepository = PublicServicesRepository()
    private var filtered : Bool = false
    private var homeView : HomeViewContract
    
    private var tickers : [Ticker] = []
    private var tickersFilter : [Ticker] = []
    private var searchTickers : [Ticker] = []
    
    init(view : HomeViewContract) {
        self.homeView = view
        self.subscribeToPublicServiceData()
    }
    
    func loadScreenContent(){
        self.services.getTickerData()
    }
    
    private func subscribeToPublicServiceData() {
        self.services.onTickerData.subscribe(with: self) {(data, error) in
            if let _ = error{
                
            } else {
                self.tickers = data
                self.tickers = self.tickers.sorted(by: { $0.toName < $1.toName })
            }
            self.homeView.populateWithTickers()
        }
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filtered = searchText.count>0
        
        searchTickers = tickersFilter.filter({( ticker : Ticker) -> Bool in
            return ticker.toName.lowercased().contains(searchText.lowercased())
        })
        
        self.homeView.filterWithTickers()
    }
    
    func getTickerCount() -> Int {
        if(filtered){
            return searchTickers.count
        }
        return tickersFilter.count
    }
    
    func isTickerData() -> Bool {
        return !tickers.isEmpty
    }
    
    func filterTickerData(value : String){
        tickersFilter = tickers.filter({
            $0.fromName == value
        })
    }
    
    func getFromCurrencies() -> [String]{
        let currencies = self.tickers.sorted(by: { $0.fromName > $1.fromName })
        
        var counts = [String: Int]()
        currencies.forEach{ counts[$0.fromName] = (counts[$0.fromName] ?? 0) + 1}
        return counts.sorted(by: {$0.1 > $1.1}).map({
            return $0.0
        })
    }
    
    func getTickersForDisplay(index : Int) -> TickerDisplay {
        if(filtered){
            return TickerDisplay(ticker: searchTickers[index])
        }
        return TickerDisplay(ticker: tickersFilter[index])
    }

}
