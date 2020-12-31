//
//  AppData.swift
//  freeza
//
//  Created by Nat Sibaja on 12/29/20.
//  Copyright © 2020 Zerously. All rights reserved.
//

import Foundation

struct AppData {
    
    @Storage(key: "safe_mode", defaultValue: true)
    static var enableSafeMode: Bool
}

