//
//  ViewController.swift
//  MyApp19
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let appMain = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var nametext: UITextField!
    
    @IBAction func setname(_ sender: Any) {
        guard NSMutableDictionary(contentsOfFile: gamedataFile) != nil else {
            return
        }
        let gamedata = NSMutableDictionary(contentsOfFile: gamedataFile)
        gamedata!["name"] = nametext.text
        gamedata!["test"] = "Hollo"

        gamedata?.write(toFile: gamedataFile, atomically: true)
        
    }
    
    
    @IBAction func getsql(_ sender: Any) {
        
        let sql = "SELECT * FROM cust"
        var point:OpaquePointer? = nil
        if sqlite3_prepare(appMain.db, sql, -1, &point, nil) == SQLITE_OK{
            print("OK")
        }
        
        while sqlite3_step(point) == SQLITE_ROW{
            let cname = sqlite3_column_text(point, 1)
            
            print(String(cString: cname!))
            
        }
    }
    
    
    let gamedataFile = NSHomeDirectory() + "/Documents/gamedata.plist"
    override func viewDidLoad() {
        super.viewDidLoad()
        let gamedata = NSMutableDictionary(contentsOfFile: gamedataFile)
//        print(gamedata!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

