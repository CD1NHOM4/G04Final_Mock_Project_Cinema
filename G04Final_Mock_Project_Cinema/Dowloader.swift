//
//  Dowloader.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/20/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import Foundation
import UIKit

class Downloader {
    //1.Hàm dowload file ảnh từ URL, hàm đang dùng
    class func downloadImageWithURL(_ url:String) -> UIImage! {
        let data : Data!
        do{
            data = try Data(contentsOf: URL(string: url)!)
            return UIImage(data: data!)
        }
        catch {
            return #imageLiteral(resourceName: "imgNotAvailable")
        }
    }
}
