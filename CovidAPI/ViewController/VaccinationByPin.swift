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
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
//        let id = session[indexPath.row].value(forKey: "center_id") as? Int ?? 0
//        cell.textLabel?.text = "ID: \(id)"
//        let name = session[indexPath.row].value(forKey: "name") as? String ?? "Empty"
//        cell.detailTextLabel?.text = "Name: \(name)"
//        cell.backgroundColor = UIColor.lightGray
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! VaccinationByPinTVC
        
        let name = session[indexPath.row].value(forKey: "name") as? String ?? "Empty"
        print("here\(name)")
        cell.nameLb.text = "Center: \(name)"
        
        let id = session[indexPath.row].value(forKey: "center_id") as? Int ?? 0
        cell.idLb.text = "Id: \(id)"
        
        cell.detailsBtn.tag = indexPath.row
        cell.detailsBtn.addTarget(self, action: #selector(viewDetailsPressed(sender:)), for: .touchUpInside)
        cell.backgroundColor = UIColor.lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        0.1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    @IBOutlet weak var TV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        applyGradient(colors: [ #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1),#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1) ])
        actIn.isHidden = true
        self.navigationController?.navigationBar.isHidden = false
        //        self.navigationItem.title = "Pincode"
        vaccinationApi()
    }
    
    func showErr(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .cancel) { alert in
            
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func vaccinationApi()
    {
        
        if Connectivity.isConnectedToInternet() {
            
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
        
        else {
            self.actIn.isHidden = true
            showErr(title: "No Internet Connection!!", message: "Please Check Your Internet Connection and Try Again")
        }
    }
    
    @objc func homeBtn() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "HomeVC") as! HomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func viewDetailsPressed(sender: UIButton){
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        let indexPath = IndexPath(row: sender.tag, section: 0)
        
        let address = session[indexPath.row].value(forKey: "address") as? String ?? "Address Unavailable"
        if address == "" {
            vc.address = "Address Unavailable"
        }
        else {
            vc.address = "Address: \(address)"
        }
        
        let fromTime = session[indexPath.row].value(forKey: "from") as? String ?? "Time Unavailable"
        let toTime = session[indexPath.row].value(forKey: "to") as? String ?? "Time Unavailable"
        if fromTime == "" || toTime == "" {
            vc.from = "Time Unavailable"
        }
        
        else {
            vc.from = "Time: \(fromTime) to \(toTime)"
        }
        
        
        let fees = session[indexPath.row].value(forKey: "fee_type") as? String ?? "Fees Unavailable"
        if fees == "Paid" {
            vc.fees = "Paid"
        }
        
        else {
            vc.fees = "Free"
        }
        
        let vaccine = session[indexPath.row].value(forKey: "vaccine") as? String ?? "Vaccine Name Unavailable"
        if vaccine == "" {
            vc.vaccineName = "Vaccine Name Unavailable"
        }
        
        else
        {
            vc.vaccineName = "Vaccine: \(vaccine)"
        }
        
        let availableSlots = session[indexPath.row].value(forKey: "slots") as! [String]
        let time = availableSlots.joined(separator: ",")
        if availableSlots.isEmpty {
            vc.slots = "Slots Unavailable"
        }
        else {
            vc.slots = "Slots: \(time)"
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
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
