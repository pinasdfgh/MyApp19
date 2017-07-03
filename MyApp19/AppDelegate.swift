//
//  AppDelegate.swift
//  MyApp19
//
//  Created by user on 2017/7/3.
//  Copyright © 2017年 user. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var db:OpaquePointer?
    let fmgr = FileManager.default
    //用到旁邊的檔案在App內要用需要在Build phase/bundle resource中登入之後用Bundle方法呼叫
    let gamedata = Bundle.main.path(forResource: "game data", ofType: "plist")
    let docDir = NSHomeDirectory() + "/Documents"


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        print(docDir)
        // Override point for customization after application launch.
        if !fmgr.fileExists(atPath: docDir + "/gamedata.plist"){
            do{
//                print(docDir)
                try fmgr.copyItem(atPath: gamedata!, toPath: docDir + "/gamedata.plist")
            }catch{
                print(error)
            }
            
        }
        //資料庫
        let mydb = Bundle.main.path(forResource: "mydb", ofType: "sqlite")
        let newdb = docDir + "/mydb.sqlite"
        guard !fmgr.fileExists(atPath: newdb) else{
            if sqlite3_open(newdb, &db) == SQLITE_OK{
                print("OK123")
            }else{
                print("NGss")
            }
            print("XX")
            return true
        }
        do{
            try fmgr.copyItem(atPath: mydb!, toPath: newdb)
            print("ok")
        }catch{
            print(error)
        }
        
        if sqlite3_open(newdb, &db) == SQLITE_OK{
            print("OK123")
        }else{
            print("NGss")
        }
        
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        sqlite3_close(db)
    }


}

