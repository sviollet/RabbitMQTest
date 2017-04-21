//
//  TchatDelegateProtocol.swift
//  Alarm
//
//  Created by samuel on 11/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import Foundation

protocol TchatDelegate {
    var topic: String { get set }
    func getKey() -> String
}
