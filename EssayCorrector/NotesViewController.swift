//
//  NotesViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/8/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddSubCriteriaFooterCellDelegate,SubCriteriaTableViewCellDelegate{

    @IBOutlet weak var formTableView: UITableView!
    let DEFAULT_MAX_SCORE = 5
    
    enum VIEW_TYPES {
        case Normal
        case Header
        case Footer
    }
    
    var data = ScoreData()
    
    var footerCell:AddTableViewCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Notes: viewDidLoad()")
        
        formTableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        
        footerCell = formTableView.dequeueReusableCellWithIdentifier("addCriteriaCell") as? AddTableViewCell
        footerCell!.addButton.addTarget(self, action: #selector(NotesViewController.addCriteria(_:)), forControlEvents: .TouchUpInside)
        formTableView.tableFooterView = footerCell!.contentView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    // MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getNumberOffCells()
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var count = 0
        for(criteria,subCriterias) in data.data {
            if(count == indexPath.row) {
                //it is a CriteriaTableViewCell
                let cell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! CriteriaTableViewCell
                cell.criteria.text = criteria
                return cell
            }
            count+=1
            for sub in subCriterias {
                if(count == indexPath.row) {
                    //it is a SubCriteriaTableViewCell
                    let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SubCriteriaTableViewCell
                    cell.subCriteria.text = sub.0
                    cell.score.setMax(sub.1.1)
                    cell.score.setScore(sub.1.0)
                    cell.delegate = self
                    cell.selectionStyle = .None
                    return cell
                }
                count+=1
            }
            if(count == indexPath.row) {
                //it is an AddSubCriteriaCell
                let cell = tableView.dequeueReusableCellWithIdentifier("addSubCriteriaCell") as! AddSubCriteriaFooterCell
                cell.criteriaKey = criteria
                cell.delegate = self
                return cell
            }
            count+=1
        }
        
        return UITableViewCell()
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        var count = 0
        for(_,subcriteria)in data.data {
            if(count == indexPath.row) {
                return true
            }
            count+=1
            for _ in subcriteria {
                if(count == indexPath.row) {
                    return true
                }
                count+=1
            }
            if(count == indexPath.row) {
                return false
            }
            count+=1
        }
        
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var count = 0
            for(criteria,subCriterias) in data.data {
                if(count == indexPath.row) {
                    var rowToDeleteCount = 1
                    var indexPaths = [NSIndexPath]()
                    indexPaths.append(indexPath)
                    for _ in data.data[criteria]! {
                        indexPaths.append(NSIndexPath(forRow: rowToDeleteCount + indexPath.row, inSection: indexPath.section))
                        rowToDeleteCount+=1
                    }
                    indexPaths.append(NSIndexPath(forRow: rowToDeleteCount + indexPath.row, inSection: indexPath.section)) //for the addCell
                    data.data.removeValueForKey(criteria)
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    recalculateScore()
                    return
                }
                count+=1
                for _ in subCriterias {
                    var subCriteriaNum = 0
                    if(count == indexPath.row) {
                        //it is a SubCriteriaTableViewCell
                        var subCriterias = data.data[criteria]
                        subCriterias?.removeAtIndex(subCriteriaNum)
                        data.data[criteria] = subCriterias
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                        recalculateScore()
                        return
                    }
                    count+=1
                    subCriteriaNum+=1
                }
                if(count == indexPath.row) {
                    //it is an AddSubCriteriaCell, it should never get here
                    return
                }
                count+=1
            
            }
        }
        
        
    }
    
    
    // MARK: SubCriteriaTableViewCellDelegate
    func scoreChanged(cell: SubCriteriaTableViewCell) {
        for (criteria,subCriterias) in data.data {
            var index = 0
            for subCriteria in subCriterias {
                if(subCriteria.0.containsString(cell.subCriteria.text!)) {
                    var newSubCriterias = subCriterias
                    var newCriteria = subCriteria
                    newCriteria.1.0 = cell.score.getScore()
                    newSubCriterias[index] = newCriteria
                    data.data[criteria] = newSubCriterias
                    recalculateScore()
                    return
                }
                index+=1
            }
        }
    }
    
    // MARK AddSubCriteriaFooterCellDelegate
    func addSubCriteriaToCriteria(criteria: String?) {
        let alertController = UIAlertController(title: criteria, message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                let name = alertController.textFields!.first!.text!
                var score:Int? = Int(alertController.textFields![1].text!)
                if (score == nil) {
                    score = self.DEFAULT_MAX_SCORE
                }
                var subCriterias = self.data.data[criteria!]
                subCriterias?.append((name,(0,score!)))
                self.data.data[criteria!] = subCriterias
                self.formTableView.reloadData()
                self.recalculateScore()
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in
            tf.keyboardType = .NumberPad}
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK private helpers
    func addSubCriteria(section: Int, subCriteria: String, maxScore:Int) {
        var keys = [String](data.data.keys)
        var subCriterias = data.data[keys[section]]
        subCriterias?.append((subCriteria,(0,maxScore)))
        data.data[keys[section]] = subCriterias
        formTableView.reloadData()
    }
    
    func addCriteria(button: UIButton) {
        let alertController = UIAlertController(title: "Add a criteria", message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                self.data.data[alertController.textFields!.first!.text!] = []
                self.formTableView.reloadData()
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    private func recalculateScore() {
        let total = data.getTotal()
        footerCell?.totalLabel.text = "\(total.0)/\(total.1)"
    }
    
    private func getNumberOffCells() -> Int {
        var result = 0
        for (_, subCriterias) in data.data {
            result+=2 //+2 to account for the subfooter and subheader
            for _ in subCriterias {
                result+=1
            }
        }
        return result
   }
    
    
}

