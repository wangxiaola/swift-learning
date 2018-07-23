//
//  ScenicSpotMode.swift
//  jrtt
//
//  Created by 王小腊 on 2018/7/23.
//  Copyright © 2018年 王小腊. All rights reserved.
//

import UIKit
import ObjectMapper

class ScenicSpotMode: Mappable {
    
    var number: String = ""
    var root: [ScenicRoot] = []
    var score: Int16 = 0
    var snum: Int16 = 0
    var total: Int16 = 0
    
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        number <- map["number"]
        root <- map["root"]
        score <- map["score"]
        snum <- map["snum"]
        total <- map["total"]
    }
    
    
}

class ScenicRoot: Mappable {
    
    var address: String = ""
    var allimg: String = ""
    var buynum: String = ""
    var earnings: String = ""
    var info: String = ""
    var id: String = ""
    var logo: String = ""
    var name: String = ""
    var linestime: String = ""
    
    required init?(map: Map) {
        
    }
    
     func mapping(map: Map) {
        
        address <- map["address"]
        allimg <- map["allimg"]
        buynum <- map["buynum"]
        earnings <- map["earnings"]
        info <- map["info"]
        id <- map["id"]
        logo <- map["logo"]
        name <- map["name"]
        linestime <- map["linestime"]
    }
    
    
}
