//
//  NewTodoTableViewController.swift
//  DoIt
//
//  Created by Michael on 7/2/19.
//  Copyright © 2019 Michael. All rights reserved.
//

import UIKit

protocol NewTodoTableViewControllerDelegate: class {
    func newTodoVC(_ vc: NewTodoTableViewController, didAddItem item: TodoItem)
    
    func newTodoVC(_ vc: NewTodoTableViewController, didEditItem item: TodoItem)

    
    func userCanceledFrom(_ vc: NewTodoTableViewController)
}


class NewTodoTableViewController: UITableViewController {

    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: NewTodoTableViewControllerDelegate?
    
    var todoEditItem: TodoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.textField.becomeFirstResponder()
        
        if let editItem = todoEditItem {
            title = "Edit Todo"
            textField.text = editItem.text
            saveButton.isEnabled = true
        }
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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


// MARK: - TextField Delegates
extension NewTodoTableViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let oldText = textField.text else { return true }
        
        guard let newRange = Range(range, in: oldText) else { return true }
        
        let newText = oldText.replacingCharacters(in: newRange, with: string)
        
        saveButton.isEnabled = !newText.isEmpty
        
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        saveButton.isEnabled = false
        return true
    }
    
}


// MARK: - IBActions
extension NewTodoTableViewController {
    
    @IBAction func saveButtonPressed() {
        
        print("Content of textField \(textField.text ?? "") " )
        
        if var todoEditItem = todoEditItem {
            todoEditItem.text = textField.text ?? ""
            delegate?.newTodoVC(self, didEditItem: todoEditItem)
            return
        }
        
        let newText = textField.text ?? ""
        delegate?.newTodoVC(self, didAddItem: TodoItem(text: newText, check: nil))
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        navigationController?.popViewController(animated: true)
        
        delegate?.userCanceledFrom(self)
    }
    
}
