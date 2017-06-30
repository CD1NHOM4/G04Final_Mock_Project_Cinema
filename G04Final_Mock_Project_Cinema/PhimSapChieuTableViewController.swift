//
//  PhimSapChieuTableViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/10/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

extension PhimSapChieuViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchMovieByName(searchBar.text!)
    }
}

extension PhimSapChieuViewController: UISearchResultsUpdating {
    // MARK: -
    func updateSearchResults(for searchController: UISearchController) {
        searchMovieByName(searchController.searchBar.text!)
    }
}


class PhimSapChieuViewController: UITableViewController {
    
    var refDatabase: DatabaseReference!
    var movies = [MovieDetail]()
    var progressDialog: MBProgressHUD!
    let searchController = UISearchController(searchResultsController: nil)
    var searchFilms = [MovieDetail]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        self.clearsSelectionOnViewWillAppear = false
        //tham chiếu đến firebase
        refDatabase = Database.database().reference()
        
        //register
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieRowCell")
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        loadData()
        //Tuy chon tim kiem
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        searchController.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController.searchBar
    }
    
    func loadData() {
        DanhSachPhimDangChieu()
    }
    
    //get list phim sắp chiếu từ database
    func DanhSachPhimDangChieu() {
        showProgress()
        refDatabase.child("movies").child("PhimSapChieu").observe(.childAdded, with: { (snapshot) -> Void in
            var movie: [String: AnyObject] = (snapshot.value as? [String: AnyObject])!
            var movieDetail = movie["movieDetail"] as? [String: AnyObject]
            //Lấy data chứa trong movieDetail
            let movieId: String   = movieDetail!["movieId"] as? String ?? ""
            let movieName: String = movieDetail!["movieName"] as? String ?? ""
            let posterUrl: String = movieDetail!["posterUrl"] as? String ?? ""
            let actor: String     = movieDetail!["actor"] as? String ?? ""
            let director: String  = movieDetail!["director"] as? String ?? ""
            let genres: String    = movieDetail!["genres"] as? String ?? ""
            let overview: String  = movieDetail!["overview"] as? String ?? ""
            let duration: Int     = movieDetail?["duration"] as? Int ?? 0
            let voteAverage: Double = movieDetail?["voteAverage"] as? Double ?? 0
            let releaseDate: String = movieDetail!["releaseDate"] as? String ?? ""
            let trailerUrl: String  = movieDetail!["trailerUrl"] as? String ?? ""
            let movieType: String   = movieDetail!["movieType"] as? String ?? ""
            
            //khởi tạo
            let movieDetailData: MovieDetail  = MovieDetail.init(movieId: movieId, movieName: movieName, posterUrl: posterUrl, actor: actor, director: director, genres: genres, overview: overview,  duration: duration, voteAverage: voteAverage, releaseDate: releaseDate, trailerUrl: trailerUrl, movieType: movieType)
            
            //Thêm Phim vào danh sách
            self.movies.append(movieDetailData)
            
            //Add tiền trình vào main thread
            DispatchQueue.main.async {
                self.hideProgress()
                self.tableView.reloadData()
            }
        }
        )
    }
    
    //Sự kiện Click vào UserProfile icon
    @IBAction func btnUserProfileClick(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "userProfileId") as! UserProfileViewController
            present(srcUserInfo, animated: true, completion: nil)
        } else {
            let srcSignIn = self.storyboard?.instantiateViewController(withIdentifier: "logInId") as! LogInViewController
            present(srcSignIn, animated: true, completion: nil)
        }
    }
    
    //Hiện biểu tượng đợi
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang tải..."
    }
    
    //Ẩn cảnh báo đợi
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    //Hiện cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Huỷ bỏ", style: .default, handler: nil)
        
        let tryAgainAction = UIAlertAction(title: "Thử lại", style: .default, handler: { (action: UIAlertAction) in
            self.loadData()
        })
        
        alertView.addAction(cancelAction)
        alertView.addAction(tryAgainAction)
        present(alertView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (searchController.isActive && searchController.searchBar.text != "") {
            return searchFilms.count
        }
        return movies.count
    }
    
    //Đổ dữ liệu vào cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRowCell", for: indexPath) as! CustomTableViewCell
        let movieDetail: MovieDetail
        if (searchController.isActive && searchController.searchBar.text != "") {
            movieDetail = searchFilms[indexPath.row]
        }
        else {
            movieDetail = movies[indexPath.row]
        }
        cell.configWithCell(movieDetail: movieDetail)
        return cell
    }
    
    //chi tiet film
    //search
    func searchMovieByName(_ movieName: String) {
        searchFilms = movies.filter({ (movieDetail: MovieDetail) -> Bool in
            return movieDetail.movieName.lowercased().contains(movieName.lowercased())
        })
        self.tableView.reloadData()
    }
    
}
