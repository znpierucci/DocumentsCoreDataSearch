//
//  DocumentsViewController.swift
//  DocumentsCoreData
//
//  Created by Zachary Pierucci on 2/21/19.
//  Copyright © 2019 Zachary Pierucci. All rights reserved.
//

import UIKit

class DocumentsViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var documentTextView: UITextView!

    var document: Document?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let document = document {
            let name = document.name
            nameField.text = name
            documentTextView.text = document.content
            title = name
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 
    @IBAction func nameChanged(_ sender: Any) {
        title = nameField.text
    }
    
    @IBAction func saveDocument(_ sender: Any) {
        
        guard let name = nameField.text else {
            return
        }
        
        let content = documentTextView.text
        
        if document == nil {
            document = Document(name: name, content: content)
        } else {
            document?.update(name: name, content: content)
        }
        
        if let document = document {
            do {
                let managedContext = document.managedObjectContext
                
                try managedContext?.save()
                
                
            } catch {
                print("Document could not be saved")
            }
        }
        
        self.navigationController?.popViewController(animated: true)
 
    }

}

