//
//  NotesViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/8/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
class NotesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    @IBOutlet weak var formTableView: UITableView!
    
    var data :[String:[String]] = ["Puntualidad":["Entregado antes de la hora final","Entregado antes de la mañana siguiente","Entregado antes del fin de semana siguiente"],"Redaccion":["Ortografia, sintaxis y lexico correctos","Desarrollo de un estilo propio","Coherencia","Cohesion"],"Manejo":["Identificacion del 100% de ellos","Profundidad en el conocimiento/definiciones exaustivas","Articulacion apropiada"]]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Notes: viewDidLoad()")
        
        formTableView.registerClass(UITableViewCell.self,forCellReuseIdentifier: "Cell")
        
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return data.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var keys = [String](data.keys)
        return keys[section]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        
        var keys = [String](data.keys)
        let name = keys[section]
        if(section == data.count-1) {
            return data[name]!.count + 1
        }
         return data[name]!.count
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var keys = [String](data.keys)
        let keyName = keys[indexPath.section]
        let keyArray = data[keyName]
        
        if(indexPath.section == data.count-1 && indexPath.row == keyArray!.count) {
            let cell = tableView.dequeueReusableCellWithIdentifier("addCell", forIndexPath: indexPath) as! AddTableViewCell
            cell.addButton.addTarget(self, action: #selector(NotesViewController.addCriteria(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            return cell
        }
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! SubCriteriaTableViewCell
        cell.subCriteria.text = keyArray![indexPath.row]
        return cell
    }
    
    // MARK: UITableViewDelegate
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCellWithIdentifier("headerCell") as! CriteriaTableViewCell
        var keys = [String](data.keys)
        cell.criteria.text = keys[section]
        cell.addSubCriteria.addTarget(self, action: #selector(NotesViewController.addSubCriteria(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.addSubCriteria.tag = section
        return cell
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // MARK private helpers
    func addSubCriteria(button: UIButton) {
        let keys = [String](data.keys)
        let section = button.tag
        let alertController = UIAlertController(title: keys[section], message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                self.addSubCriteria(section, subCriteria: alertController.textFields!.first!.text!)
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func addSubCriteria(section: Int, subCriteria: String) {
        var keys = [String](data.keys)
        var subCriterias = data[keys[section]]
        subCriterias?.append(subCriteria)
        data[keys[section]] = subCriterias
        formTableView.reloadData()
    }
    
    func addCriteria(button: UIButton) {
        let alertController = UIAlertController(title: "Add a criteria", message: "", preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Add", style: .Default, handler: { (action: UIAlertAction) in
            if alertController.textFields!.first!.text!.characters.count > 0 {
                self.data[alertController.textFields!.first!.text!] = []
                self.formTableView.reloadData()
            }
        }))
        alertController.addTextFieldWithConfigurationHandler { (tf:UITextField) in}
        presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    

   
    
    
    
   }


