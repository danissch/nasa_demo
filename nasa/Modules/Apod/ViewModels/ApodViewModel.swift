//
//  ApodViewModel.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 6/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

protocol ApodViewModelDelegate {
    func apodRequestFinished(apodlist:[ApodModel]?)
}

class ApodViewModel {
    let apodService = ApodService.get
    var listenerApod:((ApodModelRes) -> Void)?
    var listenerSingleApod:((ApodModelRes) -> Void)?
    var apodlist:[ApodModel]? = []
    var delegate:ApodViewModelDelegate?
    var counter:Int = 0
    func requestApod(date:String = "", hd:Bool=false){
        if let responseValue = listenerApod {
            apodService.getApod(date: date,
                                hd: hd,
                                api_key: NasaConfiguration.shared.get_api_key(),
                                responseValue: responseValue)
        }
    }
    
    func requestSingleApod(date:String = "", hd:Bool=false){
        if let responseValue = listenerSingleApod {
            apodService.getApod(date: date, hd: hd, api_key: NasaConfiguration.shared.get_api_key(), responseValue: responseValue)
        }
    }
    
    func fillApodList(){
        listenerApod = { apodRes in
            print("appflow:: counter:A: \(self.counter)")
            if let apodItem = apodRes as ApodModelRes? {
                self.apodlist?.append(ApodModel(copyright: apodItem.copyright, date: apodItem.date, explanation: apodItem.explanation, hdurl: apodItem.hdurl, media_type: apodItem.media_type, service_version: apodItem.service_version, title: apodItem.title, url: apodItem.url))
                self.counter = self.counter + 1
            }
            print("appflow:: counter:B: \(self.counter)")
            if self.counter == ApodManager.get.numOfLastDays{
                self.delegate?.apodRequestFinished(apodlist: self.apodlist)
            }
        }
    }
    func requestApodList(){
        for singleDate in ApodManager.get.get_last_days() {
            requestApod(date: singleDate, hd: false)
        }
    }
}
