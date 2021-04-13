//
//  ConnectorNetWorkProtocol.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit
import Alamofire

enum ServiceResult<T> {
    case Success(T)
    case Error(String, Int?)
}

protocol ConnectorRequestProtocol {
    
    var baseURL: String { get }
    var apiKey: String { get }
    var hashString: String { get }
    var timeStamp: String { get }
    
    func request(_ request: RequestProtocol, complete: @escaping ( ServiceResult<Data> ) -> Void )
    func downloadHqCover(url:String, complete:@escaping (ServiceResult<Data?>) -> Void)
}

