//
//  UsersDataSourceMock.swift
//  Alarm
//
//  Created by samuel on 06/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation
import Dip

class UsersDataSourceMock : UsersDataSourceProtocol {
    
    //var _users: [User] = []
    var _users: [(key: String, value: User)] = []
    
    init() { }
    
    func load(completionHandler:@escaping ([(key: String, value: User)]) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            self._users.append((key: "*", value:User(uid:1, name:"Global")))
            self._users.append((key: "topic1", value:User(uid:1, name:"Topic 1")))
            self._users.append((key: "topic2", value:User(uid:1, name:"Topic 2")))
            self._users.append((key: "topic3", value:User(uid:1, name:"Topic 3")))
            self._users.append((key: "topic4", value:User(uid:1, name:"Topic 4")))
            self._users.append((key: "topic5", value:User(uid:1, name:"Topic 5")))
            self._users.append((key: "topic6", value:User(uid:1, name:"Topic 6")))
            
            completionHandler(self._users)
        }
    }
    
    func getUsers() -> [(key: String, value: User)] {
        
        return self._users.sorted(by: {$0.0 < $1.0})
    }
    
}
