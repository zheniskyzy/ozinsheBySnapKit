//
//  Genre.swift
//  OzinsheBySnapKit
//
//  Created by Madina Olzhabek on 20.02.2024.
//

import Foundation
import SwiftyJSON

class Genre{
    public var id: Int = 0
    public var name: String = ""
    public var link: String = ""
    
    init(){
        
    }
    
    init(json: JSON){
        if let temp = json["id"].int {
            self.id = temp
        }
        if let temp = json["name"].string {
            self.name = temp
        }
        if let temp = json["link"].string {
            self.link = temp
        }
    }
}
