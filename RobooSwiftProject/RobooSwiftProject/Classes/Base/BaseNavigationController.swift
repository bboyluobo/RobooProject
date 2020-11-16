//
//  BaseNavigationController.swift
//  RobooSwiftProject
//
//  Created by 物联网美天科技 on 2018/8/29.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if (self.childViewControllers.count != 0) {
            viewController.hidesBottomBarWhenPushed = true;
        }
        super.pushViewController(viewController, animated: animated)
    }

    override var shouldAutorotate: Bool {
        return self.topViewController!.shouldAutorotate
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return self.topViewController!.supportedInterfaceOrientations
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
