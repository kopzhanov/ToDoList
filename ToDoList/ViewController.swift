//
//  ViewController.swift
//  ToDoList
//
//  Created by Alikhan Kopzhanov on 23.05.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addTask(_ sender: Any) {
        let task = textField.text!
        
        let newTask = TaskItem(name: task)
        
        do {
            if let data = UserDefaults.standard.data(forKey: "taskItemArray") {
                        
                        var arrayTask = try JSONDecoder().decode([TaskItem].self, from: data)
                        
                        arrayTask.append(newTask)
                        
                        let encodedata = try JSONEncoder().encode(arrayTask)
                        
                        UserDefaults.standard.set(encodedata, forKey: "taskItemArray")
                    } else {
                        let array = [newTask]
                        
                        let encodedata = try JSONEncoder().encode(array)
                        
                        UserDefaults.standard.set(encodedata, forKey: "taskItemArray")
                    }
                } catch {
                    print("unable to encode \(error)")
                }
        
//        if let taskArray = UserDefaults.standard.array(forKey: "taskArray") as? [String]{
//            var array = taskArray
//
//            array.append(task)
//
//            UserDefaults.standard.set(array, forKey: "taskArray")
//        } else {
//
//            let taskArray = [task]
//
//            UserDefaults.standard.set(taskArray, forKey: "taskArray")
//        }
        
        textField.text = ""
    }
}

