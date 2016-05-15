//
//  CBObjects.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/8/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation

//@property (nonatomic, strong) CBLDatabase *database;
//@property (nonatomic, strong) CBLManager *manager;


class CBObjects {
    static let sharedInstance = CBObjects()
    var database: CBLDatabase?
    var manager: CBLManager?
    let DBNAME: String = "josedb"
    
    private init() {
        manager = CBLManager.sharedInstance()
        do {
            database = try manager?.databaseNamed(DBNAME)
        }
        catch let error as NSError{
            print("Could not init database: " + error.localizedDescription)
        }
        
    }
}

