//
//  VaccinationByPinTVC.swift
//  CovidAPI
//
//  Created by Farhana Khan on 23/05/21.
//

import UIKit

class VaccinationByPinTVC: UITableViewCell {

    @IBOutlet weak var idLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var detailsBtn: CustomButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
