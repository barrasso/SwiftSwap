//
//  MainCellTableViewCell.swift
//  SwiftSwap
//
//  Created by Mark on 1/31/15.
//  Copyright (c) 2015 MEB. All rights reserved.
//

import UIKit

class MainCellTableViewCell: UITableViewCell {
    
    // MARK: Outlets
    
    @IBOutlet var postedImage: UIImageView!
    
    @IBOutlet var postedByUser: UILabel!
    @IBOutlet var postCaption: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
