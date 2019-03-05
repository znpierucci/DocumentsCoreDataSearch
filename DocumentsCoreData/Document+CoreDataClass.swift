//
//  Document+CoreDataClass.swift
//  DocumentsCoreData
//
//  Created by Zachary Pierucci on 2/21/19.
//  Copyright © 2019 Zachary Pierucci. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Document)
public class Document: NSManagedObject {
    
    //formats the date, guided by Expenses tutorial on youtube
    var modDate: Date? {
        get {
            return date as Date?
        } set {
            date = newValue as NSDate?
        }
    }

    //initializer, guided by Expenses tutorial on youtube
    convenience init?(name: String?, content: String?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Document.entity(), insertInto: managedContext)
        
        self.name = name
        self.modDate = Date(timeIntervalSinceNow: 0)
        self.content = content
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
        
    }
    
    //function that updates the document upon change/editing
    func update(name: String, content: String?) {
        self.name = name
        self.modDate = Date(timeIntervalSinceNow: 0)
        self.content = content
        if let size = content?.count {
            self.size = Int64(size)
        } else {
            self.size = 0
        }
    }

}


