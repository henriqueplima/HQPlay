//
//  HQListBussiness.swift
//  HQPlay
//
//  Created by Henrique Lima on 21/03/21.
//  Copyright © 2021 Henrique Pereira de Lima. All rights reserved.
//

import Foundation

class HQListBussiness {
    
    let connector: ConnectorRequestProtocol = ConnectorRequest()
    let endPoint = "comics"
    var hqList: [HQ] = []
    var viewController: HQListControllerProtocol?
    
    func fetchHQList() {
        LoadingView.shared.show()
        let request = HQListRequest()
        connector.request(request) { [weak self] (result) in
            guard let self = self else { return }
            defer { LoadingView.shared.close() }
            switch result {
                
            case .Success(let data):
                
                do {
                    let decoder = JSONDecoder()
                    let hqResponse = try decoder.decode(HQResponse.self, from: data)
                    self.hqList = hqResponse.data.results
                    let viewModelList = self.hqList.map(HQListViewModel.init)
                    self.viewController?.successHQList(list: viewModelList)
                } catch {
                    self.viewController?.genericError()
                }
                
            case .Error(let message, let statusCode):
                self.viewController?.genericError()
            }
            
        }
        
    }

}
