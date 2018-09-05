//
//  EditDataViewController.swift
//  CoreDataDemoo
//
//  Created by Shubham on 29/08/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit
import CoreData

class EditDataViewController: UIViewController {
    
    var dataCredentials: [NSManagedObject] = []
     var dataCredential: NSManagedObject?
    var  indexDataCredential:Int?
  
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        
        
        
        
        
        txtPhone.delegate = self
        txtAddress.delegate = self
        txtEmailAddress.delegate = self
        txtName.delegate = self
        
        if dataCredential != nil{
            txtName.text! = (dataCredential?.value(forKeyPath: "name") as? String)!
            txtEmailAddress.text! = (dataCredential?.value(forKeyPath: "emailAddress") as? String)!
            txtAddress.text! = (dataCredential?.value(forKeyPath: "address") as? String)!
            txtPhone.text! = (dataCredential?.value(forKeyPath: "phoneNumber") as? String)!
        }
    
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
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    @IBAction func actionSave(_ sender: UIButton) {
        
        self.editCell(index: indexDataCredential!)
        
    }
    
    @IBAction func actionClear(_ sender: UIButton) {
        txtName.text! = ""
        txtEmailAddress.text! = ""
        txtPhone.text! = ""
        txtAddress.text! = ""
    }
    
}
extension EditDataViewController{
    
    func fetchData(){
        let noteEntity = "Credentials" //Entity Name
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Error While Deleting Note: \(error.userInfo)")
        }
        
        
        
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)
        
        do {
            dataCredentials = try managedContext.fetch(fetchRequest) as! [NSManagedObject]
            print("🚘",dataCredentials)
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
    }

    func editCell(index: Int){
        let noteEntity = "Credentials" //Entity Name
        
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let note = dataCredentials[index]
        
        note.setValue(txtName.text!, forKeyPath: "name")
        note.setValue(txtEmailAddress.text!, forKey: "emailAddress")
        note.setValue(txtPhone.text!, forKey: "phoneNumber")
        note.setValue(txtAddress.text!, forKey: "address")
        
        do {
             managedContext.insert(note)
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
     
        
    }
    
    
}
extension EditDataViewController : UITextFieldDelegate{
 func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
 textField.resignFirstResponder()
 return true
 }
 }
 
 extension EditDataViewController : UITextViewDelegate{
    
 func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
 if(text == "\n") {
 textView.resignFirstResponder()
 return false
 }
 return true
 }
 
 func textViewDidBeginEditing(_ textView: UITextView) {
 if textView.textColor == UIColor.lightGray {
 textView.text = nil
 textView.textColor = UIColor.black
 }
 }
 func textViewDidEndEditing(_ textView: UITextView) {
 if textView.text.isEmpty {
 textView.textColor = UIColor.lightGray
 }
 }
}
 
 
