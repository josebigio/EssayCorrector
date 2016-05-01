//
//  AppDelegate.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 4/18/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import UIKit
import PSPDFKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        PSPDFKit.setLicenseKey("TAQBcd1mzc3/yk2VvHhxnTsgIsEYWOFKodI2KPBv+NIIbT4IUm4PhMp6EUlR+4TckaZf9J2QPquXkmzsvOea8ewkQPpHl5PP1QQdrPrJx+E14gX4raF+QliDcPvLDp0IEwYOda0zy1hSod5cnjGiciGorUyyusvTdMXSV27pAnXIrbV4ecufHPzfZauuCVTXVnL3VeMBIQFUAkqZdAz42aAYAWOghDJcRVoKBkxuzfC5zDEia50iIlq2Y0DGHTDuuNZpBABiEIqeH7ls7fJXit2BFMvuDQwO1qnuRtfXwsa/E2YEf4jT1WM1gcoIjELvi0QRWmVbgdxkp3Q56YZGVmFMmA/hQeoAjgcKLOB1y+NxQ9AeC9xoxQq09fzlo2eIEsfvLIuAKk893ExOVdCyAfcChpvkZ5xMxW3ztAaZKUnzXa319WCyDlGiJ45FoNuc")
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        print("trying to open the file");
        NSUserDefaults.standardUserDefaults().setValue(url.absoluteString, forKey: ViewController.LAST_FILE_KEY)
        return true;
    }
    
    func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

}

