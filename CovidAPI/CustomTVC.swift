//
//  CustomTVC.swift
//  CovidAPI
//
//  Created by Farhana Khan on 06/05/21.
//

import UIKit

class CustomTVC: UITableViewCell {

    @IBOutlet weak var btnPress: UIButton!
    @IBOutlet weak var addLb: UILabel!
    @IBOutlet weak var lb: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
