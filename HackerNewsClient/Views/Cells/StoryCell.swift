//
//  NewsCell.swift
//  HackerNewsClient
//
//  Created by Dinar Mukhametshin on 29.04.2020.
//  Copyright © 2020 Dinar Mukhametshin. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var tooltip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
