//
//  UsersDataSource.swift
//  Alarm
//
//  Created by samuel on 06/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation


class UsersDataSource : UsersDataSourceProtocol{
    
    var _users: [(key: String, value: User)] = []
    
    init() { }
    
    func load(completionHandler:@escaping ([(key: String, value: User)]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            self._users.append((key: "tchat.topic1", value:User(uid:1, name:"Topic 1")))
            
            completionHandler(self._users)
        }
    }
    
    func getUsers() -> [(key: String, value: User)] {
        
        return self._users
    }
    
}
