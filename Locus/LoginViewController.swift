//
//  LoginViewController.swift
//  Locus
//
//  Created by Vincent Liu on 11/15/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON
import SwiftValidator

class LoginViewController: UIViewController, ValidationDelegate {

    let validator = Validator()
    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    var errorCode: Bool!
    var message: String = ""
    @IBAction func LoginButton(_ sender: Any) {
        //validator fields
        validator.validate(self)
      }
    
    func validationSuccessful() {
        
        //run a spinner to show a task in progress
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:150, height:150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        let urlString = "http://54.159.134.142/locus/v1/login"
        let dictionary = [
            "email": self.EmailTextField.text!,
            "password": self.PasswordTextField.text!
        ]
        
        //Serialization error handling
        var error: Error?
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options:[])
            let dataString = String(data: data, encoding: String.Encoding.utf8)!
            print(dataString)
        } catch {
            print("JSON Serialization failed: \(error)")
        }
        
        //post method
        let parameters = dictionary
        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        //stop the spinner
        spinner.stopAnimating()
        manager.post(urlString, parameters: parameters, progress: nil,
                     success:
            {
                (task: URLSessionTask, response: Any!) in
                
                //stop the spinner
                spinner.stopAnimating()
                let result = NSString(data: (response as! NSData) as Data, encoding: String.Encoding.utf8.rawValue)!
                print(result)
                //parse json with SwiftyJSON
                let json = JSON(data: response as! Data)
                self.errorCode = json["error"].bool!
                self.message = json["message"].stringValue
                
                //show error alert
                if (!self.errorCode) {
                    let email: String = json["email"].stringValue
                    let id = json["user_id"].intValue
                    UserDefaults.standard.set(email, forKey: "email")
                    UserDefaults.standard.set(id, forKey: "id")
                    self.performSegue(withIdentifier: "logged_in", sender: self)
                } else {
                    let alert = UIAlertController(title: "Failed", message: self.message, preferredStyle: UIAlertControllerStyle.alert)
                    let failedAlert = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                    alert.addAction(failedAlert)
                    self.present(alert, animated: true, completion: nil)
                }
                
        },
                     failure:
            {
                (task: URLSessionDataTask?, error: Error?) in
        })

    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        // turn the fields to red
        for (field, error) in errors {
            if let field = field as? UITextField {
                field.layer.borderColor = UIColor.red.cgColor
                field.layer.borderWidth = 1.0
            }
            error.errorLabel?.text = error.errorMessage // works if you added labels
            error.errorLabel?.isHidden = false
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "logged_in") {
            return false
        }
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //set rules for text fields
        validator.registerField(EmailTextField, rules: [RequiredRule(), EmailRule(message: "Invalid email")])
        validator.registerField(PasswordTextField, rules: [RequiredRule(), PasswordRule(message: "Password requirements not met")])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
