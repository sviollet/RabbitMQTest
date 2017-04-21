//
//  User.swift
//  Alarm
//
//  Created by samuel on 06/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation


class User: Hashable, Equatable {
    
    var uid: Int
    var name:String = ""
    
    var hashValue: Int {
        return self.uid
    }
    
    init(uid: Int, name:String = "") {
        
        self.uid = uid
        self.name = name
    }
    
}

func ==(lhs: User, rhs: User) -> Bool {
    return lhs.uid == rhs.uid
}
