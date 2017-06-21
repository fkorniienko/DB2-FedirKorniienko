//
//  ChatCell.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var count: UILabel!
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
        count.layer.cornerRadius = count.frame.width/2
        count.textColor = UIColor.white
        count.backgroundColor = UIColor.blue
        count.clipsToBounds = true
        imageUser.layer.cornerRadius = imageUser.frame.width/2
        imageUser.clipsToBounds = true
    }
    
}
