//
//  MovieDetailTableViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/21/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class MovieDetailTableViewController: UITableViewController {
    var movieDetail: MovieDetail!
    @IBOutlet weak var lbMovieTitle: UILabel!
    @IBOutlet weak var lbGenres: UILabel!
    @IBOutlet weak var lbFilmType: UILabel!
    @IBOutlet weak var txtvOverView: UITextView!
    
    @IBOutlet weak var lbDirector: UILabel!
    @IBOutlet weak var lbActor: UILabel!
    @IBOutlet weak var lbReleaseDay: UILabel!
    @IBOutlet weak var lbVoteAverage: UILabel!
    @IBOutlet weak var imgPoster: UIImageView!
    var type: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.clearsSelectionOnViewWillAppear = false
        //Khởi tạo
        initData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //load Data
    func initData() {
        lbMovieTitle.text = movieDetail.movieName
        lbGenres.text = movieDetail.genres
        txtvOverView.text = movieDetail.overview
        lbDirector.text = movieDetail.director
        lbActor.text = movieDetail.actor
        lbReleaseDay.text = movieDetail.releaseDate
        lbVoteAverage.text = String(movieDetail.voteAverage)
        
        if (movieDetail.movieType == "PhimDangChieu") {
            type = "Đang chiếu"
        }
        else if (movieDetail.movieType == "PhimSapChieu") {
            type = "Sắp chiếu"
        }
        else {
            type = "Đã chiếu"
        }
        lbFilmType.text = type
        imgPoster.image = Downloader.downloadImageWithURL(movieDetail.posterUrl)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if (movieDetail.movieType != "PhimDangChieu"){
            return 1
        }
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    //chon suat chieu
    //Sự kiện chọn suất chiếu
    @IBAction func btn850(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "viewBookVe") as! BookVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "850"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1000(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "viewBookVe") as! BookVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1000"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1125(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "viewBookVe") as! BookVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1125"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1400(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "viewBookVe") as! BookVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1400"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1635(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "viewBookVe") as! BookVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1635"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
    
    @IBAction func btn1900(_ sender: Any) {
        let srcBuyTicket = self.storyboard?.instantiateViewController(withIdentifier: "viewBookVe") as! BookVeViewController
        srcBuyTicket.movieDetail = movieDetail
        srcBuyTicket.time = "1900"
        navigationController?.pushViewController(srcBuyTicket, animated: true)
    }
}
