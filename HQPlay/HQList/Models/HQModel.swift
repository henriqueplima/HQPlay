//
//  HQ.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

struct  HQ : Decodable {
    var title : String
    var resourceURI : String
    var pageCount : Int
    var id : Int
    var dates : [HQDates]
    var prices : [HQPrices]
    var thumbnail : HQThumbnail
    var image : Data?
    
    
    func publishDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMMM yyyy"
        if let date = formatter.date(from: dates[1].date) {
            return formatter.string(from: date)
        }
        return formatter.string(from: Date())
    }
    
}

struct HQThumbnail : Decodable {
    var path : String
    var ext : String
    var fullPath : String {
        return "\(path).\(ext)"
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
    init(path: String, ext: String) {
        self.path = path
        self.ext = ext
    }
    

}

struct HQDates : Decodable {
    var type : String
    var date : String
}

struct HQPrices : Decodable {
    var type : String
    var price : Float
}


struct HQData : Decodable {
    var results : [HQ]
}

struct HQResponse : Decodable {
    var data : HQData
    var code : Int
    var status : String
}
