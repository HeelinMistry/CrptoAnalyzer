//
//  ser.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/07.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

protocol ServiceHandler {
    func failure(error: Error)
    
//    Optional
    func success(tickersResponse: [TickerResponse])
}

extension ServiceHandler {
    
    func success(tickersResponse: [TickerResponse]){}
    
}
