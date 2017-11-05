//
//  ArticleCell.swift
//  559266
//
//  Created by Inholland Haarlem on 05-11-17.
//  Copyright © 2017 CharmelineTiel. All rights reserved.
//

import UIKit

class ArticleCell: UITableViewCell {

    //@IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var thumbnail: UIImageView!

    @IBOutlet weak var Title: UILabel!
    @IBAction func likeBtn(_ sender: Any) {
        
            print("liked")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        Title.numberOfLines = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
