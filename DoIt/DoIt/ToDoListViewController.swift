//
//  ViewController.swift
//  DoIt
//
//  Created by Michael on 7/2/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

class ToDoListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var toDoItems = [TodoItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ToDoListViewController.getTodoList {
            self.toDoItems = $0
        }
        
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let newTodoItem = TodoItem(text: "NEW", check: false)
        
        toDoItems.append(newTodoItem)
        
        tableView.insertRows(at: [IndexPath(row: toDoItems.count-1, section: 0)], with: .automatic)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToNewTodo" {
            let controller = segue.destination as! NewTodoTableViewController
            controller.delegate = self
        }
        
    }
    
}


// MARK: - UITableViewDataSource Methods
extension ToDoListViewController: UITableViewDataSource{
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems.count
    }
    
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    @available(iOS 2.0, *)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChecklistItemCell", for: indexPath) as! ToDoTableViewCell
        
        let todoItem = toDoItems[indexPath.row]
        cell.label.text = todoItem.text ?? ""
        cell.checkLabel.isHidden = !todoItem.check
        return cell
    }
    
    
}

extension ToDoListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? ToDoTableViewCell {
            
            var todoItem = toDoItems[indexPath.row]
            todoItem.check = !todoItem.check
            toDoItems[indexPath.row] = todoItem
            
            cell.checkLabel.isHidden = !todoItem.check
        }
        
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        toDoItems.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .automatic)
        
    }
}

extension ToDoListViewController: NewTodoTableViewControllerDelegate {
    func newTodoVC(_ vc: NewTodoTableViewController, didAddItem item: TodoItem) {
        
        toDoItems.append(item)
        
        let indexPath = IndexPath(row: toDoItems.count-1, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)

        navigationController?.popViewController(animated: true)
    }
    
    func userCanceledFrom(_ vc: NewTodoTableViewController) {
        navigationController?.popViewController(animated: true)
    }
    
}


extension ToDoListViewController {
    
    static func getTodoList(completion: ([TodoItem]) -> ()) {
        
        var returnArray = [TodoItem]()
        
        let row0text = "Walk the dog"
        let row0checked = false
        returnArray.append(TodoItem(text: row0text, check: row0checked))
        
        let row1text = "Brush teeth"
        let row1checked = false
        returnArray.append(TodoItem(text: row1text, check: row1checked))

        let row2text = "Learn iOS development"
        let row2checked = false
        returnArray.append(TodoItem(text: row2text, check: row2checked))
        
        let row3text = "Soccer practice"
        let row3checked = false
        returnArray.append(TodoItem(text: row3text, check: row3checked))

        
        let row4text = "Eat ice cream"
        let row4checked = false
        returnArray.append(TodoItem(text: row4text, check: row4checked))

        completion(returnArray)
    }
}

