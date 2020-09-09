//
//  ApodManager.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 6/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

class ApodManager {
    static let get = ApodManager()
    let numOfLastDays = 8
    private var lastDays: [String] = []
    
    func get_last_days() -> [String]{
        lastDays = Date.getDates(forLastNDays: numOfLastDays)
        debugPrint(lastDays)
        return lastDays
    }
    
}
