//
//  NoteDetailViewController.swift
//  NoteTest
//
//  Created by Elizabeth Kelly on 10/24/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit

class NoteDetailViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    var note: Note!
    
    /*
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }*/
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleTextField.text = note.title
        contentTextField.text = note.content
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        note.title = titleTextField.text!
        note.content = contentTextField.text
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
