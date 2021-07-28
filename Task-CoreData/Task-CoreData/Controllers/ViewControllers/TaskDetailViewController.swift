//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 27/07/2021.
//

import UIKit

//protocol UpdateTableViewDelegate: AnyObject {
//    func updateCellViewFor(task: Task, name: String, dueDate: Date, notes: String)
//}

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties

    var task: Task?
    var date: Date?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetailViews()
    }
    
    // MARK: - Helper methods
    func updateDetailViews() {
        guard let task = task else { return }
        taskNameTextField.text = task.name
        taskNotesTextView.text = task.notes
        taskDueDatePicker.date = task.dueDate ?? Date()
    }

    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let name = taskNameTextField.text, !name.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty else { return }
        
        if let task = task {
            TaskController.shared.update(task: task, name: name, notes: notes, dueDate: date ?? Date())
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: taskDueDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        
        guard let name = taskNameTextField.text, !name.isEmpty,
              let notes = taskNotesTextView.text, !notes.isEmpty,
              let task = task else { return }
        
        self.date = taskDueDatePicker.date
        TaskController.shared.update(task: task, name: name, notes: notes, dueDate: date ?? Date())
    }
}
