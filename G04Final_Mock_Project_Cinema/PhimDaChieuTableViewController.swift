//
//  PhimDaChieuTableViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/1/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

extension PhimDaChieuTableViewController: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        searchMovieByName(searchBar.text!)
    }
}

extension PhimDaChieuTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        searchMovieByName(searchController.searchBar.text!)
    }
}

class PhimDaChieuTableViewController: UITableViewController {
    
    var refDatabase: DatabaseReference!
    var movies = [MovieDetail]()
    var progressDialog: MBProgressHUD!
    var searchMovies = [MovieDetail]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //khởi tạo đối tượng chứa các message cảnh báo
    let notifyMessage = NotifyMessage.init()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tham chiếu lên firebase
        refDatabase = Database.database().reference()
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false
        loadData()
        
        //Register
        tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieRowCell")
        //Tuy chon tim kiem
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false;
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    func loadData() {
        //kiểm tra kết nối
        if(Validate.isConnectedToNetwork())
        {
            LayPhimDaChieu()
        }
        else{
            
            showAlertDialog(message: notifyMessage.noInternet)
        }
    }
    
    func LayPhimDaChieu() {
        //Hiện cảnh báo đợi
        showProgress()
        refDatabase.child("movies").child("PhimDaChieu").observe(.childAdded, with: { (snapshot) -> Void in
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
            
            //thêm movie vào danh sách
            self.movies.append(movieDetailData)
            
            //đưa tiến trình vào main thread
            DispatchQueue.main.async {
                self.hideProgress()
                self.tableView.reloadData()
            }
        })
    }
    
    //Sự kiện khi click btnUserProfile
    @IBAction func btnUserProfileClick(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "viewUserProfile") as! UserProfileViewController
            present(srcUserInfo, animated: true, completion: nil)
        } else {
            let srcSignIn = self.storyboard?.instantiateViewController(withIdentifier: "viewDangNhap") as! LogInViewController
            present(srcSignIn, animated: true, completion: nil)
        }
    }
    
    //Hàm Hiện cảnh báo đợi
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = notifyMessage.isLoading
    }
    
    //Hàm ẩn cảnh báo đợi
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    //Hàm hiện cảnh báo
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
            return searchMovies.count
        }
        return movies.count
    }
    
    //load data into cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieRowCell", for: indexPath) as! CustomTableViewCell
        let movieDetail: MovieDetail
        if (searchController.isActive && searchController.searchBar.text != "") {
            movieDetail = searchMovies[indexPath.row]
        }
        else {
            movieDetail = movies[indexPath.row]
        }
        cell.configWithCell(movieDetail: movieDetail)
        return cell
    }
    
    //chức năng chi tiết phim...
    //Sự kiện click cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let srcDetailMovie = self.storyboard?.instantiateViewController(withIdentifier: "viewMovieDetail") as! MovieDetailTableViewController
        let movieDetail: MovieDetail
        if (searchController.isActive && searchController.searchBar.text! != "") {
            movieDetail = searchMovies[indexPath.row]
        }
        else {
            movieDetail = movies[indexPath.row]
        }
        
        srcDetailMovie.movieDetail = movieDetail
        navigationController?.pushViewController(srcDetailMovie, animated: true)
    }
    
    //Tìm kiếm phim
    func searchMovieByName(_ movieName: String) {
        searchMovies = movies.filter({ (movieDetail: MovieDetail) -> Bool in
            return movieDetail.movieName.lowercased().contains(movieName.lowercased())
        })
        self.tableView.reloadData()
    }
}
