//
//  QueueHistory.swift
//  Alarm
//
//  Created by samuel on 30/03/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit

class QueueHistory: NSObject {
    
    var _history: [String: [QueueElement]] = [:]
    
    override init() {
        
        super.init()
    }
    
    func addQueue(queue: String) {
        
        if (self._history[queue] == nil) {
            self._history.updateValue([], forKey: queue)
        }
    }
    
    func addElement(queue: String, message: String) {
        
        let element: QueueElement = QueueElement(message: message, dateTime: Date(), from: "root");
        self.addElement(queue: queue, element: element)
        
    }
    
    func addElement(queue: String, element: QueueElement) {
        
        var elements = self._history[queue]
        
        if (elements == nil) {
            self.addQueue(queue: queue)
            self.addElement(queue: queue, element: element)
            return ()
        }
        
        elements?.append(element)
        
        self._history.updateValue(elements!, forKey: queue)
        
    }
    
    func getMessage(queue: String) -> [QueueElement] {
        
        return (self._history[queue] != nil) ? self._history[queue]! : []
        
    }
    
    func deleteAll(queue: String) {
        
        self._history.updateValue([], forKey: queue)
        
    }

}
