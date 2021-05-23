//
//  IntroductionVC.swift
//  CovidAPI
//
//  Created by Farhana Khan on 14/05/21.
//

import UIKit
import Lottie
class IntroductionVC: UIViewController {
    var animationV = AnimationView()
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var CV: UICollectionView!
    
    let color : [UIColor] =  [ #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) ]
    let animation = ["home","hands","mask","distance","eat","face","sanitizer","medical"]
    let quotes = ["Nothing lasts forever. Not even the coronavirus. So stay home, stay safe and fight hard🏡.","Clean your hands. Protect your health 🧤.","wear a mask, spread joy not germs 😷.","Social distance doesn't mean, We aren't together🧍🏻‍♀️←→🧍🏻.","When diet is wrong, medicine is of no use. When diet is correct, medicine is of no need 🥗.","Stop touching your face to reduce your chances of catching coronavirus🧏🏻‍♀️.","Maintain your hygiene, not germs 🧴.","A big Thank You to all the Frontliners for helping everyone get through this pandemic 👩🏻‍⚕️."]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        nextBtn.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        CV.reloadData()
    }
}

extension IntroductionVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return color.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCVC
        animationV.animation = Animation.named("\(animation[indexPath.row])")
        print(animation[indexPath.row])
        animationV.frame = cell.animationView.bounds
        animationV.backgroundColor = .clear
        animationV.contentMode = .scaleAspectFit
        animationV.play()
        animationV.loopMode = .loop
        cell.View.backgroundColor = color[indexPath.row]
        cell.introLb.text = "\(quotes[indexPath.row])"
        cell.animationView.addSubview(animationV)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //        print("Scroll Finish \(scrollView.contentOffset.x) CVW -> \(scrollView.frame.size.width) ")
        
        if scrollView.contentOffset.x/scrollView.frame.size.width == 0 {
            
            nextBtn.isHidden = true
            skipBtn.isHidden = false
        }
        
        else if scrollView.contentOffset.x/scrollView.frame.size.width == 6 {
            
            nextBtn.isHidden = false
            skipBtn.isHidden = true
        }
        
        else {
            
            nextBtn.isHidden = true
            skipBtn.isHidden = true
        }
        
        pageControl.currentPage = Int(scrollView.contentOffset.x/scrollView.frame.size.width)
    }
    
    
}
