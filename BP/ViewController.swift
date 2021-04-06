//
//  ViewController.swift
//  BP
//
//  Created by Aleš Kůtek on 04.02.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var performanceBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        performanceBtn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPerformance)))
    }
    
    
    @objc func showPerformance() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PerformanceViewController")
        
        present(controller, animated: false, completion: nil)
        
    }


}

