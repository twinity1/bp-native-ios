//
//  PerformanceViewController.swift
//  BP
//
//  Created by Aleš Kůtek on 25.03.2021.
//

import Foundation
import UIKit

class PerformanceViewController : UIViewController, UITableViewDataSource {
    @IBOutlet weak var table: UITableView!
    
    var data = Array<String>()
    
    override func viewDidLoad() {
        table.dataSource = self
        
        for var i in 0...99999 {
            data.append("Text.... \(i)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    @objc func tapped(_ gest: UITapGestureRecognizer) {
        let btn = gest.view as! UIButton
        
        data.remove(at: btn.tag)
        table.deleteRows(at: [IndexPath(row: btn.tag, section: 0)], with: .fade)
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CellPrototype;
            
        cell.indexPath = indexPath
        cell.btn.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
        cell.btn.tag = indexPath.row
        cell.customText.text = data[indexPath.row]
        
        return cell;
    }
}

class CellPrototype : UITableViewCell {
    
    @IBOutlet weak var customText: UILabel!
    @IBOutlet weak var btn: UIButton!
    var indexPath: IndexPath!
    
    
    
    
    
    
}
