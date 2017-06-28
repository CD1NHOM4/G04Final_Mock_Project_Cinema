//
//  BookVeViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/26/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import MBProgressHUD
import Firebase

class BookVeViewController: UIViewController {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lbMovieName: UILabel!
    @IBOutlet weak var lbActor: UILabel!
    @IBOutlet weak var lbBillMoney: UILabel!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbTicketNumber: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbVoucher: UILabel! //ma giam gia
    @IBOutlet weak var lbCostTotal: UILabel! //tongtien
    
    var refDatabase: DatabaseReference!
    var progressDialog: MBProgressHUD!
    
    var movieDetail: MovieDetail!
    var time: String = ""
    var ticketNumber: Int64  = 1
    var priceMovie: Int64 = 0
    var billMoney: Int64 = 0
    
    var userProfile: UserProfile!
    
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        refDatabase = Database.database().reference()
        //Gọi hàm khởi taọ dữ liệu
        initData()
    }
    //
    override func viewDidAppear(_ animated: Bool) {
        print(String(ticketNumber))
        super.viewDidAppear(true)
    }
    //
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hàm khởi tạo
    func initData() {
        loadData()
        loadDataFromDB()
    }
    
    //load data từ database
    func loadDataFromDB() {
        
        //Hiện biểu tượng đợi xử lí
        showProgress()
        refDatabase.child("movies").child("PhimDangChieu").child("1").child("showTime").child("850").child("showTimeInfo").observeSingleEvent(of: .value, with: { (snapshot) in
            
            self.hideProgress()
            if let showTimeInfo = snapshot.value as? [String: AnyObject] {
                let price = showTimeInfo["price"] as? Int64 ?? 0
                let type = showTimeInfo["type"] as? String ?? ""
                let timeShow = showTimeInfo["time"] as? String ?? ""
                
                //Load dữ liệu
                self.lbPrice.text = String(price) + "VNĐ"
                self.lbTime.text = type + " - " + timeShow
                self.priceMovie = price
                
                //load data price, tổng tiền = giá * số lượng
                self.billMoney = self.priceMovie * self.ticketNumber
                self.lbBillMoney.text = String(self.billMoney) + "VNĐ"
                
            }
        })
    }
    
    //Hàm hiện cảnh báo
    func showAlertDialogWithHandler(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Huỷ bỏ", style: .default, handler: nil)
        
        let tryAgainAction = UIAlertAction(title: "Thử lại", style: .default, handler: { (action: UIAlertAction) in
            self.initData()
        })
        
        alertView.addAction(cancelAction)
        alertView.addAction(tryAgainAction)
        present(alertView, animated: true, completion: nil)
    }
    
    //Hàm hiện cảnh báo đợi xử lí
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: self.view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang xử lí..."
    }
    
    //Hàm ẩn cảnh báo đợi xử lí
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    //Hàm load dữ liệu
    func loadData() {
        imgPoster.image = Downloader.downloadImageWithURL(movieDetail.posterUrl)
        lbMovieName.text = movieDetail.movieName
    }
    
    //Sụ kiện khi click nút giảm số vé
    @IBAction func btnMinus(_ sender: Any) {
        if (ticketNumber > 0) {
            ticketNumber = ticketNumber - 1;
            lbTicketNumber.text = String(ticketNumber)
            billMoney = priceMovie * ticketNumber
            lbBillMoney.text = String(billMoney) + "VNĐ"
        }
    }
    
    //Sự kiện khi click nút tăng số vé
    @IBAction func btnAdd(_ sender: Any) {
        ticketNumber = ticketNumber + 1;
        lbTicketNumber.text = String(ticketNumber)
        billMoney = priceMovie * ticketNumber
        lbBillMoney.text = String(billMoney) + " VNĐ"
    }
    
    //Xửu lí sự kiện khi nhấn phím Next
    @IBAction func btnNext(_ sender: Any) {
        //Kiểm tra số vé đặt phải lớn hơn 0
        if (ticketNumber > 0) {
            if Auth.auth().currentUser != nil {
                if (userProfile != nil) {
                    if (Int64(userProfile.balance) < billMoney) {
                        showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
                    }
                    else {
                        let src = self.storyboard?.instantiateViewController(withIdentifier: "chonGhe") as! LuaChonGheViewController
                        src.movieDetail = movieDetail
                        src.time = time
                        src.ticket = Int(self.ticketNumber)
                        src.billMoney = billMoney
                        src.userProfile = userProfile
                        navigationController?.pushViewController(src, animated: true)
                    }
                }
                    //nếu chưa đăng nhập
                else {
                    refDatabase.child("Acount").child(getUid()).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let user = snapshot.value as? [String: AnyObject] {
                            let fullName = user["fullname"] as? String ?? ""
                            let email = user["email"] as? String ?? ""
                            let address = user["address"] as? String ?? ""
                            let phone = user["phone"] as? String ?? ""
                            let balance = user["balance"] as? Double ?? 0
                            let score = user["score"] as? Double ?? 0
                            let password = user["password"] as? String ?? ""
                            //Khởi tạo
                            self.userProfile = UserProfile.init(userid: self.getUid(), fullName: fullName, email: email, address: address, score: score, password: password, phone: phone,balance:balance)
                            
                            //Kiểm tra tài khoản có đủ tiền thanh toán
                            if (Int64(self.userProfile.balance) < self.billMoney) {
                                self.showAlertDialog(message: "Số tiền trong tài khoản của bạn không đủ")
                            }
                            else
                                //chuyển qua màn hình đặt vé
                            {
                                let src = self.storyboard?.instantiateViewController(withIdentifier: "chonGhe") as! LuaChonGheViewController
                                
                                src.movieDetail = self.movieDetail
                                src.time = self.time
                                src.ticket = Int(self.ticketNumber)
                                src.billMoney = self.billMoney
                                src.userProfile = self.userProfile
                                self.navigationController?.pushViewController(src, animated: true)
                            }
                            
                        }
                    })
                }
            }
            else {
                
                let alertView = UIAlertController(title: "Thông Báo", message: "Bạn cần đăng nhập", preferredStyle: .alert)
                let action = UIAlertAction(title: "Chấp nhận", style: .default, handler: nil)
                let actionLogin = UIAlertAction(title: "Đăng nhập", style: .default, handler: { (action: UIAlertAction) in
                    let srcSignIn = self.storyboard?.instantiateViewController(withIdentifier: "signInId") as! LogInViewController
                    self.present(srcSignIn, animated: true, completion: nil)
                })
                alertView.addAction(action)
                alertView.addAction(actionLogin)
                self.present(alertView, animated: true, completion: nil)
                
            }
        }
            
            //Nếu số vé < 0, hiện cảnh báo
        else {
            showAlertDialog(message: "Bạn cần chọn ít nhất 1 vé")
        }
    }
    
    //Hàm show alertView
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Chấp nhận", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //Lấy mã User hiện tại
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!
    }
}
