//
//  RegisterViewController.swift
//  Locus
//
//  Created by Vincent Liu on 11/15/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON

class RegisterViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var RepeatPassTextField: UITextField!
    //var errorCode: Bool? = nil
    @IBAction func RegisterButton(_ sender: Any) {
        //password verification
        if (PasswordTextField.text != RepeatPassTextField.text) {
            let alertController = UIAlertController(title: "Password", message:
                "The passwords don't match", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alertController, animated: true, completion: nil)
        } else {
            //run a spinner to show a task in progress
            let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:150, height:150)) as UIActivityIndicatorView
            spinner.startAnimating()
            
            let urlString = "http://localhost:8888/locus/v1/register"
            let dictionary = [
                "email": self.EmailTextField.text!,
                "password": self.PasswordTextField.text!
            ]
            
            //Serialization error handling
            var error: NSError?
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
            manager.post(urlString, parameters: parameters,
                success:
                {
                    responseOperation, response in
                    
                    //stop the spinner
                    spinner.stopAnimating()
                    let alert = UIAlertController(title: "Success", message:
                        "Signed Up", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    let result = NSString(data: (response as! NSData) as Data, encoding: String.Encoding.utf8.rawValue)!
                    
                    //print(message)
                    print(result)
                },
                failure:
                {
                    
                    responseOperation, error in
            })
            
        }
        
    }
    
    /*override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if(identifier == "logged_in") {
            //return errorCode!
            /*switch(errorCode) {
            case true:
                return true
                break
            case false:
                return false
                break
            }*/
            let alert = UIAlertController(title: "Success", message:
                "Signed Up", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        return true
    }*/

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
