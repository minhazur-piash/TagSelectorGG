//
//  GGSObject.swift
//  TagSelector
//
//  Created by minhazur rahman on 1/19/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import Foundation

class GGSObject: Equatable {
    var id: Int!
    var name: String!
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    static func ==(lhs: GGSObject, rhs: GGSObject) -> Bool {
        return lhs.id == rhs.id
    }
}

class Skill: GGSObject {}

class Tags: GGSObject {}
