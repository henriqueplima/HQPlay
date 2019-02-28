//
//  ListRequest.swift
//  HQPlay
//
//  Created by Usuário Convidado on 27/02/19.
//  Copyright © 2019 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

class ListRequest: RequestConnector {
    
   override var endPoint: String? {
          return  "meu endPoint"
    }
    
    override var parameters: [String : Any]? {
        return ["limit" : 50]
    }
    
    
    
}
