//
//  ECTabBarController.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/28/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import UIKit


class ECTabBarController: UITabBarController {
    
    private var htmlDict = [String:String]()
    
    func getHtmlDict() -> [String:String] {
        return htmlDict
    }
    
    func pushHtml(html: String, key:String) {
        htmlDict[key] = html
    }

}
