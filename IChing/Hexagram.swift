//
//  Hexagram.swift
//  IChing
//
//  Created by Michael Berkowitz on 1/26/16.
//  Copyright © 2016 Michael Berkowitz. All rights reserved.
//

import Foundation
import Alamofire
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
    
    class func fetchHexagrams(success: (hexagrams: [Hexagram]) -> Void) {
        Alamofire.request(.GET, "https://verdant-meadow-71296.herokuapp.com/api/v1/hexagrams")
            .responseJSON { response in
                if let JSONString = response.result.value {
                    let hexagrams = Mapper<Hexagram>().mapArray(JSONString) as [Hexagram]!
                    success(hexagrams: hexagrams)
                } else {
                    print("failed")
                }
        }
    }
    
    class func fetchHexagram(kingWenNumber: Int, success: (hexagram: Hexagram) -> Void) {
        Alamofire.request(.GET, "https://verdant-meadow-71296.herokuapp.com/api/v1/hexagrams/\(kingWenNumber)")
            .responseJSON { response in
                if let JSONString = response.result.value {
                    let hexagram = Mapper<Hexagram>().map(JSONString) as Hexagram!
                    success(hexagram: hexagram)
                } else {
                    print("failed")
                }
        }
    }
}
