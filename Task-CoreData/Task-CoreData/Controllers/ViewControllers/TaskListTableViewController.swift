//
//  TaskListTableViewController.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 27/07/2021.
//

import UIKit

class TaskListTableViewController: UITableViewController {

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.shared.fetchTasks()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? TaskDetailViewController else { return }
            let taskToSend = TaskController.shared.tasks[indexPath.row]
            destination.task = taskToSend
            destination.delegate = self
        }
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension TaskListTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? TaskTableViewCell else { return UITableViewCell() }
        
        let task = TaskController.shared.tasks[indexPath.row]
        cell.task = task
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.delete(task: taskToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TaskListTableViewController: TaskCompletionDelegate {
    
    func taskCellButtonTapped(_ sender: TaskTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        
        TaskController.shared.toggleIsComplete(task: task)
        sender.updateCellViews()
    }
}


extension TaskListTableViewController: UpdateTableViewDelegate {
    func updateViewFor(task: Task, name: String, dueDate: Date, notes: String) {
        TaskController.shared.update(task: task, name: name, notes: notes, date: dueDate)
        tableView.reloadData()
    }
    
    
    
}
