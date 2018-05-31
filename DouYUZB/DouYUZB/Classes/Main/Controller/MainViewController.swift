//
//  MainViewController.swift
//  DouYUZB
//
//  Created by mxm on 2018/5/31.
//  Copyright © 2018年 mxm. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildVC(name: "Home")
        addChildVC(name: "Live")
        addChildVC(name: "Follow")
        addChildVC(name: "Profile")
    }
    
    private func addChildVC(name: String) {
        let childVc = UIStoryboard(name: name, bundle: nil)
            .instantiateInitialViewController()!
        
        addChildViewController(childVc)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
