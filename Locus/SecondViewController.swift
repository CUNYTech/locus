//
//  SecondViewController.swift
//  Locus
//
//  Created by Elizabeth Kelly on 10/11/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit
import KCFloatingActionButton

class SecondViewController: UIViewController, KCFloatingActionButtonDelegate {
    
     var fab = KCFloatingActionButton()

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

