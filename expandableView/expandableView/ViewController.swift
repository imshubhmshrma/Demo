//
//  ViewController.swift
//  expandableView
//
//  Created by Shubham on 01/09/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
/*
 
 ->If u want the view controller to expand as per the data inside the
 Label data and other elements
 Step 1 —>  then add a [parentView(0,0,0,0)to Superview] to the viewcontroller
 Step 2 —>  then add [scrollView(0,0,0,0)to parentView] to the viewcontroller
 Step 3 —>  and add a [childView(0,0,0,0)to scrollView]
 Step 4 —>  add the elements (labels and textView)
 Step 5 —>  for a particular label , go to attribute inspector and then set the Line Break to Word Wrap and then number of lines to 0(Zero) .
 NOTE:- Please do not set height of the label , just set the leading and trailing and top constraints , so that it can expand downwards.
 Step 5 —>  please set the bottom space to desired points
 and this would show a large data on screen and also works on less and no data in label
 
 
 
 
 */
