//
//  LightstatusBarNavController.swift
//  KindleApp
//
//  Created by Carlos Gonzalez on 14/09/2019.
//  Copyright © 2019 Carlos Gonzalez. All rights reserved.
//

import UIKit

class LightstatusBarNavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
 }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
        
        
    }
}
