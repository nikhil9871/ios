//
//  CustomItemCellTableViewCell.swift
//  TestClick
//
//  Created by cl-macmini-150 on 24/06/16.
//  Copyright © 2016 cl-macmini-150. All rights reserved.
//

import UIKit

class CustomItemCellTableViewCell: UITableViewCell {
    var count: Int?
   // var onButtonTapped : (() -> Void)? = nil
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var increaseCountButton: UIButton!
    @IBOutlet weak var decreaseCountButton: UIButton!
    
    @IBAction func increaseCountButton(sender: AnyObject) {
        countLabel.text = String(Int(countLabel.text!)! + 1)
    }
    
    @IBAction func decreaseCountButton(sender: AnyObject) {
        if Int(countLabel.text!)! > 1 {
             countLabel.text = String(Int(countLabel.text!)! - 1)
        }
        else{
            print("Cannot decrease more count")
        }
       
    
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
