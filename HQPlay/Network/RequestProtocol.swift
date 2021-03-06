//
//  RequestProtocol.swift
//  HQPlay
//
//  Created by Usuário Convidado on 27/02/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

public enum HTTPMethod2: String {
    case get = "GET"
    case post = "POST"
}

protocol RequestProtocol {
    
    var header : [String:String]? {get}
    var parameters : [String: Any]? {get}
    var endPoint : String? {get}
    var httpMethod : HTTPMethod2? {get}
}
