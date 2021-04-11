//
//  HQListBussiness.swift
//  HQPlay
//
//  Created by Henrique Lima on 21/03/21.
//  Copyright © 2021 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

enum ViewResult<T> {
    case Success(T)
    case Error(String)
}

enum ImageResul<T> {
    case Success(T)
    case Error
    
    var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Error:
            return false
        }
    }
}

class HQListBussiness {
    
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
                    return complete(.Error)
                case .Error(_ , _):
                    complete(.Error)
            }
            
        }
    }
    
    func fetchHQList(complete: @escaping (ViewResult<[HQListViewModel]>) -> Void) {
        
        let param = ["limit":50]
        connector.request(endPoint: endPoint, method: .get, parameters: param) { (result) in
            
            switch result{
                
            case .Success(let json, let statusCode):
                
                do {
                    guard let data = json else {
                        return complete(.Error(GeneralError.serviceConnection.localizedDescription))
                    }
                        let decoder = JSONDecoder()
                        let hqResponse = try decoder.decode(HQResponse.self, from: data)
                        self.hqList = hqResponse.data.results
                        let viewModelList = self.hqList.map(HQListViewModel.init)
                        return complete(.Success(viewModelList))
                        //return complete(.Success(self.hqList, statusCode))
                } catch {
                    return complete(.Error(GeneralError.serviceConnection.localizedDescription))
                }
                
            case .Error(let message, let statusCode):
                return complete(.Error(message))
            }
            
        }
        
    }

}
