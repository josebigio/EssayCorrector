
//
//  CommentsViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/27/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import CXAlertView

class CommentsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    let DEFAULT_CELL_HEIGHT:CGFloat = 100
    let DEFAULT_LABEL_FONT_SIZE:CGFloat = 15
    
    var dataSource = [(String,Bool)]()

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = CommentSaver.getSavedComment()!
        
        tableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = DEFAULT_CELL_HEIGHT
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    //MARK: Table view dataSource and delegates
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if(indexPath.row<dataSource.count) {
            let cell = tableView.dequeueReusableCellWithIdentifier("commentCell") as! CommentCell
            cell.label.text = dataSource[indexPath.row].0
            cell.switchButton.tag = indexPath.row
            cell.switchButton.setOn(dataSource[indexPath.row].1, animated: true)
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
        if(indexPath.row<dataSource.count) {
            return true
        }
        return false
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            dataSource.removeAtIndex(indexPath.row)
            saveState()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    

    
    //MARK helpers
    func addComment(button:UIButton) {
        let alertController = UIAlertController(title: "Add Comment", message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                self.dataSource.append((alertController.textFields!.first!.text!,true))
                self.saveState()
                self.tableView.reloadData()
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        presentViewController(alertController, animated: true, completion: nil)
    }
    
    func onClickedSwitch(switchButton:UISwitch) {
        dataSource[switchButton.tag].1 = switchButton.on
        saveState()
    }
    
    func saveState() {
        CommentSaver.save(dataSource)
    }
    
//    func calculateHeightForString(inString:String) -> CGFloat {
//        var messageString = inString
//        var attributes = [UIFont(): UIFont.systemFontOfSize(DEFAULT_LABEL_FONT_SIZE)]
//        NSAttributedString(string: inString, attributes: <#T##[String : AnyObject]?#>)
//        var attrString:NSAttributedString? = NSAttributedString(string: messageString, attributes: attributes)
//        var rect:CGRect = attrString!.boundingRectWithSize(CGSizeMake(300.0,CGFloat.max), options: NSStringDrawingOptions.UsesLineFragmentOrigin, context:nil )//hear u will get nearer height not the exact value
//        var requredSize:CGRect = rect
//        return requredSize.height  //to include button's in your tableview
//        
//    }
    
  

}
