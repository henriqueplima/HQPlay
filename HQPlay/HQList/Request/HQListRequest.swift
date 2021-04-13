//
//  HQListRequest.swift
//  HQPlay
//
//  Created by Henrique Lima on 12/04/21.
//  Copyright © 2021 Henrique Pereira de Lima. All rights reserved.
//

import Foundation
import Alamofire

struct HQListRequest: RequestProtocol {
    
    var parameters: [String : Any]? {
        ["limit":50, "orderBy":"modified"]
    }
    
    var endPoint: String {
        "comics"
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    
}
