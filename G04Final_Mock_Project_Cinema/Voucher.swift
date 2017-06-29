//
//  Voucher.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/28/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

class Voucher {
    var voucherId: String
    var cost: Double
    var endTime: String
    var state: Bool
    
    init (voucherId: String,cost: Double, endTime: String, state: Bool) {
        self.voucherId  = voucherId
        self.cost = cost
        self.state = state
        self.endTime = endTime
    }
}
