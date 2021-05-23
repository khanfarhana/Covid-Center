//
//  StateVC.swift
//  CovidAPI
//
//  Created by Farhana Khan on 12/05/21.
//

import UIKit
import Alamofire

class StateVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var state = [NSDictionary]()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let id = state[indexPath.row].value(forKey: "state_id") as? Int ?? 0
        cell.textLabel?.text = "ID: \(id)"
        cell.layer.cornerRadius = 25
        cell.backgroundColor = UIColor.lightGray
        let name = state[indexPath.row].value(forKey: "state_name") as? String ?? "Empty"
        cell.detailTextLabel?.text = "State: \(name)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DistrictTableVC") as! DistrictTableVC
        vc.stateID = state[indexPath.row].value(forKey: "state_id") as? Int ?? 0
        print(vc.stateID)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    
    @IBOutlet weak var TV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradient(colors: [ #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) ])
        actInd.stopAnimating()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "State"
        api()
    }
    func api()
    {
        if Connectivity.isConnectedToInternet() {
            AF.request("https://cdn-api.co-vin.in/api/v2/admin/location/states").responseJSON{(resp) in
                if let  data = resp.value as? NSDictionary {
                    self.actInd.stopAnimating()
                    self.state = data.value(forKey: "states") as! [NSDictionary]
                    print(self.state)
                    self.TV.reloadData()
                }
                else {
                    print("error ")
                }
            }
        }
        
        else {
            self.actInd.stopAnimating()
            self.actInd.isHidden = true
            showErr(title: "No Internet Connection!!", message: "Please Check Your Internet Connection and Try Again")
        }
    }
    
    func showErr(title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { alert in
            
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
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
