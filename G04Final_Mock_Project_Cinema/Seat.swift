//
//  Seat.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/26/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

//class ghế ngôi
class Seat {
    var seatId: String
    var state: Bool
    var bookBy: String
    var bookTime: String
    
    init (bookBy: String, state: Bool, seatId: String, bookTime: String ) {
        self.seatId  = seatId
        self.state = state
        self.bookBy = bookBy
        self.bookTime = bookTime
    }
}
