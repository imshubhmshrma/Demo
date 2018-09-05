//
//  ShowDataViewController.swift
//  CoreDataDemoo
//
//  Created by Shubham on 29/08/18.
//  Copyright © 2018 Shubham. All rights reserved.
//https://www.raywenderlich.com/353-getting-started-with-core-data-tutorial

import UIKit
import CoreData

class ShowDataViewController: UIViewController {
    
    var dataCredentials: [NSManagedObject] = []
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        self.showDatta()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}


extension ShowDataViewController{
    func editCell(index: Int){
        
        let noteEntity = "Credentials" //Entity Name
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
          let note = dataCredentials[index]
         let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EditDataViewController") as! EditDataViewController
        nextViewController.dataCredential = note
        nextViewController.indexDataCredential = index
        self.navigationController?.pushViewController(nextViewController, animated: true)
       
    }
    
    
    func deletCell(index: Int){
        let noteEntity = "Credentials" //Entity Name
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let note = dataCredentials[index]
            managedContext.delete(note)
            
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
            
       
        
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
        
        do {
            dataCredentials = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        tableView.reloadData()
        
    }
    
    func showDatta(){
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Credentials")
        
        //3
        do {
            dataCredentials = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
         tableView.reloadData()
        
    }
}

extension ShowDataViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            //TODO: edit the row at indexPath here
            
            let row = indexPath.row
            print("🎯 Edit the row at index => \(row)")
            self.editCell(index: row
            )
            
        }
        editAction.backgroundColor = UIColor.lightGray
        
        let deleteAction = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            //TODO: Delete the row at indexPath here
            
            let row = indexPath.row
            print("🛑 Delete the row at index => \(row)")
           self.deletCell(index: row)
        }
        deleteAction.backgroundColor = UIColor.darkGray
        
        return [editAction,deleteAction]
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //    tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        let row = indexPath.row
        print("🚹 Selected Row: \(row+1)")
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
  /*  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     
     let row = indexPath.row
     print("🛑 Delete the row at index => \(row)")
     let noteEntity = "Credentials" //Entity Name
     
     let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     let note = dataCredentials[indexPath.row]
     if editingStyle == .insert {
     managedContext.insert(note)
     
     do {
     try managedContext.save()
     } catch let error as NSError {
     print("Error While Deleting Note: \(error.userInfo)")
     }
     }
     
     if editingStyle == .delete {
     managedContext.delete(note)
     
     do {
     try managedContext.save()
     } catch let error as NSError {
     print("Error While Deleting Note: \(error.userInfo)")
     }
     
     }
     
     //Code to Fetch New Data From The DB and Reload Table.
     let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
     
     do {
     dataCredentials = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
     } catch let error as NSError {
     print("Error While Fetching Data From DB: \(error.userInfo)")
     }
     tableView.reloadData()
     
     
    } */
    
}


extension ShowDataViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataCredentials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let personData = dataCredentials[indexPath.row]
        
        let cell: ShowDataTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShowDataTableViewCell.identifier , for: indexPath as IndexPath) as! ShowDataTableViewCell
        
        cell.lblName.text! = (personData.value(forKeyPath: "name") as? String)!
        cell.lblAddress.text! = (personData.value(forKeyPath: "address") as? String)!
        cell.lblEmailAddress.text! = (personData.value(forKeyPath: "emailAddress") as? String)!
        cell.lblPhoneNumber.text! = (personData.value(forKeyPath: "phoneNumber") as? String)!
        return cell
        
    }
    
   
    
    
}


class ShowDataTableViewCell : UITableViewCell{
    static let identifier = "ShowDataTableViewCell"
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmailAddress: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    
}
