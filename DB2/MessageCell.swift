//
//  MessageCell.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageUser.layer.cornerRadius = imageUser.frame.width/2
        imageUser.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
