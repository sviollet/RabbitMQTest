//
//  MessageTableViewCell.swift
//  Alarm
//
//  Created by samuel on 02/04/2017.
//  Copyright © 2017 Somfy. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var messageView: MessageView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var heure: UILabel!
    @IBOutlet weak var message: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
