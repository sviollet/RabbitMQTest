//
//  AlarmeSystem.swift
//  Alarm
//
//  Created by samuel on 04/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit

final class AlarmeSystem {

    
    static let shared: AlarmeSystem = AlarmeSystem()
    
    var user: String = ""
    var url: String = ""
    
    var userService:UsersDataSourceProtocol?
    
    private init() { }

    
}
