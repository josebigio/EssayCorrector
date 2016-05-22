//
//  ScoreData.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/22/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation

class ScoreData {
    
    var data :[String:[(String,(Int,Int))]] = ["Puntualidad":[("Entregado antes de la hora final",(0,5)),("Entregado antes de la mañana siguiente",(0,5)),("Entregado antes del fin de semana siguiente",(0,5))],"Redaccion":[("Ortografia, sintaxis y lexico correctos",(0,5)),("Desarrollo de un estilo propio",(0,5)),("Coherencia",(0,4)),("Cohesion",(0,8))],"Manejo":[("Identificacion del 100% de ellos",(0,5)),("Profundidad en el conocimiento/definiciones exaustivas",(0,5)),("Articulacion apropiada",(0,5))]]

    
    internal init() {
      
    }
    
    func getTotal() -> (Int,Int){
        var total = 0
        var max = 0
        for(_,subCriterias) in data {
            for(_,score) in subCriterias {
                total+=score.0
                max+=score.1
            }
        }
        return (total,max)
    }
}