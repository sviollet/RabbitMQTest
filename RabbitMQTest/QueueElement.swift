//
//  QueueElement.swift
//  Alarm
//
//  Created by samuel on 30/03/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit

class QueueElement: NSObject {

    var _message : String = ""
    var _datetime : Date
    var _from : String = ""
    
    init(message: String, dateTime: Date, from: String) {
        
        _message = message
        _datetime = dateTime
        _from = from
        
        super.init()
    }
    
}
