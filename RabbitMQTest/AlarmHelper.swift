//
//  AlarmHelper.swift
//  RabbitMQTest
//
//  Created by samuel on 02/05/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation

class AlarmHelper {
    
    class func log(message : String) {
        // do something
    }
    
    public func test1() {
        
        
    }
    
    internal func test(){
        
    }
    
}


class MyOwnAlarmHelper : AlarmHelper{
    
    
    override class func log(message: String) {
        
        // custom do something
        
    }
    
    public func essai() {
        
        self.test()
        
    }
    
}
