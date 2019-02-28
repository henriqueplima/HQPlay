//
//  TesteRequest.swift
//  HQPlay
//
//  Created by Usuário Convidado on 27/02/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

class ConnectorAPI {
    
    var baseURL: String = "https://gateway.marvel.com:443/v1/public/"
    var apiKey: String = "cdb9b66985f6523d88b3b820037f895f"
    var hashString: String = "fc9bc3330d53b8b9d28c88aa707473b7"
    var timeStamp : String = "1529959176"
    var timeout : TimeInterval = 20
    
    func mountURL(_ endPoint:String) -> URLRequest {
        let url = URL(fileURLWithPath: "\(baseURL)\(endPoint)?apikey=\(apiKey)&ts=\(timeStamp)&hash=\(hashString)")
        return URLRequest(url: url)
    }
    
    func callAPI<T:Decodable>(request:RequestConnector, closure:@escaping (_ meuHQ:T) -> Void) {
        var url = mountURL(request.endPoint!)
        url.timeoutInterval = self.timeout
        url.httpMethod = request.httpMethod?.rawValue
        url.allHTTPHeaderFields = request.header
        if let parameters = request.parameters {
                url.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        }
    
        URLSession.shared.dataTask(with: url) { (responseData, httpResponse, error) in
            
            // TODO
            
            if let data = responseData {
                if let objectData = try? JSONDecoder().decode(T.self, from: data) {
                    closure(objectData)
                }
            }
        }
    }
    
    
}
