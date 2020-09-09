//
//  ApodModelRes.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 6/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

class ApodModelRes:Decodable {
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: String?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url:String?
    
    enum CodingKeys:String, CodingKey {
        case copyright, date, explanation, hdurl, media_type, service_version, title, url
    }
}
