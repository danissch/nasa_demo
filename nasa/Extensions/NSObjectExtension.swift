//
//  NSObjectExtension.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 7/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation

extension NSObject {
    @objc class var stringRepresentation:String {
        let name = String(describing: self)
        return name
    }
}

