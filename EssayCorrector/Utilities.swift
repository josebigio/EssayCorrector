//
//  Utilities.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/1/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import PySwiftyRegex

class Utilities {
    static func fixPath(path: String) -> String?{
        let pattern = "/([^/]*)/(Documents)";
        if let m = re.search(pattern, path) {
            let incorrectID = m.group(1)
            print("inccorectID:" + incorrectID!)
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
            if let m2 = re.search(pattern, documentsPath) {
                let correctID = m2.group(1)
                print("correctID:" + correctID!)
                return path.stringByReplacingOccurrencesOfString(incorrectID!, withString: correctID!)
            }
        }
        return nil
    }
}

