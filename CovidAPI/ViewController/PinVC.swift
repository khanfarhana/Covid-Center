//
//  PinVC.swift
//  CovidAPI
//
//  Created by Farhana Khan on 12/05/21.
//

import UIKit

class PinVC: UIViewController {
    private var datePicker: UIDatePicker?
    @IBOutlet weak var pinTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        pickDate()
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func validateFields() -> String? {
        if pinTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dateTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        //Checks if the pin is correct
        let cleanPin = pinTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if validZipCode(postalCode: cleanPin) == false{
            return "Make sure you've entered pin in correct format"
        }
        
        //Checks if the date is correct
        let cleanDate = dateTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if validateDate(date: cleanDate) == false{
            return "Make sure you've entered date in correct format (dd-mm-yyyy)"
        }
        return nil
    }
    
    func validZipCode(postalCode:String)->Bool{
        
        let postalcodeRegex = "^[0-9]{6}$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let pinValidates = pinPredicate.evaluate(with: postalCode) as Bool
        return pinValidates
    }
    
    func validateDate(date: String) -> Bool{
        let dateRegex = "^(?:(?:31(\\/|-|\\.)(?:0?[13578]|1[02]))\\1|(?:(?:29|30)(\\/|-|\\.)(?:0?[13-9]|1[0-2])\\2))(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$|^(?:29(\\/|-|\\.)0?2\\3(?:(?:(?:1[6-9]|[2-9]\\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\\d|2[0-8])(\\/|-|\\.)(?:(?:0?[1-9])|(?:1[0-2]))\\4(?:(?:1[6-9]|[2-9]\\d)?\\d{2})$"
        let datePredicate = NSPredicate(format: "SELF MATCHES %@", dateRegex)
        let dateValidates = datePredicate.evaluate(with: date) as Bool
        return dateValidates
    }
    
    @IBAction func proceedBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "VaccinationByPin") as! VaccinationByPin
        let error = validateFields()
        if error != nil{
            
            showErr(title: error!)
        }
        
        else {
            vc.pincode = pinTF.text!
            vc.date = dateTF.text!
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func showErr(title: String){
        let alert = UIAlertController(title: "\(title)", message: nil, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }
    
    func pickDate() {
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(dateChanged(sender:)), for: .valueChanged)
        dateTF.inputView = datePicker
    }
    
    @objc func dateChanged(sender: UIDatePicker){
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "dd-MM-yyyy"
        dateTF.text = dateFormat.string(from: sender.date)
        view.endEditing(true)
    }
}
