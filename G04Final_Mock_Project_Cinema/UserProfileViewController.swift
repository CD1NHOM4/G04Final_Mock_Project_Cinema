//
//  UserProfileViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/22/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class UserProfileViewController: UIViewController {
    
    
    @IBOutlet weak var txtFFullName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    
    @IBOutlet weak var txtFPhone: UITextField!
    @IBOutlet weak var txtFAddress: UITextField!
    
    @IBOutlet weak var txtScore: UITextField!
    
    @IBOutlet weak var txtFBalance: UITextField!
    var refDatabase: DatabaseReference!
    var thongbaoDangXuLi: MBProgressHUD!
    var userToMove: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        refDatabase = Database.database().reference()
        
        //load User profile
        //Hiện  progress Đang xử lí
        self.showProgress()
        if let userid = Auth.auth().currentUser?.uid {
            refDatabase.child("Acount").child(userid).observeSingleEvent(of: .value, with: { (snapshot) in
                self.hideProgress()
                if let user = snapshot.value as? [String: AnyObject] {
                    let fullName = user["fullname"] as? String ?? ""
                    let email = user["email"] as? String ?? ""
                    let address = user["address"] as? String ?? ""
                    let phone = user["phone"] as? String ?? ""
                    let score = String(user["score"] as? Double ?? 0)
                    let balance = String(user["balance"] as? Double ?? 0)
                    self.txtFFullName.text! = fullName
                    self.txtFEmail.text! = email
                    self.txtFAddress.text! = address
                    self.txtFPhone.text! = phone
                    self.txtScore.text! = score
                    self.txtFBalance.text! = balance
                    self.userToMove = UserProfile.init(userid: userid, fullName: fullName, email: email, address: address, score: Double(score)!, password: user["password"] as? String ?? "" , phone: phone,balance: Double(balance)!)
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //Sự kiện btnChangePass
    @IBAction func btnChangePass_Act(_ sender: Any) {
        let srcChangePass = self.storyboard?.instantiateViewController(withIdentifier: "viewChangePass") as! ChangePassViewController
        srcChangePass.user = userToMove
        self.present(srcChangePass, animated: true)
    }
    //Sự kiện khi nhấn button đăng xuất khỏi ứng dụng
    @IBAction func btnLogOut_Act(_ sender: Any) {
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
            self.dismiss(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //Xử lí khi nhấn button btnHome_Act
    @IBAction func btnHome_Act(_ sender: Any) {
        let srcUserProfile = self.storyboard?.instantiateViewController(withIdentifier: "viewTrangChu") as! CustomTabBarController
        self.present(srcUserProfile, animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    //Hàm hiện Tiến trình đang được xử lí
    func showProgress() {
        thongbaoDangXuLi = MBProgressHUD.showAdded(to: self.view, animated: true)
        thongbaoDangXuLi.mode = MBProgressHUDMode.indeterminate
        thongbaoDangXuLi.label.text = "Đang tải..."
    }
    
    //Hàm ẩn Tiến trình đang được xử lí
    func hideProgress() {
        thongbaoDangXuLi.hide(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

