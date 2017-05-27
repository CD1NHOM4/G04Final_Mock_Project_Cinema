//
//  Movie.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/20/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

class Movie {
    var movieDetail: MovieDetail
    var showTime: ShowTime
    
    init(movieDetail: MovieDetail, showTime: ShowTime) {
        self.movieDetail = movieDetail
        self.showTime = showTime
    }
}
