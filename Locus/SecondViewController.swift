//
//  SecondViewController.swift
//  Locus
//
//  Created by Elizabeth Kelly on 10/11/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit
import KCFloatingActionButton
import AFNetworking
import SwiftyJSON

class SecondViewController: UIViewController, KCFloatingActionButtonDelegate {
    
    var fab = KCFloatingActionButton()
    
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var EntryTextView: UITextView!
    var errorCode: Bool!
    var message: String = ""
    let email = UserDefaults.standard.object(forKey: "email") as! String

    @IBAction func SaveButton(_ sender: Any) {
        //run a spinner to show a task in progress
        let spinner: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x:0, y:0, width:150, height:150)) as UIActivityIndicatorView
        spinner.startAnimating()
        
        let urlString = "http://localhost:8888/locus/v1/entries"
        let dictionary = [
            "email": self.email,
            "title": self.TitleTextField.text!,
            "entry": self.EntryTextView.text!
            ] as [String : Any]
        
        //Serialization error handling
        let error: Error?
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
        manager.requestSerializer = AFHTTPRequestSerializer()
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
                
                //show alerts
                switch (self.errorCode) {
                case false:
                    //success animation
                    let alert = UIAlertController(title: "Success", message: self.message, preferredStyle: UIAlertControllerStyle.alert)
                    let successAlert = UIAlertAction(title: "Dismiss", style: .default, handler: {
                        action in self.performSegue(withIdentifier: "entry_list", sender: self)
                    })
                    alert.addAction(successAlert)
                    self.present(alert, animated: true, completion: nil)
                    break
                case true:
                    //error message
                    let alert = UIAlertController(title: "Failed", message: self.message, preferredStyle: UIAlertControllerStyle.alert)
                    let failedAlert = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
                    alert.addAction(failedAlert)
                    self.present(alert, animated: true, completion: nil)
                    break
                default:
                    ()
                }
                
        },
                     failure:
            {
                (task: URLSessionDataTask?, error: Error?) in
        })
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if (identifier == "entry_list") {
            return false
        }
        return true
    }
    
    override func viewDidLoad() {
    
        super.viewDidLoad()
        layoutFAB()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func layoutFAB() {
        let item = KCFloatingActionButtonItem()
        item.buttonColor = UIColor.blue
        item.circleShadowColor = UIColor.red
        item.titleShadowColor = UIColor.blue
        item.title = "Menu"
        item.handler = { item in }
        
        let fab = KCFloatingActionButton()
        // 1
        fab.addItem("View Map", icon: UIImage(named: "map")!, handler: { item in
            let newVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "mapView") as! FirstViewController
            newVC.navigationController?.pushViewController(newVC, animated:true)
            self.navigationController?.pushViewController(newVC, animated:true)
            fab.close()
        })
        self.view.addSubview(fab)
        // 2
        fab.addItem("Create a memory", icon: UIImage(named: "pencil")!, handler: { item in
            let newVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "entryPost") as! SecondViewController
            newVC.navigationController?.pushViewController(newVC, animated:true)
            self.navigationController?.pushViewController(newVC, animated:true)
            fab.close()
        })
        self.view.addSubview(fab)
        // 3
        fab.addItem("View Memories", icon: UIImage(named: "memories")!, handler: { item in
            let newVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "listView") as! NotesListTableViewController
            newVC.navigationController?.pushViewController(newVC, animated:true)
            self.navigationController?.pushViewController(newVC, animated:true)
            fab.close()
        })
        self.view.addSubview(fab)
        // 4
        fab.addItem("Account", icon: UIImage(named: "account")!, handler: { item in
            let newVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "account") as! AccountViewController
            newVC.navigationController?.pushViewController(newVC, animated:true)
            self.navigationController?.pushViewController(newVC, animated:true)
            fab.close()
        })
        self.view.addSubview(fab)
        //5
        fab.addItem("Logout?", icon: UIImage(named: "logout")!, handler: { item in
            let newVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "login") as! LoginViewController
            newVC.navigationController?.pushViewController(newVC, animated:true)
            self.navigationController?.pushViewController(newVC, animated:true)
            fab.close()
        })
        self.view.addSubview(fab)
    }
    
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        print("FAB Opened")
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        print("FAB Closed")
    }


}

