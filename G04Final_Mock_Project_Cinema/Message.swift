//
//  Message.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 7/17/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation

//class set các thông điệp cảnh báo
class NotifyMessage {
    
    var emptyInput: String
    var failLogin: String
    var invalidEmailFormat: String
    var passwordShort: String
    var emailUsed: String
    var bookingTableTitle: String
    var signOutError: String
    var passwordMissmatch: String
    var failChangePassword: String
    var successChangePassword: String
    var emailNotExist: String
    var successResetPassword: String
    var voucherUsed: String
    var voucherSuccess: String
    var invalidVoucher: String
    var isLoading: String
    var alertTitle: String
    var agreeDialog: String
    var failRegister: String
    var failResetPass: String
    var failLogout: String
    var noInternet: String

    
    // hàm khởi tạo giá trị cho object thuộc lớp NotifyMessage
    init() {
        emptyInput            = "Bàn cần điền đầy đủ thông tin"
        failLogin              = "Email hoặc mật khẩu không đúng"
        invalidEmailFormat      = "Sai định dạng email"
        passwordShort           = "Mật khẩu phải có ít nhất 6 kí tự"
        emailUsed               = "Email đã được sử dụng"
        bookingTableTitle       = "LIST OF SEATS YOU BOOKED"
        signOutError            = "Đăng xuất thất bại"
        passwordMissmatch       = "Mật khẩu không trùng khớp"
        failChangePassword      = "Đổi mật khẩu thất bại"
        successChangePassword   = "Đổi mật khẩu thành công"
        emailNotExist           = "Email không tồn tại trên hệ thống"
        successResetPassword    = "Một email reset mật khẩu đã được gửi đến Email của bạn"
        voucherUsed             = "Mã đã hết hạn hoặc đã được sử dụng"
        voucherSuccess          = "Mã giảm giá đã được kích hoạt"
        invalidVoucher          = "Mã giảm giá không hợp lệ"
        isLoading               = "Đang tải..."
        alertTitle              = "Thông Báo"
        agreeDialog             = "Chấp nhận"
        failRegister            = "Tạo tài khoản thất bại, Vui lòng thử lại"
        failResetPass           = "Đã xảy ra lỗi. Vui lòng thử lại"
        failLogout              = "Đăng xuất thất bại"
        noInternet              = "Không có kêt nối Internet"

    }
}
