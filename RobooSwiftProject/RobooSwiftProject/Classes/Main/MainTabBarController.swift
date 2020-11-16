//
//  MainTabBarController.swift
//  RobooSwiftProject
//
//  Created by 物联网美天科技 on 2018/8/29.
//  Copyright © 2018年 物联网美天科技. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.addChildViewControllers()
    }

    func addChildViewControllers() {
        var classNameArr:[String] = ["Rehearse","Home","Mine"]
        var titleName:[String] = ["基础","预演","实例"]
        var imgNormal:[String] = ["tabBar_essence_icon","tabBar_friendTrends_icon","tabBar_new_icon"]
        var imgSelect:[String] = ["tabBar_essence_click_icon","tabBar_friendTrends_click_icon","tabBar_new_click_icon"]
        for index in 0...2 {
            let className = "RobooSwiftProject."+classNameArr[index]+"ViewController"
            let myClass =  NSClassFromString(className) as? UIViewController.Type
            let VC = myClass!.init()

            self.addChildViewController(childerVC: VC, title: titleName[index] as NSString, normalImg: imgNormal[index] as NSString, selectedImg: imgSelect[index] as NSString)
        }
    }

    //添加子控制器
    func addChildViewController(childerVC:UIViewController,title:NSString,normalImg:NSString,selectedImg:NSString)  {

        self.tabBarItem.title = title as String

        childerVC.title = title as String

        var norImg = UIImage(named:normalImg as String)
        norImg = norImg?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        var selImg = UIImage(named:selectedImg as String)
        selImg = selImg?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)

        let tabItem = UITabBarItem(title: title as String, image: norImg,selectedImage: selImg)

        let naVc = BaseNavigationController()

        naVc.tabBarItem = tabItem

        naVc.addChildViewController(childerVC)

        self.addChildViewController(naVc)
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
