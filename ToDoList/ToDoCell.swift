//
//  ToDoCell.swift
//  ToDoList
//
//  Created by Olaf Kroon on 21/11/16.
//  Copyright © 2016 Olaf Kroon. All rights reserved.
//

import UIKit

class ToDoCell: UITableViewCell {

     @IBOutlet weak var checkLabel: UILabel!
    
    override func awakeFromNib() {
       
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
