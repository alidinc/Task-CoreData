//
//  TaskTableViewCell.swift
//  Task-CoreData
//
//  Created by Ali Dinç on 27/07/2021.
//

import UIKit

protocol TaskCellCompletionDelegate: AnyObject {
    func taskCellButtonTapped(_ sender: UITableViewCell)
}

class TaskTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Properties
    var task: Task? {
        didSet {
            updateCellViews()
        }
    }
    
    weak var delegate: TaskCellCompletionDelegate?
    
    // MARK: - Helper methods
    
    func updateCellViews() {
        guard let task = task else { return }
        taskNameLabel.text = task.name
        dateLabel.text = task.dueDate?.dateAsString()
        
        let imageName = task.isComplete ? "square.fill" : "square"
        completionButton.setImage(UIImage(systemName: imageName), for: .normal)
    }


    // MARK: - Actions
    
    @IBAction func completionButtonTapped(_ sender: Any) {
        delegate?.taskCellButtonTapped(self)
    }
}
