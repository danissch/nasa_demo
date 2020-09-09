//
//  ApodListModel.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 6/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

class ApodListModel: NSObject {
    var apodList:[ApodModel]? = []
    
    init(apodList:[ApodModel]? = []) {
        self.apodList = apodList
    }
}
