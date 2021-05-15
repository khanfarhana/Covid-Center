//
//  DataVC.swift
//  CovidAPI
//
//  Created by Farhana Khan on 15/05/21.
//

import UIKit

class DetailVC: UIViewController {
    
    var address = ""
    var from = ""
    var fees = ""
    var vaccineName = ""
    var slots = ""
    
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var fromTimeLbl: UILabel!
    @IBOutlet weak var feesLbl: UILabel!
    @IBOutlet weak var vaccineNameLbl: UILabel!
    @IBOutlet weak var slotsLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressLbl.text = address
        fromTimeLbl.text = from
        feesLbl.text = fees
        vaccineNameLbl.text = vaccineName
        slotsLbl.text = slots
        
    }
    
    
    
    
}
