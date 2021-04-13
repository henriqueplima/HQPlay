//
//  ConnectorRequest.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit
import Alamofire


enum GeneralError : Error {
    case serviceConnection
    case emptyFields
    case invalidPassword
    case invalidUsername
    var localizedDescription: String {
        switch self {
        case .serviceConnection:
            return "Estamos melhorando nosso serviço, tente novamente mais tarde"
        case .emptyFields:
            return "Preencha os campos login e password antes de fazer o logon"
        case .invalidPassword:
            return "Password deve contar pelo menos um caracter especial e um caracter em maiusculo"
        case .invalidUsername:
            return "CPF ou e-mail invalido"
            
        }
    }
    
}

class ConnectorRequest: NSObject, ConnectorRequestProtocol {
    
    static let shared = ConnectorRequest()
    private let cache = NSCache<NSString, NSData>()
    internal let baseURL: String = "https://gateway.marvel.com:443/v1/public/"
    internal let apiKey: String = "cdb9b66985f6523d88b3b820037f895f"
    internal let hashString: String = "fc9bc3330d53b8b9d28c88aa707473b7"
    internal let timeStamp : String = "1529959176"
    
    func mountURL(_ endPoint:String) -> String{
        return "\(baseURL)comics?apikey=\(apiKey)&ts=\(timeStamp)&hash=\(hashString)"
    }
    
    func request(_ request: RequestProtocol, complete: @escaping (ServiceResult<Data>) -> Void) {
        
        let url = mountURL(request.endPoint)
        
        Alamofire.request(url, method: request.httpMethod, parameters: request.parameters, headers: request.header).validate().responseData {  (response) in
            let statusCode = response.response?.statusCode ?? 0
            if response.result.isSuccess, let data = response.result.value {
                return  complete(.Success(data))
            }
            
            return complete(.Error(GeneralError.serviceConnection.localizedDescription, statusCode))
        }
    }
    
    func downloadHqCover(url:String, complete:@escaping (ServiceResult<Data?>) -> Void) {
        
        if let data = cache.object(forKey: url as NSString) as Data? {
            return complete(.Success(data))
        }
        
        Alamofire.request(url).validate().responseData { (responseData) in
            let statusCode = responseData.response?.statusCode ?? 0
            if responseData.result.isSuccess, let data = responseData.result.value {
                self.cache.setObject(data as NSData, forKey: url as NSString)
                return  complete(.Success(responseData.result.value))
            }
            return complete(.Error(GeneralError.serviceConnection.localizedDescription, statusCode))
        }
    }
    

}
