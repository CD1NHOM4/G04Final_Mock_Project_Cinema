//
//  CustomTableViewCell.swift
//  G04Final_Mock_Project_Cinema
//
//  Created by THANH on 5/30/17.
//  Copyright © 2017 HCMUTE. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var txtContent: UILabel!
    @IBOutlet weak var txtType: UILabel!
    @IBOutlet weak var txtTitle: UILabel!
    
    //Cấu hình cho Cell (ẢNh , Tiêu đề, Nội dung)
    func configWithCell(movieDetail: MovieDetail) {
        //txtType.text! = movieDetail.type
        txtTitle.text = movieDetail.movieName
        txtContent.text! = movieDetail.overview
        imgPoster.image = Downloader.downloadImageWithURL(movieDetail.posterUrl)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
