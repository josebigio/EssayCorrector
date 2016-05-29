//
//  CommentSaver.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/27/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class CommentSaver {
    
    static func save(commentData: CommentData) -> Bool {
        var jsonData:NSData?
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(formatDataForSaving(commentData.getData()), options: NSJSONWritingOptions.PrettyPrinted)
        } catch let error as NSError {
            print(error)
        }
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Comment")
        var comments = [NSManagedObject]()
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            comments = results as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        if(comments.count == 0) {
            let entity = NSEntityDescription.entityForName("Comment", inManagedObjectContext: managedContext)
            let comment = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
            comment.setValue(jsonData, forKey: "data")
        }
        else {
            comments[0].setValue(jsonData, forKey: "data")
        }
        
        do {
            try managedContext.save()
            return true
        }
        catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
            return false
        }
    }
    
    static func getSavedComment() -> CommentData? {
        var comments = [NSManagedObject]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Comment")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            comments = results as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        var result:[(String,Bool)]
        if(comments.count != 0) {
            let commentWithFormatForSaving = comments[0].valueForKey("data") as! NSData
            var decoded = [String:Bool]()
            do {
                decoded = try NSJSONSerialization.JSONObjectWithData(commentWithFormatForSaving, options: []) as![String:Bool]
                result = formatSavedDataForInitiliazation(decoded)
            } catch let error as NSError {
                print(error)
                return nil
            }
            
            return CommentData(commentData: result)
        }
       return CommentData()
    }
    
    static func formatDataForSaving(unFormated: [(String,Bool)]) -> [String:Bool] {
        var result = [String:Bool]()
        for(comment,state) in unFormated {
            result[comment] = state
        }
        return result
    }
    
    static func formatSavedDataForInitiliazation(newData: [String:Bool]) ->[(String,Bool)]{
        var result = [(String,Bool)]()
        for(comment,state) in newData {
            result.append((comment,state))
        }
        return result
    }
    
}
