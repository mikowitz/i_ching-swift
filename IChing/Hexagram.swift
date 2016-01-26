//
//  Hexagram.swift
//  IChing
//
//  Created by Michael Berkowitz on 1/26/16.
//  Copyright © 2016 Michael Berkowitz. All rights reserved.
//

import Foundation
import ObjectMapper

class Hexagram : Mappable {
    var englishName : String!
    var chineseName : String!
    var kingWenNumber: Int!
    
    required init?(_ map: Map) {
        
    }
    
    func mapping(map: Map) {
        englishName <- map["english_name"]
        chineseName <- map["chinese_name"]
        kingWenNumber <- map["king_wen_number"]
    }
}
