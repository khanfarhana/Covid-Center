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
}
