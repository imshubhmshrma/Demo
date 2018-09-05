//
//  ViewController.swift
//  CoreDataDemoo
//
//  Created by Shubham on 29/08/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit
import CoreData

class SaveDataViewController: UIViewController {

    
    var dataCredentials: [NSManagedObject] = []
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmailAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtAddress: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtName.delegate = self
        txtEmailAddress.delegate = self
        txtPhoneNumber.delegate =  self
        txtAddress.delegate = self
        txtAddress.text = "Address"
        txtAddress.textColor = UIColor.lightGray
        hideKeyboardWhenTappedAround()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtName.text! = ""
        txtEmailAddress.text! = ""
        txtPhoneNumber.text! = ""
        txtAddress.text! = ""
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    @IBAction func showStackImage(_ sender: UIButton) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowStackViewController") as! ShowStackViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func showData(_ sender: UIButton) {
        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "ShowDataViewController") as! ShowDataViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    @IBAction func actionSubmit(_ sender: UIButton) {
        if txtAddress.text! != "" && txtEmailAddress.text! != "" && txtName.text! != "" && txtPhoneNumber.text! != "" {
             self.save(name: txtName.text!, emailAddress: txtEmailAddress.text!, phoneNumber: txtPhoneNumber.text!, address: txtAddress.text!)
        } else {
            let alert = UIAlertController(title: "Alert", message: "Please enter all the fields", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")                    
                case .cancel:
                    print("cancel")
                case .destructive:
                    print("destructive")
                }}))
            self.present(alert, animated: true, completion: nil)

        }
       
    }
    
    @IBAction func actionClear(_ sender: UIButton) {
        txtName.text! = ""
        txtEmailAddress.text! = ""
        txtPhoneNumber.text! = ""
        txtAddress.text! = ""
        
    }
    
}

extension SaveDataViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}

extension SaveDataViewController : UITextViewDelegate{
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
            textView.text = "Address"
            textView.textColor = UIColor.lightGray
        }
    }
    
    
}



extension SaveDataViewController{
    // functions
    
    func save(name: String , emailAddress: String , phoneNumber: String , address: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Credentials",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        person.setValue(emailAddress, forKey: "emailAddress")
        person.setValue(phoneNumber, forKey: "phoneNumber")
        person.setValue(address, forKey: "address")
        // 4
        do {
            try managedContext.save()
            dataCredentials.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SaveDataViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}



