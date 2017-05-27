//
//  MovieDetail.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/27/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation
import UIKit

class MovieDetail {
    var movieId: String
    var movieName: String
    var posterUrl: String   //
    var actor: String       //dienvien
    var director: String    //dao dien
    var genres: String      //Thể loại phim
    var overview: String    //tong quan
    var duration: Int       //thoi luong
    var voteAverage: Double //danh gia
    var releaseDate: String //Ngày chiếu
    var trailerUrl: String
    var movieType: String //
    
    //khởi tạo
    init(movieId: String, movieName: String, posterUrl: String, actor: String, director: String,    genres: String, overview: String,  duration: Int, voteAverage: Double, releaseDate: String, trailerUrl: String, movieType: String) {
        
        self.movieId = movieId
        self.movieName = movieName
        self.posterUrl = posterUrl
        self.actor = actor
        self.director = director
        self.genres = genres
        self.overview = overview
        self.duration = duration
        self.voteAverage = voteAverage
        self.releaseDate = releaseDate
        self.trailerUrl = trailerUrl
        self.movieType = movieType
    }
}
