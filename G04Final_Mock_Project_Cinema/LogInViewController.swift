//
//  LogInViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/20/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit
import Firebase
import MBProgressHUD

class LogInViewController: UIViewController, UITextFieldDelegate {
    //khai báo các biến global
    @IBOutlet weak var txtfEmail: UITextField!
    @IBOutlet weak var txtfPass: UITextField!
    var thongbaoDangXuLi: MBProgressHUD!
    //khởi tạo đối tượng chứa các message cảnh báo
    let notifyMessage = NotifyMessage.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Hiện Progresss đang tải
    func showProgress() {
        thongbaoDangXuLi = MBProgressHUD.showAdded(to: self.view, animated: true)
        thongbaoDangXuLi.mode = MBProgressHUDMode.indeterminate
        thongbaoDangXuLi.label.text = notifyMessage.isLoading
    }
    //Ẩn Progress
    func hideProgress() {
        thongbaoDangXuLi.hide(animated: true)
    }
    //Xử lí sự kiện khi nhấn btnLogin
    @IBAction func btnLogin_Act(_ sender: Any) {
        let email: String = txtfEmail.text!
        let password: String = txtfPass.text!
        
        if (email.isEmpty || password.isEmpty) {
            showAlertDialog(message: notifyMessage.emptyInput);
        }
        else {
            //Nếu email sai định dạng, hiện cảnh báo
            if !(Validate.isValidEmail(testStr: email)) {
                self.showAlertDialog(message: notifyMessage.invalidEmailFormat)
            }
            else {
                
                //Hiện progress đang xử lí
                self.showProgress()
                //Gọi hàm xác thực với input là email/password ,
                Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                    
                    //Ẩn progress
                    self.hideProgress()
                    if (error == nil) {
                        let srcUserProfile = self.storyboard?.instantiateViewController(withIdentifier: "viewUserProfile") as! UserProfileViewController
                        self.present(srcUserProfile, animated: true)
                    }
                    else {
                        self.showAlertDialog(message: self.notifyMessage.failLogin)
                    }
                }
            }
        }
    }
    
    //Hiện hộp thoại cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: notifyMessage.alertTitle, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: notifyMessage.agreeDialog, style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    //Xử lí nút đóng btnClose
    @IBAction func btnClose_Act(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Show, Hide Keyboard
    //Focus, quay lại textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if txtfEmail.isEditing {
            txtfPass.becomeFirstResponder()
        } else {
            txtfPass.resignFirstResponder()
        }
        return true
    }
    
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    //DismissKeyboard
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    //Hiện Keyboard
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -70, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    //Ẩn Keyboard
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}

