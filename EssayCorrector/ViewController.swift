//
//  ViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 4/18/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import UIKit
import RxSwift
import PSPDFKit
import FileBrowser
import PySwiftyRegex


class ViewController: UIViewController, PSPDFDocumentDelegate, FileChangerDelegate {
    
    
    
    @IBOutlet weak var pdfView: UIView!
    var fileName = ""
    var pdfController:PSPDFViewController? = nil
    var document:PSPDFDocument? = nil
    
    static let LAST_FILE_KEY = "LAST_FILE_KEY"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self): viewDidLoad()")
        AppDelegate.changerDelegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        print("viewDidAppear")
        initialize()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onFileChanged(sender: AppDelegate) {
        initialize()
    }
    
    func initialize() {
        if let lastFile = NSUserDefaults.standardUserDefaults().stringForKey(ViewController.LAST_FILE_KEY) {
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            print("utilities:" + Utilities.fixPath(lastFile)!)
            print("lastFile: " + lastFile)
            print("Documents dir: " + documentsPath)
            let correctedPath = Utilities.fixPath(lastFile)
            document = PSPDFDocument(URL: NSURL(fileURLWithPath: correctedPath!))
            if(pdfController == nil) {
                setUpPDFVC(document!)
            }
            else {
                pdfController?.document = document
            }
        }
        else { //FTUE
            let selectFileButton = UIBarButtonItem(
                title: "Select file",
                style: .Plain,
                target: self,
                action: #selector(ViewController.openFiles)
            )
            self.navigationItem.leftBarButtonItems = [selectFileButton]
        }
    }
    
    func setUpPDFVC(doc:PSPDFDocument) {
        let configuration = PSPDFConfiguration { builder in
            builder.thumbnailBarMode = .Scrollable;
            builder.useParentNavigationBar = true
        }
        pdfController = PSPDFViewController(document: self.document, configuration: configuration)
        if let pdfController = pdfController  {
            pdfController.view.frame = pdfView.bounds;
            addChildViewController(pdfController)
            pdfView.addSubview(pdfController.view)
            pdfController.view.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            pdfController.didMoveToParentViewController(self)
            let selectFileButton = UIBarButtonItem(
                title: "Select file",
                style: .Plain,
                target: self,
                action: #selector(ViewController.openFiles)
            )
            let saveButton = UIBarButtonItem(
                title: "Save",
                style: .Plain,
                target: self,
                action: #selector(ViewController.savePDF)
            )
            self.navigationItem.leftBarButtonItems = [selectFileButton,saveButton]
        }

    }
    
    func openFiles() {
        print("openFiles()")
        let fileBrowser = FileBrowser()
        presentViewController(fileBrowser, animated: true, completion: nil)
        fileBrowser.didSelectFile = { (file: FBFile) -> Void in
           NSUserDefaults.standardUserDefaults().setValue(file.filePath.absoluteString, forKey: ViewController.LAST_FILE_KEY)
        }
    }
    
    func savePDF() {
        do{
            try document?.saveAnnotations()
        }
        catch {
            
        }
    }
    
    
    
}

