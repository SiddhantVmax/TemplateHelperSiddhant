//
//  Helper.swift
//  TempHelper
//
//  Created by admin_vserv on 20/07/20.
//  Copyright © 2020 admin_vserv. All rights reserved.
//

import Foundation

public class ServerName{
    
    public init(){}
    
    public static let shared = ServerName()
    
    public func getServerName(name: String) -> String {
        return "Server name is \(name)"
    }
}



