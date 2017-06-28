//
//  ChonGheViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 6/25/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class LuaChonGheViewController: UIViewController {
    
    @IBOutlet weak var btnA10: CustomDesignButton!
    @IBOutlet weak var btnA9: CustomDesignButton!
    @IBOutlet weak var btnA8: CustomDesignButton!
    @IBOutlet weak var btnA7: CustomDesignButton!
    @IBOutlet weak var btnA6: CustomDesignButton!
    @IBOutlet weak var btnA5: CustomDesignButton!
    @IBOutlet weak var btnA4: CustomDesignButton!
    @IBOutlet weak var btnA3: CustomDesignButton!
    @IBOutlet weak var btnA2: CustomDesignButton!
    @IBOutlet weak var btnA1: CustomDesignButton!
    
    @IBOutlet weak var btnB10: CustomDesignButton!
    @IBOutlet weak var btnB9: CustomDesignButton!
    @IBOutlet weak var btnB8: CustomDesignButton!
    @IBOutlet weak var btnB7: CustomDesignButton!
    @IBOutlet weak var btnB6: CustomDesignButton!
    @IBOutlet weak var btnB5: CustomDesignButton!
    @IBOutlet weak var btnB4: CustomDesignButton!
    @IBOutlet weak var btnB3: CustomDesignButton!
    @IBOutlet weak var btnB2: CustomDesignButton!
    @IBOutlet weak var btnB1: CustomDesignButton!
    
    @IBOutlet weak var btnC10: CustomDesignButton!
    @IBOutlet weak var btnC9: CustomDesignButton!
    @IBOutlet weak var btnC8: CustomDesignButton!
    @IBOutlet weak var btnC7: CustomDesignButton!
    @IBOutlet weak var btnC6: CustomDesignButton!
    @IBOutlet weak var btnC5: CustomDesignButton!
    @IBOutlet weak var btnC4: CustomDesignButton!
    @IBOutlet weak var btnC3: CustomDesignButton!
    @IBOutlet weak var btnC2: CustomDesignButton!
    @IBOutlet weak var btnC1: CustomDesignButton!
    
    
    var refDatabase: DatabaseReference!
    var movieDetail: MovieDetail!
    var time: String = ""
    var seats = [Seat]()
    var ticket: Int = 0
    var progressDialog: MBProgressHUD!
    var listPlaces = [String]()
    var billMoney: Int64  = 0
    var userProfile: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tham chiếu database
        refDatabase = Database.database().reference()
        //
        loadData()
        print(time + "/"+String(ticket))
    }
    
    //set orientation: portrait
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    //reset orientation
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    //load data tùw database
    func loadData() {
        //Hiện thông báo Đợi
        showProgress()
    refDatabase.child("movies").child("PhimDangChieu").child("1").child("showTime").child("850").child("seat").observe(.childAdded, with: { (snapshot) in
            //Ẩn thông báo Đợi
            self.hideProgress()
            let seatInfo = snapshot.value as? [String: AnyObject]
            let seatKey = snapshot.key
        
            //Tạo mới, điền giá trị cho 1 vị trí ghế ngồi
            let bookBy = seatInfo?["bookBy"] as? String ?? ""
            let state = seatInfo?["state"] as? Bool ?? false
            let bookTime = seatInfo?["bookTime"] as? String ?? ""
            let seat = Seat.init(bookBy: bookBy, state: state, seatId: seatKey,bookTime: bookTime)
            
            //Thêm 1 object seat vào danh sách seats
            self.seats.append(seat)
        
            //đánh dấu ghế đã chọn,
            for seatData in self.seats {
                switch String(seatData.seatId)!
                {
                case "A1":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA1.isUserInteractionEnabled = false
                        self.btnA1.backgroundColor = UIColor.blue
                        self.btnA1.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "A2":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA2.isUserInteractionEnabled = false
                        self.btnA2.backgroundColor = UIColor.blue
                        self.btnA2.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "A3":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA3.isUserInteractionEnabled = false
                        self.btnA3.backgroundColor = UIColor.blue
                        self.btnA3.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "A4":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA4.isUserInteractionEnabled = false
                        self.btnA4.backgroundColor = UIColor.blue
                        self.btnA4.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "A5" :
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA5.isUserInteractionEnabled = false
                        self.btnA5.backgroundColor = UIColor.blue
                        self.btnA5.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "A6":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA6.isUserInteractionEnabled = false
                        self.btnA6.backgroundColor = UIColor.blue
                        self.btnA6.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "A7":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA7.isUserInteractionEnabled = false
                        self.btnA7.backgroundColor = UIColor.blue
                        self.btnA7.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                case "A8":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA8.isUserInteractionEnabled = false
                        self.btnA8.backgroundColor = UIColor.blue
                        self.btnA8.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                case "A9" :
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA9.isUserInteractionEnabled = false
                        self.btnA9.backgroundColor = UIColor.blue
                        self.btnA9.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                case "A10" :
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnA10.isUserInteractionEnabled = false
                        self.btnA10.backgroundColor = UIColor.blue
                        self.btnA10.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B1":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB1.isUserInteractionEnabled = false
                        self.btnB1.backgroundColor = UIColor.blue
                        self.btnB1.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B2":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB2.isUserInteractionEnabled = false
                        self.btnB2.backgroundColor = UIColor.blue
                        self.btnB2.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B3":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB3.isUserInteractionEnabled = false
                        self.btnB3.backgroundColor = UIColor.blue
                        self.btnB3.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B4":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB4.isUserInteractionEnabled = false
                        self.btnB4.backgroundColor = UIColor.blue
                        self.btnB4.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B5":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB5.isUserInteractionEnabled = false
                        self.btnB5.backgroundColor = UIColor.blue
                        self.btnB5.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B6":
                    
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB6.isUserInteractionEnabled = false
                        self.btnB6.backgroundColor = UIColor.blue
                        self.btnB6.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B7":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB7.isUserInteractionEnabled = false
                        self.btnB7.backgroundColor = UIColor.blue
                        self.btnB7.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B8":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB8.isUserInteractionEnabled = false
                        self.btnB8.backgroundColor = UIColor.blue
                        self.btnB8.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B9":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB9.isUserInteractionEnabled = false
                        self.btnB9.backgroundColor = UIColor.blue
                        self.btnB9.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "B10":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnB10.isUserInteractionEnabled = false
                        self.btnB10.backgroundColor = UIColor.blue
                        self.btnB10.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C1":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC1.isUserInteractionEnabled = false
                        self.btnC1.backgroundColor = UIColor.blue
                        self.btnC1.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C2":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC2.isUserInteractionEnabled = false
                        self.btnC2.backgroundColor = UIColor.blue
                        self.btnC2.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C3":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC3.isUserInteractionEnabled = false
                        self.btnC3.backgroundColor = UIColor.blue
                        self.btnC3.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C4":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC4.isUserInteractionEnabled = false
                        self.btnC4.backgroundColor = UIColor.blue
                        self.btnC4.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C5":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC5.isUserInteractionEnabled = false
                        self.btnC5.backgroundColor = UIColor.blue
                        self.btnC5.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C6":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC6.isUserInteractionEnabled = false
                        self.btnC6.backgroundColor = UIColor.blue
                        self.btnC6.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C7" :
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC7.isUserInteractionEnabled = false
                        self.btnC7.backgroundColor = UIColor.blue
                        self.btnC7.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C8" :
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC8.isUserInteractionEnabled = false
                        self.btnC8.backgroundColor = UIColor.blue
                        self.btnC8.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C9":
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC9.isUserInteractionEnabled = false
                        self.btnC9.backgroundColor = UIColor.blue
                        self.btnC9.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                    
                case "C10" :
                    let state: Bool = seatData.state
                    if (state) {
                        self.btnC10.isUserInteractionEnabled = false
                        self.btnC10.backgroundColor = UIColor.blue
                        self.btnC10.setTitleColor(UIColor.white, for: UIControlState.normal)
                    }
                    break;
                default:
                    break;
                }
            }
        })
    }
    //Hàm hiện thông báo Đợi
    func showProgress() {
        progressDialog = MBProgressHUD.showAdded(to: view, animated: true)
        progressDialog.mode = MBProgressHUDMode.indeterminate
        progressDialog.label.text = "Đang lấy thông tin ghế..."
    }
    
    //Hàm ẩn thông báo Đợi
    func hideProgress() {
        progressDialog.hide(animated: true)
    }
    
    //Sự kiện khi chọn button, từ A1 dến A10 có tag từ 1 đến 10
    @IBAction func btnAActionClick(_ sender: CustomDesignButton) {
        switch (sender.tag) {
        case 1:
            if ticket > 0 || btnA1.backgroundColor == UIColor.green
            {
                if btnA1.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế đã đặt ra khỏi list
                    if let index = listPlaces.index(of: "A1") {
                        listPlaces.remove(at: index)
                    }
                    //Tăng số vé
                    ticket += 1
                    btnA1.backgroundColor = UIColor.clear
                    self.btnA1.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //Lưu vị trí đặt chỗ mới vào list danh sách đặt ghế
                    listPlaces.append("A1");
                    //xoá vé
                    ticket -= 1
                    self.btnA1.backgroundColor = UIColor.green
                    self.btnA1.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }
            break;
        case 2:
            if ticket > 0 || btnA2.backgroundColor == UIColor.green {
                if btnA2.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A2") {
                        listPlaces.remove(at: index)
                    }
                    ticket += 1
                    btnA2.backgroundColor = UIColor.clear
                    self.btnA2.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A2");
                    
                    
                    ticket -= 1
                    self.btnA2.backgroundColor = UIColor.green
                    self.btnA2.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }
            break;
        case 3:
            if ticket > 0 || btnA3.backgroundColor == UIColor.green
            {
                if btnA3.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A3") {
                        listPlaces.remove(at: index)
                    }
                    
                    
                    ticket += 1
                    btnA3.backgroundColor = UIColor.clear
                    self.btnA3.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A3");
                    
                    ticket -= 1
                    self.btnA3.backgroundColor = UIColor.green
                    self.btnA3.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }
            break;
            
        case 4:
            if ticket > 0 || btnA4.backgroundColor == UIColor.green
            {
                if btnA4.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A4") {
                        listPlaces.remove(at: index)
                    }
                    ticket += 1
                    btnA4.backgroundColor = UIColor.clear
                    self.btnA4.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A4");
                    
                    ticket -= 1
                    self.btnA4.backgroundColor = UIColor.green
                    self.btnA4.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }
            break;
            
        case 5:
            if ticket > 0 || btnA5.backgroundColor == UIColor.green
            {
                if btnA5.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A5") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnA5.backgroundColor = UIColor.clear
                    self.btnA5.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A5");
                    
                    ticket -= 1
                    self.btnA5.backgroundColor = UIColor.green
                    self.btnA5.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 6:
            if ticket > 0 || btnA6.backgroundColor == UIColor.green
            {
                if btnA6.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A6") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnA6.backgroundColor = UIColor.clear
                    self.btnA6.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A6");
                    
                    ticket -= 1
                    self.btnA6.backgroundColor = UIColor.green
                    self.btnA6.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 7:
            if ticket > 0 || btnA7.backgroundColor == UIColor.green {
                if btnA7.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A7") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnA7.backgroundColor = UIColor.clear
                    self.btnA7.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A7");
                    
                    ticket -= 1
                    self.btnA7.backgroundColor = UIColor.green
                    self.btnA7.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            };break;
            
        case 8:
            if ticket > 0 || btnA8.backgroundColor == UIColor.green {
                if btnA8.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A8") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnA8.backgroundColor = UIColor.clear
                    self.btnA8.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A8");
                    
                    ticket -= 1
                    self.btnA8.backgroundColor = UIColor.green
                    self.btnA8.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 9:
            if ticket > 0 || btnA9.backgroundColor == UIColor.green {
                if btnA9.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A9") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnA9.backgroundColor = UIColor.clear
                    self.btnA9.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A9");
                    
                    ticket -= 1
                    self.btnA9.backgroundColor = UIColor.green
                    self.btnA9.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            };break;
            
        case 10:
            if ticket > 0 || btnA10.backgroundColor == UIColor.green {
                if btnA10.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "A10") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnA10.backgroundColor = UIColor.clear
                    self.btnA10.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("A10");
                    
                    ticket -= 1
                    self.btnA10.backgroundColor = UIColor.green
                    self.btnA10.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        default: break;
        }
    }
    
    ////Sự kiện khi chọn button, từ B1 dến B10 có tag từ 11 đến 20
    @IBAction func btnBActionClick(_ sender: CustomDesignButton) {
        switch (sender.tag)
        {
        case 11:
            if ticket > 0 || btnB1.backgroundColor == UIColor.green
            {
                if btnB1.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B1") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB1.backgroundColor = UIColor.clear
                    self.btnB1.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B1");
                    
                    ticket -= 1
                    self.btnB1.backgroundColor = UIColor.green
                    self.btnB1.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            };break;
            
        case 12:
            if ticket > 0 || btnB2.backgroundColor == UIColor.green {
                if btnB2.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B2") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB2.backgroundColor = UIColor.clear
                    self.btnB2.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B1");
                    
                    ticket -= 1
                    self.btnB2.backgroundColor = UIColor.green
                    self.btnB2.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            };break;
            
        case 13:
            if ticket > 0 || btnB3.backgroundColor == UIColor.green
            {
                if btnB3.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B3") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB3.backgroundColor = UIColor.clear
                    self.btnB3.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B3");
                    
                    ticket -= 1
                    self.btnB3.backgroundColor = UIColor.green
                    self.btnB3.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 14:
            if ticket > 0 || btnB4.backgroundColor == UIColor.green
            {
                if btnB4.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B4") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB4.backgroundColor = UIColor.clear
                    self.btnB4.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B4");
                    
                    ticket -= 1
                    self.btnB4.backgroundColor = UIColor.green
                    self.btnB4.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 15:
            if ticket > 0 || btnB5.backgroundColor == UIColor.green
            {
                if btnB5.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B5") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB5.backgroundColor = UIColor.clear
                    self.btnB5.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B5");
                    
                    ticket -= 1
                    self.btnB5.backgroundColor = UIColor.green
                    self.btnB5.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 16:
            if ticket > 0 || btnB6.backgroundColor == UIColor.green
            {
                if btnB6.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B6") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB6.backgroundColor = UIColor.clear
                    self.btnB6.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B6");
                    
                    ticket -= 1
                    self.btnB6.backgroundColor = UIColor.green
                    self.btnB6.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 17:
            if ticket > 0 || btnB7.backgroundColor == UIColor.green {
                if btnB7.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B7") {
                        listPlaces.remove(at: index)
                    }
                    
                    
                    ticket += 1
                    btnB7.backgroundColor = UIColor.clear
                    self.btnB7.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B7");
                    
                    ticket -= 1
                    self.btnB7.backgroundColor = UIColor.green
                    self.btnB7.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 18:
            if ticket > 0 || btnB8.backgroundColor == UIColor.green {
                if btnB8.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B8") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB8.backgroundColor = UIColor.clear
                    self.btnB8.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B8");
                    
                    
                    ticket -= 1
                    self.btnB8.backgroundColor = UIColor.green
                    self.btnB8.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 19:
            if ticket > 0 || btnB9.backgroundColor == UIColor.green {
                if btnB9.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B9") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnB9.backgroundColor = UIColor.clear
                    self.btnB9.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B9");
                    
                    ticket -= 1
                    self.btnB9.backgroundColor = UIColor.green
                    self.btnB9.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 20:
            if ticket > 0 || btnB10.backgroundColor == UIColor.green {
                if btnB10.backgroundColor == UIColor.green
                {
                    
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "B10") {
                        listPlaces.remove(at: index)
                    }
                    ticket += 1
                    btnB10.backgroundColor = UIColor.clear
                    self.btnB10.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("B10");
                    
                    ticket -= 1
                    self.btnB10.backgroundColor = UIColor.green
                    self.btnB10.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
        default:
            break;
        }
    }
    
    //Sự kiện khi chọn button, từ C1 dến C10 có tag từ 21 đến 30
    @IBAction func btnCActionClick(_ sender: CustomDesignButton) {
        switch(sender.tag)
        {
        case 21:
            if ticket > 0 || btnC1.backgroundColor == UIColor.green
            {
                if btnC1.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C1") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC1.backgroundColor = UIColor.clear
                    self.btnC1.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C1");
                    
                    ticket -= 1
                    self.btnC1.backgroundColor = UIColor.green
                    self.btnC1.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 22:
            if ticket > 0 || btnC2.backgroundColor == UIColor.green {
                if btnC2.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C2") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC2.backgroundColor = UIColor.clear
                    self.btnC2.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C2");
                    
                    ticket -= 1
                    self.btnC2.backgroundColor = UIColor.green
                    self.btnC2.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 23:
            if ticket > 0 || btnC3.backgroundColor == UIColor.green
            {
                if btnC3.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C3") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC3.backgroundColor = UIColor.clear
                    self.btnC3.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C3");
                    
                    ticket -= 1
                    self.btnC3.backgroundColor = UIColor.green
                    self.btnC3.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 24:
            if ticket > 0 || btnC4.backgroundColor == UIColor.green
            {
                if btnC4.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C4") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC4.backgroundColor = UIColor.clear
                    self.btnC4.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C4");
                    ticket -= 1
                    self.btnC4.backgroundColor = UIColor.green
                    self.btnC4.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 25:
            if ticket > 0 || btnC5.backgroundColor == UIColor.green
            {
                if btnC5.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C5") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC5.backgroundColor = UIColor.clear
                    self.btnC5.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C5");
                    
                    ticket -= 1
                    self.btnC5.backgroundColor = UIColor.green
                    self.btnC5.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 26:
            if ticket > 0 || btnC6.backgroundColor == UIColor.green
            {
                if btnC6.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C6") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC6.backgroundColor = UIColor.clear
                    self.btnC6.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C6");
                    
                    ticket -= 1
                    self.btnC6.backgroundColor = UIColor.green
                    self.btnC6.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 27:
            if ticket > 0 || btnC7.backgroundColor == UIColor.green {
                if btnC7.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C7") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC7.backgroundColor = UIColor.clear
                    self.btnC7.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C7");
                    
                    ticket -= 1
                    self.btnC7.backgroundColor = UIColor.green
                    self.btnC7.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 28:
            if ticket > 0 || btnC8.backgroundColor == UIColor.green {
                if btnC8.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C8") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC8.backgroundColor = UIColor.clear
                    self.btnC8.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C8");
                    
                    ticket -= 1
                    self.btnC8.backgroundColor = UIColor.green
                    self.btnC8.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 29:
            if ticket > 0 || btnC9.backgroundColor == UIColor.green {
                if btnC9.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C9") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC9.backgroundColor = UIColor.clear
                    self.btnC9.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C9");
                    
                    ticket -= 1
                    self.btnC9.backgroundColor = UIColor.green
                    self.btnC9.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
            
        case 30:
            if ticket > 0 || btnC10.backgroundColor == UIColor.green {
                if btnC10.backgroundColor == UIColor.green
                {
                    //xoá vị trí ghế khỏi danh sách đã đặt
                    if let index = listPlaces.index(of: "C10") {
                        listPlaces.remove(at: index)
                    }
                    
                    ticket += 1
                    btnC10.backgroundColor = UIColor.clear
                    self.btnC10.setTitleColor(UIColor.blue, for: UIControlState.normal)
                }
                else
                {
                    //lưu vị trí ghế vào danh sách đã đặt
                    listPlaces.append("C10");
                    
                    ticket -= 1
                    self.btnC10.backgroundColor = UIColor.green
                    self.btnC10.setTitleColor(UIColor.white, for: UIControlState.normal)
                }
            }; break;
        default: break;
        }
        
    }
    
    //Su kien Click button Thanh Toan
    @IBAction func btnPay_Act(_ sender: Any) {
        if (ticket > 0) {
            showAlertDialog(message: "Bạn chọn chưa đủ số ghế. Vui lòng chọn thêm")
        }
        else {
            
            for place in listPlaces {
                //save into movie
                let dataUpdates = ["state": true, "bookBy": getUid()] as [String: AnyObject]
                refDatabase.child("movies").child("PhimDangChieu").child("1").child("showTime").child("850").child("seat").child("A5").updateChildValues(dataUpdates)
            }
            
            //Cập nhật số dư tài khoản sau khi thanh toán
            let dataBalance = ["balance": Int64(userProfile.balance) - billMoney]
            refDatabase.child("Acount").child(getUid()).updateChildValues(dataBalance)
            
            //Lưu vé đã đặt vào users tương ứng
            let dataFilms = [
                "movieId": movieDetail.movieId,
                "movieType": movieDetail.movieType,
                "price": billMoney,
                "seat": listPlaces,
                "showTime": time,
                "timestamp": getTodayString()
                ] as [String: AnyObject]
            
            let key = refDatabase.child("Acount").child(getUid()).child("booked").childByAutoId().key
            //Inser vé đã đặt vào dữ liệu acount tương ứng
            refDatabase.child("Acount").child(getUid()).child("booked").child(key).updateChildValues(dataFilms)
            
            let alertView = UIAlertController(title: "Thông Báo", message: "Đặt ghế thành công", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                self.navigationController?.popToRootViewController(animated: true)
            })
            alertView.addAction(action)
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    //Lấy ngày hiện tại
    func getTodayString() -> String {
        let date = Date()
        let calendar = Calendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        let today_string = String(year!) + "-" + String(month!) + "-" + String(day!) + " " + String(hour!)  + ":" + String(minute!) + ":" +  String(second!)
        
        return today_string
    }
    
    //Hàm hiện cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Chấp nhận", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //Hàm Lấy id của người dùng hiện tại
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!;
    }
}

