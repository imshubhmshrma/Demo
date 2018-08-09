//
//  ThirdViewController.swift
//  XLPagerSwipeControllerDemo
//
//  Created by Shubham on 08/08/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class ThirdViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension ThirdViewController:IndicatorInfoProvider{
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
         // return IndicatorInfo(image: #imageLiteral(resourceName: "Logoo"))
        return IndicatorInfo(title:"Third")
    }
}
