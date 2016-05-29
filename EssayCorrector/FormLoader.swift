//
//  FormLoader.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/24/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class FormLoader {

static func save(formData:ScoreData) -> Bool {
    var jsonData:NSData?
    do {
        jsonData = try NSJSONSerialization.dataWithJSONObject(FormLoader.formatDataForSaving(formData.getData()), options: NSJSONWritingOptions.PrettyPrinted)
    } catch let error as NSError {
        print(error)
    }
    
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    
    let entity = NSEntityDescription.entityForName("Form", inManagedObjectContext: managedContext)
    let form = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
    form.setValue(jsonData, forKey: "data")
    form.setValue(formData.getfileName(),forKey: "name")
    do {
        try managedContext.save()
        return true
    }
    catch let error as NSError {
        print("Could not save \(error), \(error.userInfo)")
        return false
    }
}

static func load(fileName: String) -> ScoreData? {
    var forms = [NSManagedObject]()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let managedContext = appDelegate.managedObjectContext
    let fetchRequest = NSFetchRequest(entityName: "Form")
    do {
        let results = try managedContext.executeFetchRequest(fetchRequest)
        forms = results as! [NSManagedObject]
    }
    catch let error as NSError {
        print("Could not fetch \(error), \(error.userInfo)")
    }
    for form in forms {
        if(form.valueForKey("name") as! String == fileName) {
            let formData = form.valueForKey("data") as! NSData
            var decoded = [String:[[String:[Int]]]]()
            do {
                decoded = try NSJSONSerialization.JSONObjectWithData(formData, options: []) as! [String:[[String:[Int]]]]
                return ScoreData(formData: FormLoader.formatSavedDataForInitiliazation(decoded),fileName: fileName)
            } catch let error as NSError {
                print(error)
                return nil
            }
        }
    }
    return nil
}
    
    static func getAllForms() -> [ScoreData]? {
        var forms = [NSManagedObject]()
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Form")
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            forms = results as! [NSManagedObject]
        }
        catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        var result = [ScoreData]()
        for form in forms {
            let formData = form.valueForKey("data") as! NSData
            let fileName = form.valueForKey("name") as! String
            var decoded = [String:[[String:[Int]]]]()
            do {
                decoded = try NSJSONSerialization.JSONObjectWithData(formData, options: []) as![String:[[String:[Int]]]]
                result.append(ScoreData(formData: formatSavedDataForInitiliazation(decoded),fileName: fileName))
            } catch let error as NSError {
                print(error)
                return nil
            }
            
        }
        return result
    }
    
   static func formatDataForSaving(unFormated: [String:[(String,(Int,Int))]]) -> [String:[[String:[Int]]]] {
        var result = [String:[[String:[Int]]]]()
        for(criteria,subCriterias) in unFormated {
            var subCriteriaDictArray = [[String:[Int]]]()
            for sub in subCriterias {
                subCriteriaDictArray.append([sub.0:[sub.1.0,sub.1.1]])
            }
            result[criteria] = subCriteriaDictArray
        }
        return result
    }
    
    static func formatSavedDataForInitiliazation(newData: [String:[[String:[Int]]]]) -> [String:[(String,(Int,Int))]]{
        var result = [String:[(String,(Int,Int))]]()
        for(criteria,subCriteriaDictArray) in newData {
            var subCriteriaList = [(String,(Int,Int))]()
            for subCriteriaDict in subCriteriaDictArray {
                for(subCriteria,scoresArray) in subCriteriaDict {
                    subCriteriaList.append((subCriteria,(scoresArray[0],scoresArray[1])))
                }
            }
            result[criteria] = subCriteriaList
        }
        return result
    }

}
