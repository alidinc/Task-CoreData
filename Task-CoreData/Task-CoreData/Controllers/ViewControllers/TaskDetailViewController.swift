//
//  TaskDetailViewController.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 27/07/2021.
//

import UIKit

protocol UpdateTableViewDelegate: AnyObject {
    func updateViewFor(task: Task, name: String, dueDate: Date, notes: String)
}

class TaskDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet weak var taskDueDatePicker: UIDatePicker!
    
    // MARK: - Properties

    var task: Task?
    var date: Date?
    
    weak var delegate: UpdateTableViewDelegate?
    
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
            delegate?.updateViewFor(task: task, name: name, dueDate: date ?? Date(), notes: notes)
        } else {
            TaskController.shared.createTaskWith(name: name, notes: notes, dueDate: taskDueDatePicker.date)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dueDatePickerDateChanged(_ sender: Any) {
        self.date = taskDueDatePicker.date
    }
}
