//
//  LoginViewController.swift
//  finall
//
//  Created by רם צמח on 14/07/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var errorContainer: UIView!
    @IBOutlet weak var TFusername: UITextField!
    @IBOutlet weak var TFpassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    var Managersx = AssetManager()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar for this view controller
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /////
        Managersx.delegate = self
        Managersx.fetchMarkets()
        ///
        if let navigationController = self.navigationController {
                            // The view controller is embedded in a navigation controller
                            // You can safely use pushViewController(_:animated:) here
                            let storyboard = UIStoryboard(name: "Markets", bundle: nil)
                            let ctrl = storyboard.instantiateViewController(identifier: "MarketsViewController")
                            navigationController.pushViewController(ctrl, animated: true)
                        } else {
                            // The view controller is not embedded in a navigation controller
                            // pushViewController(_:animated:) will not work here
                            print("The view controller is not embedded in a navigation controller.")
                        }
        ///
        handleView()
    }
    


    @objc func dismissKeyboard() {
        TFusername.resignFirstResponder()
        TFpassword.resignFirstResponder()
    }

    func handleView() {
        self.validateLogin(user: "", pass: "")
        TFusername.delegate = self
        TFusername.text = "Email"
        TFpassword.delegate = self
        TFpassword.text = "Password"
        //textField.frame = CGRect(x: 50, y: 100, width: 200, height: 30)
                // Add the text field to the view
                //view.addSubview(textField)
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        let underlineLayer = CALayer()
                underlineLayer.frame = CGRect(x: 0, y: TFusername.frame.height - 2, width: TFusername.frame.width, height: 2)
                underlineLayer.backgroundColor = UIColor.white.cgColor
        
        let underlineLayer1 = CALayer()
                underlineLayer1.frame = CGRect(x: 0, y: TFpassword.frame.height - 2, width: TFpassword.frame.width, height: 2)
                underlineLayer1.backgroundColor = UIColor.white.cgColor
        TFusername.borderStyle = .none
        TFusername.layer.addSublayer(underlineLayer)
        TFpassword.borderStyle = .none
        TFpassword.layer.addSublayer(underlineLayer1)
    }
    
    func validateLogin(user: String, pass: String) -> Bool {
        if LoginViewController.isValidEmail(user) &&
            self.notEmptyFields(user: user, pass: pass) {
            
            self.btnLogin?.isUserInteractionEnabled = true
            self.btnLogin?.backgroundColor = UIColor(named: "lightBlue")
            return true
        } else {
            self.btnLogin?.isUserInteractionEnabled = false
            self.btnLogin?.backgroundColor = UIColor(named: "disabled")
        }
        return false
    }
    
    func notEmptyFields(user: String, pass: String) -> Bool {
        return user.count > 0 && pass.count >= 9
    }
    
    static func isValidEmail(_ email: String?) -> Bool {
        guard email != nil else {
            return false
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    @IBAction func registerClicked(_ sender: Any) {
        if let navigationController = self.navigationController {
                            // The view controller is embedded in a navigation controller
                            // You can safely use pushViewController(_:animated:) here
                            let storyboard = UIStoryboard(name: "Register", bundle: nil)
                            let ctrl = storyboard.instantiateViewController(identifier: "RegisterViewController")
                            navigationController.pushViewController(ctrl, animated: true)
                        } else {
                            // The view controller is not embedded in a navigation controller
                            // pushViewController(_:animated:) will not work here
                            print("The view controller is not embedded in a navigation controller.")
                        }
    }
    @IBAction func loginClicked(_ sender: Any) {
        FirebaseCenter.login(email: TFusername.text!, password: TFpassword.text!) { success, data, errorMsg in
            if success {
                print(success)
                if let navigationController = self.navigationController {
                                    // The view controller is embedded in a navigation controller
                                    // You can safely use pushViewController(_:animated:) here
                                    let storyboard = UIStoryboard(name: "Markets", bundle: nil)
                                    let ctrl = storyboard.instantiateViewController(identifier: "MarketsViewController")
                                    navigationController.pushViewController(ctrl, animated: true)
                                } else {
                                    // The view controller is not embedded in a navigation controller
                                    // pushViewController(_:animated:) will not work here
                                    print("The view controller is not embedded in a navigation controller.")
                                }
            } else {
                self.errorLbl.text = "Username or password are incorrect"
                self.errorContainer.isHidden = false
                print(errorMsg)
            }
        }
    }
}

extension LoginViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.errorLbl.isHidden = true
        if textField == TFusername {
            if textField.text == "Email" {
                textField.text = ""
            }
           } else if textField == TFpassword {
               if textField.text == "Password" {
                   textField.text = ""
               }
           }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == TFusername {
            if textField.text == "" {
                textField.text = "Email"
            }
           } else if textField == TFpassword {
               if textField.text == "" {
                   textField.text = "Password"
               }
           }
        self.validateLogin(user: TFusername.text ?? "", pass: TFpassword.text ?? "")
    }
}

extension LoginViewController: aWeatherManagerDelegate {
    func didUpdate(Manager: AssetManager, weather: [Asset]){
        print("aaa")
        var savedObjects = UserDefaults.standard.array(forKey: "SavedObjects") as? [Data] ?? []
        if savedObjects != nil{
            UserDefaults.standard.removeObject(forKey: "SavedObjects")
            savedObjects = []
        }
        for newObject in weather {
            
            let encoder = JSONEncoder()
            if let encodedObject = try? encoder.encode(newObject) {
                savedObjects.append(encodedObject)
            }
        }
        // Save the updated array back to UserDefaults
        UserDefaults.standard.set(savedObjects, forKey: "SavedObjects")
        DispatchQueue.main.async {
            print("aaa")
            //self.tableView.reloadData()
//            self.temperatureLabel.text = weather.tempString
//            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
//            self.cityLabel.text = weather.cityName
        }
    }
    
    func didFailWithError(error: String){
        print(error)
    }
}
