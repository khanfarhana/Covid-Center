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
        applyGradient(colors: [ #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) ])
        addressLbl.text = address
        fromTimeLbl.text = from
        feesLbl.text = fees
        vaccineNameLbl.text = vaccineName
        slotsLbl.text = slots
        
    }
    func applyGradient(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 1 , y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    
}
