//
//  BackgroundJobExample.swift
//  BP
//
//  Created by Aleš Kůtek on 05.02.2021.
//

import Foundation
import UIKit



class BackgroundJobExample {
    var textInput = "";

    func run() {
        DispatchQueue.global(qos: .background).async {
            //do the hard work
            let x: Int = 1 + 1;
            
            DispatchQueue.main.async {[unowned self] in
                //update the ui
                
                self.textInput = String(x)
            }
        }
    }

}
