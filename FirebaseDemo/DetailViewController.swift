//
//  DetailViewController.swift
//  FirebaseDemo
//
//  Created by Duncan on 2016/6/22.
//  Copyright © 2016年 Duncan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var theProduct: AnyObject?
    //用theProduct取回Array
    var productArr = [AnyObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
