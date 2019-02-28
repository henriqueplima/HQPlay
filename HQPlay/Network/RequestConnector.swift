//
//  RequestConnector.swift
//  HQPlay
//
//  Created by Usuário Convidado on 27/02/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

class RequestConnector: RequestProtocol {
    
    var header: [String : String]? {
        return [:]
    }
    var parameters: [String : Any]? {
        return [:]
    }
    var endPoint: String? {
        return "teste"
    }
    var httpMethod: HTTPMethod2? = .get
}
