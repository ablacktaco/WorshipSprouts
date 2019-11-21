//
//  LoadingSproutsViewController.swift
//  WorshipSprouts
//
//  Created by 陳姿穎 on 2019/11/18.
//  Copyright © 2019 陳姿穎. All rights reserved.
//

import UIKit

class LoadingSproutsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        sproutsImage.center.x = -sproutsImage.frame.width/2
        UIView.animate(withDuration: 3, animations: {
            self.sproutsImage.center.x += (self.sproutsImage.frame.width + self.view.frame.width)/2
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }
    
    @IBOutlet private var sproutsImage: UIImageView!
    
}
