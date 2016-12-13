//
//  NotesListTableViewController.swift
//  NoteTest
//
//  Created by Elizabeth Kelly on 10/24/16.
//  Copyright © 2016 Elizabeth Kelly. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftyJSON
import KCFloatingActionButton


class NotesListTableViewController: UITableViewController, KCFloatingActionButtonDelegate {

    
    var TableData = [[String]]()
    var currentRow = 0
    let id = UserDefaults.standard.object(forKey: "id")
    var fab = KCFloatingActionButton()
    
    func get_data(url: String) {
        let manager = AFHTTPSessionManager()
        manager.get(url, parameters: nil, progress: nil,
                    success: {
                        (task: URLSessionDataTask, response: Any!) in
                        
                        let jsonData = JSON(response)
                        let entry_list = jsonData["entries"]
                        
                        for i in 0 ..< entry_list.count {
                            let entry_detail: [String] = [entry_list[i]["title"].stringValue, entry_list[i]["entry"].stringValue, entry_list[i]["image"].stringValue]
                            self.TableData.append(entry_detail)
                        }
                        self.do_table_refresh()
        },
                    failure: {
                        (task: URLSessionTask?, error: Error?) in
                        print("error: \(error)")
        })
    }
    
    func do_table_refresh() {
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            return
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layoutFAB()
        self.get_data(url: "http://54.159.134.142/locus/v1/entries/" + String(describing: self.id!))

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return TableData.count
    }

    //reuses the note cells and allocates the info to them dynamically
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesCell", for: indexPath)

        // Configure the cell...
        cell.textLabel!.text = TableData[indexPath.row][0]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentIndexPath = tableView.indexPathForSelectedRow
        currentRow = (currentIndexPath?.row)!
        self.performSegue(withIdentifier: "show_entry", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "show_entry") {
            let destination = segue.destination as! EntryViewController
            destination.detail = TableData[currentRow]
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //the tableView will refresh its content every time it is displayed
        //it will call tableView(tableView:, numberOfRowsInSection:)
        // and tableView(tableView:, cellForRowAtPath:) on its data source
        // which is NotesListTableViewController
        tableView.reloadData()
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        // delete note from array
        TableData.remove(at: indexPath.row)
        //update UI to reflect the deletion
        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        
        /*
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    */
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier! == "showNote" {
            // Get the new view controller using segue.destinationViewController.
            let noteDetailViewController = segue.destination as! NoteDetailViewController
            // Get the indexPath that was selected
            var selectedIndexPath = tableView.indexPathForSelectedRow
            // Pass the selected object to the new view controller.
            noteDetailViewController.note = notes[selectedIndexPath!.row]
            noteDetailViewController.title = "Create an Entry"
        }
            
        else if segue.identifier! == "addNote" {
            let note = Note()
            notes.append(note)
            let noteDetailViewController = segue.destination as! NoteDetailViewController
            noteDetailViewController.note = note
            noteDetailViewController.title = "Create an Entry"
        }
    }*/
 

}
