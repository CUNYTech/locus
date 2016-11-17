//
//  LoginViewController.swift
//  Locus
//
//  Created by Vincent Liu on 11/15/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit
import AFNetworking

class LoginViewController: UIViewController {

    @IBOutlet weak var EmailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBAction func LoginButton(_ sender: Any) {
        
        //run a spinner to show a task in progress
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:150, height:150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        let urlString = "http://localhost:8888/locus/v1/login"
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
        manager.post(urlString, parameters: parameters, progress: nil,
            success:
            {
                URLSessionTask, response in
                
                //stop the spinner
                spinner.stopAnimating()
                let result = NSString(data: (response as! NSData) as Data, encoding: String.Encoding.utf8.rawValue)!
                    let alert = UIAlertController(title: "Success", message:
                        "Successfuly Logged in", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alert, animated: true, completion: nil)
                
                print(result)
            },
            failure:
            {
                URLSessionTask, error in
            })
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

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
