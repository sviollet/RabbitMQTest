//
//  UsersDataSourceProtocol.swift
//  Alarm
//
//  Created by samuel on 06/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation


protocol UsersDataSourceProtocol {
    
    func load(completionHandler:@escaping ([(key: String, value: User)]) -> Void)
    
    func getUsers() -> [(key: String, value: User)]
    
}
