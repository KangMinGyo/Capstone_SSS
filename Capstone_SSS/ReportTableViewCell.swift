//
//  ReportTableViewCell.swift
//  Capstone_SSS
//
//  Created by Kang on 2022/03/27.
//

import UIKit

class ReportTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reportText: UILabel!
    @IBOutlet weak var checkButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
