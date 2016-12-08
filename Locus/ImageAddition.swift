//  ImageAddition.swift
//  LoginReg
//
//  Created by Nishat Anjum on 10/24/16.
//  Copyright © 2016 Locus. All rights reserved.
// An app to visually chronologize and organize travel anecdotes for the modern explorer.

import UIKit
import KCFloatingActionButton

class ImageAddition: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, KCFloatingActionButtonDelegate {
    
    @IBOutlet weak var pickedImage: UIImageView!
    
    var fab = KCFloatingActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutFAB()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func camerabuttonaction(_ sender:
        UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func photoLibraryaction(_ sender:
        UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func saveaction(_ sender:
        UIButton) {
        let imageData = UIImageJPEGRepresentation(pickedImage.image!, 0.6)
        let compressedJPEGImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedJPEGImage!,nil, nil, nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!){
        pickedImage.image = image
        self.dismiss(animated: true, completion: nil)
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
            let newVC = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "identifier") as! FirstViewController
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

    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
