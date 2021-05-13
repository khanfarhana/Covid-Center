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
        actInd.stopAnimating()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.title = "State"
        api()
    }
    func api()
    {
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
}
