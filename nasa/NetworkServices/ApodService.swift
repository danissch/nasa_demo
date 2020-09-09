//
//  ApodService.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 4/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Alamofire

class ApodService {
    static let get = ApodService()
    
    func getApod(date:String, hd:Bool, api_key:String, responseValue: @escaping(ApodModelRes) -> Void){
        let queryParams = ["date":date, "hd":String(hd), "api_key":api_key]
        let url = ApodApi.apodUrl
        ApiAdapter.get.requestResponse(url: url, queryParams: queryParams){
            (response:AFDataResponse<ApodModelRes>) in
            if let value = response.value{
                responseValue(value)
            }
        }
    }
    
}
