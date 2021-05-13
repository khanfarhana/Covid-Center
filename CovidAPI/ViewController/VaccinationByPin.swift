//
//  VaccinationByPin.swift
//  CovidAPI
//
//  Created by Farhana Khan on 13/05/21.
//

import UIKit
import Alamofire

class VaccinationByPin: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var actIn: UIActivityIndicatorView!
    var session = [NSDictionary]()
    var pincode = String()
    var date = String()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return session.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let id = session[indexPath.row].value(forKey: "center_id") as? Int ?? 0
        cell.textLabel?.text = "ID: \(id)"
        let name = session[indexPath.row].value(forKey: "name") as? String ?? "Empty"
        cell.detailTextLabel?.text = "Name: \(name)"
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
    
    @IBOutlet weak var TV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        actIn.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationItem.title = "Pincode"
        vaccinationApi()
    }
    func vaccinationApi()
    {
        AF.request("https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=\(pincode)&date=\(date)").responseJSON{(resp) in
            print("\(self.pincode) \(self.date)")
            if let  data = resp.value as? NSDictionary {
                self.actIn.stopAnimating()
                self.session = data.value(forKey: "sessions") as! [NSDictionary]
                print(self.session)
                self.TV.reloadData()
                if self.session.count == 0 {
                    self.TV.isHidden = true
                    let alert = UIAlertController(title: "No Data Found!", message: "The District You Are Searching For Has No Vaccination Currently", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
                    alert.addAction(ok)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            else {
                print("error ")
            }
        }
    }
    
    
}
