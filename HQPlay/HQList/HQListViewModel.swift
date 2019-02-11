//
//  HQListViewModel.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

enum ImageResul<T> {
    case Success(T)
    case Error()
    
    var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Error:
            return false
        }
    }
}

class HQListViewModel: NSObject {
    
    let connector : ConnectorRequestProtocol = ConnectorRequest()
    let endPoint = "comics"
    var hqList : [HQ] = []
    
    
    func downloadCover(url: String, complete: @escaping (ImageResul<Data?>) -> Void) {
        connector.downloadHqCover(url: url) { (responseData) in
            
            switch responseData {
                case .Success(let imageData, let statusCode):
                    if let data = imageData {
                        return complete(.Success(data))
                    }
                    return complete(.Error())
                case .Error(_ , _):
                    complete(.Error())
            }
            
        }
    }
    
    func fetchHQList(complete: @escaping (ServiceResult<[HQ]?>) -> Void){
        
        let param = ["limit":50]
        connector.request(endPoint: endPoint, method: .get, parameters: param) { (result) in
            
            switch result{
                
            case .Success(let json, let statusCode):
                
                do {
                    if let data = json {
                        let decoder = JSONDecoder()
                        let hqResponse = try decoder.decode(HQResponse.self, from: data)
                        self.hqList = hqResponse.data.results
                        return complete(.Success(self.hqList, statusCode))
                    }
                     return complete(.Error(GeneralError.serviceConnection.localizedDescription, statusCode))
                } catch {
                    return complete(.Error(GeneralError.serviceConnection.localizedDescription, statusCode))
                }
                
            case .Error(let message, let statusCode):
                return complete(.Error(message,statusCode))
            }
            
        }
        
    }

}
