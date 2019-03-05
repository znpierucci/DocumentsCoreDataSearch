//
//  DocumentsTableViewCell.swift
//  DocumentsCoreData
//
//  Created by Zachary Pierucci on 2/21/19.
//  Copyright © 2019 Zachary Pierucci. All rights reserved.
//

import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
