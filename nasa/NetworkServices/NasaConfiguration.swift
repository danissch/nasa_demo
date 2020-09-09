//
//  NasaConfiguration.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 5/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

class NasaConfiguration {
    static let shared = NasaConfiguration()
    private let api_key = "TTeZX0LKh8YrLFt56qB5eujOZxCeTfT122jevSHW"
    
    func get_api_key() -> String{
        return api_key
    }
}
