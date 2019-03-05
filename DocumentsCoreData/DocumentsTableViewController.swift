//
//  DocumentsTableViewController.swift
//  DocumentsCoreData
//
//  Created by Zachary Pierucci on 2/21/19.
//  Copyright © 2019 Zachary Pierucci. All rights reserved.
//

import UIKit
import CoreData

class DocumentsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var documentsTableView: UITableView!
    
    let dateFormatter = DateFormatter()
    
    var documents = [Document]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        
        documentsTableView.delegate = self
        documentsTableView.dataSource = self
    }
    
    //viewWillAppear function, guided by Expenses application tutorial on youtube
    override func viewWillAppear(_ animated: Bool) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Document> = Document.fetchRequest()
        
        do {
            documents = try managedContext.fetch(fetchRequest)
        } catch {
            print("Fetch could not be performed")
        }
        
        documentsTableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        if let cell = cell as? DocumentsTableViewCell {
            let doc = documents[indexPath.row]
            cell.nameLabel.text = doc.name
            let sizeHolder = String(doc.size)
            cell.sizeLabel.text = "Size: " + sizeHolder + " bytes"
            
            if let formattedDate = doc.modDate {
                cell.dateLabel.text = "Modified: " + dateFormatter.string(from: formattedDate)
            } else {
                cell.dateLabel.text = "Error"
            }
            
        }

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    //function to delete a document
    func delete(at indexPath: IndexPath) {
        let document = documents[indexPath.row]
        
        if let managedObjectContext = document.managedObjectContext {
            managedObjectContext.delete(document)
            
            do {
                try managedObjectContext.save()
                self.documents.remove(at: indexPath.row)
                documentsTableView.deleteRows(at: [indexPath], with: .automatic)
            } catch {
                print("Could not delete document")
                documentsTableView.reloadData()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //slide to delete from first documents project
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") {
            (action, index) in
            self.delete(at: indexPath)
        }
        
        return [delete]
    }
    
    
    //segue for editing existing documents
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DocumentsViewController,
            let seg = segue.identifier, seg == "editDocument",
            let row = documentsTableView.indexPathForSelectedRow?.row {
                destination.document = documents[row]
            }
    }

}




