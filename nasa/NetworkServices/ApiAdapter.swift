//
//  ApiAdapter.swift
//  nasa
//
//  Created by Daniel Durán Schütz on 4/09/20.
//  Copyright © 2020 Daniel Durán Schütz. All rights reserved.
//

import Foundation
import Alamofire

class ApiAdapter{
    static let get = ApiAdapter()
    
    private let alamofireManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        let sessionManager = Alamofire.Session(configuration: configuration)
        return sessionManager
    }()
    
    func requestResponse<T: Decodable>(url:String,
                                       method:Alamofire.HTTPMethod = .get,
                                       queryParams:[String:String] = [:],
                                       bodyParameters:Parameters? = nil,
                                       headers:HTTPHeaders? = nil,
                                       completionHandler: @escaping(AFDataResponse<T>) -> Void){
        
        var urlComponents = URLComponents(string: url)
        
        if queryParams.count > 0 {
            let urlQueryItems = queryParams.map{URLQueryItem(name: $0.key, value: $0.value)}
            urlComponents?.queryItems = urlQueryItems
        }
        
        guard let urlConversible = urlComponents else { return }
        
        alamofireManager.request(urlConversible, method: method, parameters: bodyParameters, encoding: JSONEncoding.prettyPrinted).responseDecodable(completionHandler: completionHandler)
        
    }
    
    
    
    
}
