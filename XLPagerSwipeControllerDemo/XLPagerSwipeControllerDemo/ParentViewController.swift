//
//  ViewController.swift
//  XLPagerSwipeControllerDemo
//
//  Created by Shubham on 08/08/18.
//  Copyright © 2018 Shubham. All rights reserved.
//

import UIKit
import XLPagerTabStrip


class ParentViewController: ButtonBarPagerTabStripViewController {

    @IBOutlet weak var barButtunView: ButtonBarView!
    
    let purpleInspireColor = UIColor.black
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //1.Please Check the storyBoard i have taken  Scroll View as Container View by making outlet just select scrollView and right click u get new referencing outlet make to as Container View
        
        //2. Next i have taken Collection View and deleted the cells from it and same i have given its outlet as BarButtonView (same right click u get new referencing outlet) dont forget to give the class for this collection view, Class name:ButtonBarView and Module:XLPagerTabStrip U can check in StoryBoard....
        
        
        settings.style.buttonBarItemBackgroundColor = UIColor.lightGray//(red:151.0/255.0, green:209.0/255.0, blue:90.0/255.0, alpha:1.0)
        settings.style.selectedBarBackgroundColor = .clear//purpleInspireColor
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 0.5
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        
        changeCurrentIndexProgressive = { [weak self] (oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .white
            newCell?.label.textColor = self?.purpleInspireColor
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController]
    {
        
        //here are the my VC the number of VC u give u can get those many upon swipe left to right,Right to left....
      
        let firstObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"FirstViewController")
        let secondObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"SecondViewController")
        let thirdObj = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:"ThirdViewController")
        
        return [firstObj,secondObj,thirdObj]
    }
    
    
    
    
    
}
