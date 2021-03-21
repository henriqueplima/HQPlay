//
//  HQListViewModel.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

struct HQListViewModel {
    
    init(hq: HQ) {
        self.hq = hq
    }
    
    private var hq: HQ
    
    var image: UIImage?
    var title: String {
        return hq.title
    }
    
    func publishDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM yyyy"
        guard let date = formatter.date(from: hq.publishDate ?? "") else {
            return "no date"
        }
        return formatter.string(from: date)
    }
}
