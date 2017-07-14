//
//  YoutubeViewController.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 7/10/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class YoutubeViewController: UIViewController {
    @IBOutlet var youTubeWebView: UIWebView!
    var videoCode: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
            getVideo(videoCode: videoCode!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Hàm get video từ thông url truyền vào
    func getVideo(videoCode: String) {
        
        let url = URL(string: "https://www.youtube.com/embed/\(videoCode)")
        youTubeWebView.loadRequest(URLRequest(url: url!))
        if (!youTubeWebView.isLoading) {
        }
    }
    
    //Xử lí sự kiện khi nhấn nút trở về
    @IBAction func btn_Back_Act(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
