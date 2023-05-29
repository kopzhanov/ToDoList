//
//  ToDoListTableViewController.swift
//  ToDoList
//
//  Created by Alikhan Kopzhanov on 23.05.2023.
//

import UIKit

class ToDoListTableViewController: UITableViewController {

    var array: [TaskItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func saveTasks () {
            do {
                let encodedata = try JSONEncoder().encode(array)
                
                UserDefaults.standard.set(encodedata, forKey: "toDoArray")
            } catch {
                print("unable to encode \(error)")
            }
        }
    
    override func viewWillAppear(_ animated: Bool) {
//        if let taskArray = UserDefaults.standard.array(forKey: "taskArray") as? [String]{
//            array = taskArray
//            tableView.reloadData()
//        }
        do {
                    if let data = UserDefaults.standard.data(forKey: "toDoArray") {
                        
                        let arrayTask = try JSONDecoder().decode([TaskItem].self, from: data)
                        
                        array = arrayTask
                        tableView.reloadData()
                    }
                } catch {
                    print("unable to encode \(error)")
                }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return array.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: "")

        // Configure the cell...
        cell.textLabel?.text = array[indexPath.row].name
        cell.detailTextLabel?.text = array[indexPath.row].description
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.textColor = UIColor.systemIndigo
        
        if array[indexPath.row].isComplete{
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        array[indexPath.row].isComplete.toggle()
        saveTasks()
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            array.remove(at: indexPath.row)
            saveTasks()
            //UserDefaults.standard.set(array, forKey: "taskItemArray")
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
