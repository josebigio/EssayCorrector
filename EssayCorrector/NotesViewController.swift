//
//  NotesViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/8/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import UIKit

class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddSubCriteriaFooterCellDelegate,SubCriteriaTableViewCellDelegate, SavedFormatViewControllerDelegate{

    @IBOutlet weak var formTableView: UITableView!
    let DEFAULT_MAX_SCORE = 5
    
    enum VIEW_TYPES {
        case Normal
        case Header
        case Footer
    }
    
    static var PREVIEW_KEY = "Notes"
    var data = ScoreData()
    var footerCell:AddTableViewCell?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self): viewDidLoad()")
        
        formTableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        
        footerCell = formTableView.dequeueReusableCellWithIdentifier("addCriteriaCell") as? AddTableViewCell
        footerCell!.addButton.addTarget(self, action: #selector(NotesViewController.addCriteria(_:)), forControlEvents: .TouchUpInside)
        formTableView.tableFooterView = footerCell!.contentView
        let loadButton = self.navigationItem.rightBarButtonItems![1]
        loadButton.action = #selector(NotesViewController.showStoredFormatVC)
        loadButton.target = self
       
        let saveButton = self.navigationItem.rightBarButtonItems![0]
        saveButton.target = self
        saveButton.action = #selector(NotesViewController.saveData)
        pushPreview()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        recalculateScore()
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
        for(criteria,subCriterias) in data.getData() {
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
        for(_,subcriteria)in data.getData() {
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
            var tempData = data.getData()
            for(criteria,subCriterias) in tempData {
                if(count == indexPath.row) {
                    var rowToDeleteCount = 1
                    var indexPaths = [NSIndexPath]()
                    indexPaths.append(indexPath)
                    for _ in tempData[criteria]! {
                        indexPaths.append(NSIndexPath(forRow: rowToDeleteCount + indexPath.row, inSection: indexPath.section))
                        rowToDeleteCount+=1
                    }
                    indexPaths.append(NSIndexPath(forRow: rowToDeleteCount + indexPath.row, inSection: indexPath.section)) //for the addCell
                    tempData.removeValueForKey(criteria)
                    data.setData(tempData)
                    tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
                    recalculateScore()
                    pushPreview()
                    return
                }
                count+=1
                for _ in subCriterias {
                    var subCriteriaNum = 0
                    if(count == indexPath.row) {
                        //it is a SubCriteriaTableViewCell
                        var subCriterias = tempData[criteria]
                        subCriterias?.removeAtIndex(subCriteriaNum)
                        tempData[criteria] = subCriterias
                        data.setData(tempData)
                        tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                        recalculateScore()
                        pushPreview()
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
        var tempData = data.getData()
        for (criteria,subCriterias) in tempData {
            var index = 0
            for subCriteria in subCriterias {
                if(subCriteria.0.containsString(cell.subCriteria.text!)) {
                    var newSubCriterias = subCriterias
                    var newCriteria = subCriteria
                    newCriteria.1.0 = cell.score.getScore()
                    newSubCriterias[index] = newCriteria
                    tempData[criteria] = newSubCriterias
                    data.setData(tempData)
                    pushPreview()
                    recalculateScore()
                    return
                }
                index+=1
            }
        }
    }
    
    //MARK SavedFormatViewControllerDelegate
    func onFormatSelected(format: ScoreData) {
        data = format
        formTableView.reloadData()
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
                var tempData = self.data.getData()
                var subCriterias = tempData[criteria!]
                subCriterias?.append((name,(0,score!)))
                tempData[criteria!] = subCriterias
                self.updateModel(tempData)
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in
            tf.keyboardType = .NumberPad}
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    // MARK private helpers
    private func updateModel(newData: [String:[(String,(Int,Int))]]) {
        self.data.setData(newData)
        self.formTableView.reloadData()
        self.recalculateScore()
        pushPreview()
    }
    
    func addSubCriteria(section: Int, subCriteria: String, maxScore:Int) {
        var tempData = data.getData()
        var keys = [String](tempData.keys)
        var subCriterias = tempData[keys[section]]
        subCriterias?.append((subCriteria,(0,maxScore)))
        tempData[keys[section]] = subCriterias
        data.setData(tempData)
        pushPreview()
        formTableView.reloadData()
    }
    
    func addCriteria(button: UIButton) {
        let alertController = UIAlertController(title: "Add a criteria", message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                var tempData = self.data.getData()
                tempData[alertController.textFields!.first!.text!] = []
                self.data.setData(tempData)
                self.pushPreview()
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
        for (_, subCriterias) in data.getData() {
            result+=2 //+2 to account for the subfooter and subheader
            for _ in subCriterias {
                result+=1
            }
        }
        return result
   }
    
    func showStoredFormatVC() {
        print("showStoredFormatVC")
        let sfvc = self.storyboard?.instantiateViewControllerWithIdentifier("SavedFormatViewController") as! SavedFormatViewController
        sfvc.delegate = self
        navigationController?.pushViewController(sfvc, animated: true)
    }
    
    func saveData() {
        let alertController = UIAlertController(title: "Save Format", message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Save", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                self.data.setFileName(alertController.textFields!.first!.text!)
                FormLoader.save(self.data)
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        presentViewController(alertController, animated: true, completion: nil)

    }
    
    //MARK pdf generation
    private func pushPreview() {
        let eCTabBarVC = tabBarController as! ECTabBarController
        eCTabBarVC.pushHtml(generateHtml(), key: NotesViewController.PREVIEW_KEY)
    }
    
    private func generateHtml() -> String {
        let total = data.getTotal()
        var htmlResult = "<html><head><style>table, th, td {    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 5px;    text-align: center;    }</style></head><body><h2>Calificacion</h2><table style=\"width:100%\">  <tr>    <th>Indicador</th>    <th>Criterio</th>    <th>Puntaje</th>  </tr>"
        for(criteria,subCriteriaList) in data.getData() {
            htmlResult = htmlResult + generateSection((criteria,subCriteriaList))
        }
        htmlResult = htmlResult + "<tr><th colspan=\"2\">Total</th><td>\(total.0)/\(total.1)</td></tr>"
        htmlResult = htmlResult + "</table></body></html>"
        return htmlResult
    }
    
    private func generateSection(section: (String,[(String,(Int,Int))])) -> String {
        var htmlResult = ""
        var isFirst = true
        let criteria = section.0
        let subCriteriaList = section.1
        let rowSpan = subCriteriaList.count
        for (subCriteria,scoreTuple) in subCriteriaList {
            htmlResult = htmlResult + "<tr>"
            if(isFirst) {
                isFirst = false
                htmlResult = htmlResult + "<th rowspan=\"\(rowSpan)\">\(criteria)</th>"
            }
            htmlResult = htmlResult + "<td>\(subCriteria)</td>"
            htmlResult = htmlResult + "<td>\(scoreTuple.0)/\(scoreTuple.1)</td>"
            htmlResult = htmlResult + "</tr>"
        }
        return htmlResult
    }
    
    
}

