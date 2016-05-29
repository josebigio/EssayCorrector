
//
//  CommentsViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/27/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import CXAlertView
import UIKit


class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let DEFAULT_CELL_HEIGHT:CGFloat = 100
    let DEFAULT_LABEL_FONT_SIZE:CGFloat = 15
    
    var dataSource = CommentData()
    
    static var PREVIEW_KEY = "COMMENTS"


    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self): viewDidLoad()")
        dataSource = CommentSaver.getSavedComment()!
        pushPreview()
        tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = DEFAULT_CELL_HEIGHT
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //MARK: Table view dataSource and delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.getData().count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row<dataSource.getData().count) {
            let cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as! CommentCell
            cell.label.text = dataSource.getData()[indexPath.row].0
            cell.switchButton.tag = indexPath.row
            cell.switchButton.setOn(dataSource.getData()[indexPath.row].1, animated: true)
            cell.switchButton.addTarget(self, action: #selector(CommentsViewController.onClickedSwitch(_:)), forControlEvents: .TouchUpInside)
            cell.selectionStyle = .None
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("addCommentCell") as! AddCommentCell
            cell.addCommentButton.addTarget(self, action: #selector(CommentsViewController.addComment(_:)), forControlEvents: .TouchUpInside)
            cell.selectionStyle = .None
            return cell
        }

    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        if(indexPath.row<dataSource.getData().count) {
            return true
        }
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            var tempData = dataSource.getData()
            tempData.removeAtIndex(indexPath.row)
            dataSource.setData(tempData)
            saveState()
            pushPreview()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    

    
    //MARK helpers
    func addComment(button:UIButton) {
        let alertController = UIAlertController(title: "Add Comment", message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                var tempData = self.dataSource.getData()
                tempData.append((alertController.textFields!.first!.text!,true))
                self.dataSource.setData(tempData)
                self.saveState()
                self.tableView.reloadData()
                self.pushPreview()
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func onClickedSwitch(switchButton:UISwitch) {
        var tempData = self.dataSource.getData()
        tempData[switchButton.tag].1 = switchButton.on
        self.dataSource.setData(tempData)
        saveState()
        pushPreview()
    }
    
    func saveState() {
        CommentSaver.save(dataSource)
    }
    
    //MARK pdf generation
    private func pushPreview() {
        let eCTabBarVC = tabBarController as! ECTabBarController
        eCTabBarVC.pushHtml(generateHtml(), key: CommentsViewController.PREVIEW_KEY)
    }
    
    private func generateHtml() -> String {
        var htmlResult = "<html><head><style>table{    border: 1px solid black;    border-collapse: collapse;}th, td {    padding: 5px;    text-align: left;    }</style></head><body><h2>Comentarios</h2><table style=\"width:100%\">"
        for(comment,activated) in dataSource.getData() {
            if(activated) {
                htmlResult = htmlResult + generateSection(comment)
            }
        }
        htmlResult = htmlResult + "</table></body></html>"
        return htmlResult
    }
    
    private func generateSection(section: String) -> String {
        return "<tr><td>\(section)</td></tr>"
    }
    

    

}
