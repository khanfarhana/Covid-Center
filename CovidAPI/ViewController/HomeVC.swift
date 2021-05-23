//
//  ViewController.swift
//  CovidAPI
//
//  Created by Farhana Khan on 06/05/21.
//

import UIKit
import Alamofire
import Lottie

class HomeVC: UIViewController {
    @IBOutlet weak var vw: UIView!
    var animationV = AnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradient(colors: [ #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) ])
        animation()
        self.navigationController?.navigationBar.isHidden = true
        vw.backgroundColor = UIColor.clear
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    func animation() {
        animationV.animation = Animation.named("covid")
        animationV.frame = vw.bounds
        animationV.backgroundColor = .clear
        animationV.contentMode = .scaleAspectFit
        animationV.play()
        animationV.loopMode = .loop
        vw.addSubview(animationV)
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
