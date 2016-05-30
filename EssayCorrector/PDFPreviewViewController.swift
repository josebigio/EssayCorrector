//
//  PDFPreviewViewController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/28/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import UIKit


class PDFPreviewViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    let FILE_NAME = "FILE_NAME"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(self): viewDidLoad()")
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("\(self): viewWillAppear()")
        createPDF()
        loadPDF(FILE_NAME)
    }
    
    func createPDF() {
        let eCTabBarController = tabBarController as! ECTabBarController
        var htmls = ""
        for (_,html) in eCTabBarController.getHtmlDict() {
            htmls = htmls + "<br></br>" + html
        }
        let fmt = UIMarkupTextPrintFormatter(markupText: htmls)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAtIndex: 0)
        
        // 3. Assign paperRect and printableRect
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = CGRectInset(page, 0, 0)
        
        render.setValue(NSValue(CGRect: page), forKey: "paperRect")
        render.setValue(NSValue(CGRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, CGRectZero, nil)
        
        for i in 1...render.numberOfPages() {
            
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPageAtIndex(i - 1, inRect: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        pdfData.writeToFile("\(documentsPath)/\(FILE_NAME).pdf", atomically: true)
    }
    
    func loadPDF(filename: String) {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        let filePath = "\(documentsPath)/\(filename).pdf"
        let url = NSURL(fileURLWithPath: filePath)
        let urlRequest = NSURLRequest(URL: url)
        webView.loadRequest(urlRequest)
    }
    

}
