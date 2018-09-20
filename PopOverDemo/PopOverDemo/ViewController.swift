//
//  ViewController.swift
//  PopOverDemo
//
//  Created by Shubham on 20/09/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    @IBAction func actionAlert(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: "Alert message here", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "Default", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some action here.
        })
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (alert: UIAlertAction!) -> Void in
            //  Do some destructive action here.
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (alert: UIAlertAction!) -> Void in
            //  Do something here upon cancellation.
        })
        
        alertController.addAction(defaultAction)
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = self.view
            popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        self.present(alertController, animated: true, completion: nil)
    }
    
}

