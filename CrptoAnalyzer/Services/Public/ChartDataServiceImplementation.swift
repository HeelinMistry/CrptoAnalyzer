//
//  ChartDataServiceImplementation.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/07.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import Alamofire

class ChartDataServiceImplementation : PostService{
    
    func getChartData(currencyPair : String){
        makeCall()
    }
    
    override func getURL() -> String {
        return ""
    }
    
    override func extract(response: NSDictionary) {
       
    }
    
    override func success() {
        //delegate to other place
    }
    
    override func failure(error: Error){
        //delegate to other place
    }
    
}

