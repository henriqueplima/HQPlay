//
//  ViewController.swift
//  HQPlay
//
//  Created by Henrique Pereira de Lima on 04/12/18.
//  Copyright © 2018 Henrique Pereira de Lima. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var imageView1: ImageLoader!
    
    @IBOutlet weak var imageView2: ImageLoader!
    
    let url = "http://i.annihil.us/u/prod/marvel/i/mg/c/80/5e3d7536c8ada.jpg"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

