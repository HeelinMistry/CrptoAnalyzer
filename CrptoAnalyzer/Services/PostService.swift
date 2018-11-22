//
//  PostService.swift
//  CrptoAnalyzer
//
//  Created by Heelin Mistry on 2018/09/07.
//  Copyright © 2018 Heelin Mistry. All rights reserved.
//

import Foundation
import Alamofire

class PostService {
        
    internal func makeCall() {
        Alamofire.request(
            getURL(),
            method: .post,
            encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let JSON):
                    let response = JSON as! NSDictionary
                    self.extract(response : response)
                    self.success()
                case .failure(let error):
                    self.failure(error: error)
                }
        }
        
    }
    
    internal func getURL() -> String {
        fatalError("Implement this method")
    }
    
    internal func extract(response : NSDictionary) {
        fatalError("Implement this method")
    }
    
    internal func success() {
        fatalError("Implement this method")
    }
    
    internal func failure(error : Error) {
        fatalError("Implement this method")
    }
    
}
