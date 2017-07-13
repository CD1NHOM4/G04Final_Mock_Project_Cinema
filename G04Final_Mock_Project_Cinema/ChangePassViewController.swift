//
//  ChangePassViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/24/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class ChangePassViewController: UIViewController {
    
    @IBOutlet weak var txtfOldPass: UITextField!
    @IBOutlet weak var txtfNewPass: UITextField!
    @IBOutlet weak var txtfConfirmPass: UITextField!
    
    var user: UserProfile! = nil
    var thongbaoDangXuLi: MBProgressHUD! = nil
    var rfDatabase: DatabaseReference!
    //khởi tạo đối tượng chứa các message cảnh báo
    let notifyMessage = NotifyMessage.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Gọi tham chiếu đến database trên FireBase
        rfDatabase = Database.database().reference()
        
        //Dismiss bàn phím
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        //
        observerKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //1.Hàm xử lí nút Back được nhấn
    @IBAction func btnBack_Act(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //2.hàm xử lí button btnChangePass được nhấn
    @IBAction func btnChangePass_Act(_ sender: Any) {
        var oldPass: String = txtfOldPass.text!
        var newPass: String = txtfNewPass.text!
        let confirmPass: String = txtfConfirmPass.text!
        
        //Kiểm tra người dùng đã nhập thông tin chưa
        if (oldPass.isEmpty || newPass.isEmpty || confirmPass.isEmpty) {
            showAlertDialog(message: notifyMessage.emptyInput)
        }
        else {
            var isAcount: Bool = true;
            //Kiểm Tra độ dài Mật khẩu
            if (oldPass.characters.count < 6 || newPass.characters.count < 6 || confirmPass.characters.count < 6){
                isAcount = false;
                showAlertDialog(message: notifyMessage.passwordShort);
                return;
            }
            
            //Kiểm tra Pass hiện tại có đúng
            let checkPass = user.password
            
            if (checkPass != oldPass.md5()) {
                isAcount = false
                showAlertDialog(message: notifyMessage.failChangePassword);
                return ;
            }
            
            //Kiểm tra Pass mới có trùng với confirmPass
            if (newPass != confirmPass) {
                isAcount = false;
                showAlertDialog(message: notifyMessage.passwordMissmatch);
                return ;
            }
            
            //Nếu thoả các điều kiện
            if (isAcount) {
                
                //Hiện Progress đang xử lí
                self.showProgress()
                
                //Gọi hàm Thay đổi Pass của thư viện FireBase
                //newPass = newPass.md5()
                Auth.auth().currentUser?.updatePassword(to: String(newPass)) { (error) in
                    
                    //Ẩn Progress đang xử lí
                    self.hideProgress()
                    
                    //Nếu không xảy ra lỗi
                    if error == nil
                    {
                        //Cập nhật Pass mới
                        let dataUpdatePass = ["password": newPass.md5()!];
                        self.rfDatabase.child("Acount").child(self.getUid()).updateChildValues(dataUpdatePass)
                        
                        //Hiện Thông Báo thành công
                        let alertView = UIAlertController(title: self.notifyMessage.alertTitle, message: self.notifyMessage.successChangePassword, preferredStyle: .alert)
                        let action = UIAlertAction(title: self.notifyMessage.agreeDialog, style: .default, handler: { (action: UIAlertAction) in
                            self.dismiss(animated: true, completion: nil)
                        })
                        
                        alertView.addAction(action)
                        self.present(alertView, animated: true, completion: nil)
                    }
                        
                        //Nếu có lỗi,hiện Thông Báo đổi pass thất bại
                    else
                    {
                        self.showAlertDialog(message: self.notifyMessage.failChangePassword)
                    }
                }
            }
        }
    }
    
    //Hàm lấy ID của User, cung cấp bởi lớp Firebase
    func getUid() -> String {
        return (Auth.auth().currentUser?.uid)!;
    }
    
    //Hàm hiện Progress nếu đang trong quá trình xử lí
    func showProgress() {
        thongbaoDangXuLi = MBProgressHUD.showAdded(to: self.view, animated: true)
        thongbaoDangXuLi.mode = MBProgressHUDMode.indeterminate
        thongbaoDangXuLi.label.text = notifyMessage.isLoading
    }
    //Hàm ẩn Progress đang xử lí
    func hideProgress() {
        thongbaoDangXuLi.hide(animated: true)
    }
    
    //MARK: - Hiện, Ẩn Keyboard
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtfOldPass.resignFirstResponder()
        txtfConfirmPass.resignFirstResponder()
        txtfNewPass.resignFirstResponder()
        return true
    }
    //
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    //Ẩn Bàn Phím
    func DismissKeyboard(){
        view.endEditing(true)
    }
    //Hiện bàn phím khi click vào TextField
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -160, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    //Ẩn Bàn phím
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    //Hàm hiện hộp thoại cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: notifyMessage.alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: notifyMessage.agreeDialog, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
}
