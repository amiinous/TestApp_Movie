//
//  mainTabVC.swift
//  GoMoviez
//
//  Created by Amin Fotovat on 7/11/17.
//  Copyright © 2017 Aminous. All rights reserved.
//

import Foundation
import XLPagerTabStrip

class mainTabVC: ButtonBarPagerTabStripViewController {
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let mainPage = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainPage")
        let fake1 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "fake1")
        let fake2 = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "fake2")
        return [mainPage, fake1, fake2]
    }
    
    override func viewDidLoad() {
        settings.style.buttonBarBackgroundColor = UIColor(white: 0, alpha: 0.85)
        settings.style.buttonBarItemBackgroundColor = UIColor(white: 0, alpha: 0.85)
        settings.style.selectedBarBackgroundColor = UIColor.yellow
        settings.style.buttonBarItemFont = .boldSystemFont(ofSize: 14)
        settings.style.selectedBarHeight = 2.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .white
        settings.style.buttonBarItemsShouldFillAvailiableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        

        
        //the properties should be set BEFORE the viewDidLoad
        super.viewDidLoad()
        
        self.navigationItem.title = "GOMOVIEZ"
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationItem.backBarButtonItem = backButton
        
        let magnifierButton = UIBarButtonItem()
        magnifierButton.image = #imageLiteral(resourceName: "magnifier")
        self.navigationItem.rightBarButtonItem = magnifierButton
        
        let menuButton = UIBarButtonItem()
        menuButton.image = #imageLiteral(resourceName: "menu")
        self.navigationItem.leftBarButtonItem = menuButton
        
        self.navigationController?.navigationBar.isTranslucent = false //Prevent the navigationbar from covering over the underneath viewcontroller
    }
}
