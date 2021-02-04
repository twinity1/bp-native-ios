//
//  StorageViewController.swift
//  BP
//
//  Created by Aleš Kůtek on 04.02.2021.
//

import Foundation
import UIKit

class StorageViewController : UIViewController {
    
    @IBOutlet weak var resultText: UITextView!
    @IBOutlet weak var targetText: UITextField!
    
    @IBAction func save(_ sender: Any) {
        var filename = getFile()
        
        let text = targetText.text ?? ""
        
        try! text.write(to: filename, atomically: true, encoding: String.Encoding.utf8)
    }
    
    @IBAction func load(_ sender: Any) {
        var filename = getFile()
        
        do {
            let content = try String(contentsOf: filename, encoding: String.Encoding.utf8)
            resultText.text = content

        } catch let error {
            resultText.text = "There was an error during loading of the file!"
        
        }
        
        
    }
    
    func getFile() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url = paths[0]
        url.appendPathComponent("example.txt")
        
        return url
    }
}
