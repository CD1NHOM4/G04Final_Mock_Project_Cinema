//
//  RegisterViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/20/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//
import UIKit
import MBProgressHUD
import Firebase

class RegisterViewController: UIViewController, UITextFieldDelegate {
    //Khai báo các biến global
    @IBOutlet weak var txtFFullName: UITextField!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPass: UITextField!
    @IBOutlet weak var txtFConfirmPass: UITextField!
    @IBOutlet weak var txtFAddress: UITextField!
    @IBOutlet weak var txtFPhone: UITextField!
    
    //khởi tạo đối tượng chứa các message cảnh báo
    let notifyMessage = NotifyMessage.init()
    
    var refDatabase: DatabaseReference!
    var thongbaoDangXuLi: MBProgressHUD!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismiss: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LogInViewController.DismissKeyboard))
        view.addGestureRecognizer(dismiss)
        observerKeyboard()
        // Gọi tham chiếu đến Database trên FireBase
        refDatabase = Database.database().reference()
    }
    
    @IBAction func btnClose_Act(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnRegister_Act(_ sender: Any) {
        var result: Bool = true
        let email: String = txtFEmail.text!
        let password: String = txtFPass.text!
        let phone: String = txtFPhone.text!
        let confirmPass: String = txtFConfirmPass.text!
        let address: String = txtFAddress.text!
        let fullName: String = txtFFullName.text!
        
        if (email.isEmpty || password.isEmpty || phone.isEmpty || confirmPass.isEmpty || address.isEmpty || fullName.isEmpty){
            showAlertDialog(message: notifyMessage.emptyInput);
            result = false
        }
        else{
            if !(Validate.isValidEmail(testStr: email)) {
                showAlertDialog(message: notifyMessage.invalidEmailFormat)
                result = false
            }
            
            if (password.characters.count < 6 || confirmPass.characters.count < 6) {
                showAlertDialog(message: notifyMessage.passwordShort);
                result = false;
            }
            else {
                
                //Mật khẩu nhập nhập lại không trùng khớp
                if (password != confirmPass) {
                    showAlertDialog(message: notifyMessage.passwordMissmatch)
                    result = false;
                }
            }
            
            if (result) {
                //Hiện Progress
                self.showProgress()
                Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                    
                    //Ẩn tiến trình
                    self.hideProgress()
                    
                    //Nếu không xuất hiện lỗi
                    if error == nil {
                        let dataUser = [
                            "userid": user?.uid ?? "guest",
                            "email": email,
                            "phone": phone,
                            "address": address,
                            "password": password.md5(), //mã hoá password khi lưu vào database
                            "score": 200,
                            "balance": 300000,
                            "fullName": fullName
                            ] as [String : Any]
                        self.refDatabase.child("Acount").child((user?.uid)!).updateChildValues(dataUser)
                        
                        //Chuẩn bị trước khi chuyển qua Màn hình user Profile
                        let srcUserInfo = self.storyboard?.instantiateViewController(withIdentifier: "viewUserProfile") as! UserProfileViewController
                        self.present(srcUserInfo, animated: true)
                    }
                    //Xuất hiện lỗi, hiện thông báo
                    else {
                        if let errCode = AuthErrorCode(rawValue: error!._code) {
                            switch errCode {
                            case .invalidEmail:
                                self.showAlertDialog(message: self.notifyMessage.invalidEmailFormat)
                            case .emailAlreadyInUse:
                                self.showAlertDialog(message: self.notifyMessage.emailUsed)
                            default:
                                self.showAlertDialog(message: self.notifyMessage.failRegister)
                            }
                        }
                    }
                }
            }
        }
    }
    
    //Hàm Hiện thông báo tiến trình đang xử lí
    func showProgress() {
        thongbaoDangXuLi = MBProgressHUD.showAdded(to: self.view, animated: true)
        thongbaoDangXuLi.mode = MBProgressHUDMode.indeterminate
        thongbaoDangXuLi.label.text = "Đang tải..."
    }
    //Hàm ẩn thông báo chờ khi tiến trình hoàn tất
    func hideProgress() {
        thongbaoDangXuLi.hide(animated: true)
    }
    
    //Hiện hộp thoại cảnh báo
    func showAlertDialog(message: String) {
        let alertView = UIAlertController(title: "Thông Báo", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Chấp nhận", style: .default, handler: nil)
        alertView.addAction(action)
        self.present(alertView, animated: true, completion: nil)
    }
    
    //MARK: - Show, Hide Keyboard
    //
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtFEmail.resignFirstResponder()
        txtFPass.resignFirstResponder()
        txtFConfirmPass.resignFirstResponder()
        txtFAddress.resignFirstResponder()
        txtFPhone.resignFirstResponder()
        txtFFullName.resignFirstResponder()
        return true
    }
    //
    fileprivate func observerKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(LogInViewController.keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    //Ẩn Bàn phím khi kết thúc Edit trên TextField
    func DismissKeyboard(){
        view.endEditing(true)
    }
    
    //Hiện bàn phím khi bắt đầu Edit TextField
    func keyboardWillShow(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: -170, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    //Ẩn bàn phìm
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
}
