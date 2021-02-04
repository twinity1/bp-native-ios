//
//  FaceIDViewContoller.swift
//  BP
//
//  Created by Aleš Kůtek on 04.02.2021.
//

import Foundation
import UIKit
import LocalAuthentication

class FaceIDViewController : UIViewController {
    @IBOutlet weak var resultTextView: UITextView!
    
    override func viewDidAppear(_ animated: Bool) {
        let context = LAContext()
        
        let reason = "Testing :))"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason ) { success, error in
            DispatchQueue.main.async { [unowned self] in

            if success {
                self.resultTextView.text = "Success"
            } else {
                self.resultTextView.text = (error?.localizedDescription ?? "Failed to authenticate")
            }
            }
        }
    }
}
