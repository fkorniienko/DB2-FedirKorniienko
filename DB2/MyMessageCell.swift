//
//  MyMessageCell.swift
//  DB2
//
//  Created by Fedir Korniienko on 21.06.17.
//  Copyright © 2017 fedir. All rights reserved.
//

import UIKit

class MyMessageCell: UITableViewCell {
    @IBOutlet weak var time: UILabel!

    @IBOutlet weak var message: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        message.backgroundColor = UIColor.blue
        message.layer.cornerRadius = 5
        message.clipsToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
