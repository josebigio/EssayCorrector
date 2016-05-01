//
//  PDFService.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 4/24/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation
import Moya



enum PDFService {
    case CAT
    case DOG
}

extension PDFService: TargetType {
    
    var baseURL: NSURL {return NSURL(string: "http://www.ibiblio.org/ebooks/Poe/Black_Cat.pdf")!}
    var path: ebooks
    

    
}