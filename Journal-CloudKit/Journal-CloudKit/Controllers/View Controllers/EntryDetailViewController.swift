//
//  EntryDetailViewController.swift
//  Journal-CloudKit
//
//  Created by theevo on 3/30/20.
//  Copyright © 2020 Theo Vora. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    var entryReceiver: Entry? {
        didSet {
            DispatchQueue.main.async {
                self.updateViews()
            }
        }
    }
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        titleTextField.delegate = self
        setBodyTextViewBorder()
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        guard let title = titleTextField.text,
        let body = bodyTextView.text
            else { return }
                
        EntryController.shared.saveEntry(title: title, body: body) { (result) in
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    
    // MARK: - Helper Functions
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    func updateViews() {
        guard let entry = entryReceiver else { return }
        
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
    func setBodyTextViewBorder() {
        bodyTextView.layer.borderWidth = 1
        bodyTextView.layer.borderColor = UIColor.lightGray.cgColor
    }
    

} // end class

