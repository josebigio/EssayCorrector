//
//  SavedFormatsViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/24/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

protocol SavedFormatViewControllerDelegate {
    func onFormatSelected(format:ScoreData)
}

import Foundation
class SavedFormatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var storedFormatsTV: UITableView!
    var forms:[ScoreData]?
    var delegate:SavedFormatViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storedFormatsTV.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        storedFormatsTV.delegate = self
        storedFormatsTV.dataSource = self
        forms = FormLoader.getAllForms()
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (forms?.count)!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if((delegate) != nil) {
            delegate?.onFormatSelected(forms![indexPath.row])
        }
        navigationController?.popViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let scoreData = forms![indexPath.row]
        let cell = storedFormatsTV.dequeueReusableCellWithIdentifier("storedFormatCell") as! StoredFormatCell
        cell.label.text = scoreData.getfileName()
        return cell
    }
    
    

}
