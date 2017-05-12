//
//  DataSource.swift
//  Alarm
//
//  Created by samuel on 30/03/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit
import RMQClient

class DataSource: NSObject {
    
    private var ip: String = ""
    private var port: String = ""
    private var _url: String {
        
        get {
            
            return String(format: "amqp://admin:admin@%@:%@", self.ip, self.port)
        }
    }
    
    public static let KEY_ROOT: String = "Tchat"
    public static let KEY_MESSAGE: String = "Message"
    
    //=== PRIVATE ====================================
    private static let EXCHANGE: String = "Tchat"
    private let _queue: String
    private let _exchange: String
    private let _history: QueueHistory = QueueHistory()
    private var _conn: RMQConnection = RMQConnection()
    //================================================
    
    //=== PUBLIC =====================================
    public var Queue: String {
        get { return _queue }
    }
    
    public var Exchange: String {
        get { return self._exchange }
    }
    
    //================================================
    
    override init() {
        
        self._exchange = DataSource.EXCHANGE
        self._queue = AlarmeSystem.shared.user
        
        self.ip = UserDefaults.standard.string(forKey: "adress_preference")!
        self.port = UserDefaults.standard.string(forKey: "port_preference")!
        
        super.init()
    }
    
    func sendRequest(_ message: String, routingKey: String) {
        
        print("Attempting to connect to local RabbitMQ broker")
        
        let conn = RMQConnection(uri: _url, delegate: RMQConnectionDelegateLogger())
        
        conn.start()
        
        let ch = conn.createChannel()
        let x = ch.topic(self._exchange)
        
        
        var userProperty = RMQValue()
        
        
        
        
        //userProperty.setValue("test", forKey: "user_id")
        
        let test = AlarmHelper()
        test.test()
        
        //x.publish(message.data(using: .utf8), routingKey: routingKey, properties: [userProperty])
        
        x.publish(message.data(using: .utf8), routingKey: routingKey)
        
        
        defer {
            conn.close()
        }
    }
    
    func receive(withHistory: Bool, routingKey: [String], completionHandler:@escaping (QueueElement) -> Void) {
        
        print("Attempting to connect to local RabbitMQ broker")
        
        self._conn = RMQConnection(uri: _url, delegate: RMQConnectionDelegateLogger())
        self._conn.start()
        let ch = self._conn.createChannel()
        let x = ch.topic(self._exchange)
        let q = ch.queue(_queue, options: .exclusive)
        

        for key: String in routingKey {
            q.bind(x, routingKey: key)
        }

        
        print("Waiting for messages. \(self._exchange) \(self._queue)")
        q.subscribe({(_ message: RMQMessage) -> Void in
            
            
            //message.properties.
            
            let element: QueueElement = QueueElement(message: String(data: message.body, encoding: .utf8)!, dateTime: Date(), from: "root")
            
            if (withHistory) {
                self._history.addElement(queue: self._queue, element: element)
            }
            
            DispatchQueue.main.sync() {
                completionHandler(element)
            }
            
        })
    }
    
    func dispose() {
        
        _conn.close()
    }
    
}
