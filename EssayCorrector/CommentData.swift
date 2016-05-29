//
//  CommentData.swift
//  EssayCorrector
//
//  Created by Jose Bigio on 5/29/16.
//  Copyright © 2016 Jose Bigio. All rights reserved.
//

import Foundation

class CommentData {
    
    private var data:[(String,Bool)]
    
    
    internal init(commentData:[(String,Bool)]) {
        self.data = commentData
    }
    
    internal init() {
        self.data = [("Tu texto no responde a la indicación.",false),
                     ("Tu texto responde sólo a la mitad de la indicación.",false),
                     ("Cada vez que propongas una idea tienes que justificarla (ej. “un día de sol es excelente porque de ese modo se puede aprovechar su energía para generar electricidad” ✓ | “un día de sol es claramente un gran día” ✗).",false),
                     ("Intenta escribir una idea en cada oración.",false),
                     ("Tu redacción es sumamente desordenada. Intenta escribir el texto un día antes, dormir, y al día siguiente ver si lo entiendes; si no lo entiendes, corrige las partes poco claras.",false),
                     ("Tu introducción es efectiva: da un panorama general del tema y luego presenta lo que vas a hacer en el texto.",false),
                     ("Tu introducción no comunica efectivamente un panorama general del tema.",false),
                     ("Tu introducción no presenta efectivamente lo que vas a hacer en tu texto.",false),
                     ("Tu texto es redundante: hay partes que podrías borrar y seguirías transmitiendo el mismo mensaje.",false),
                     ("Tu conclusión no se sigue lógicamente de las ideas principales de tus párrafos anteriores, sino que es una premisa más que has añadido en el último párrafo.",false),
                     ("Tu conclusión no comunica un análisis profundo, podría no estar en el texto y aun así el mensaje sería el mismo.",false),
                     ("Tu redacción es clara y ordenada. ",false),
                     ("La estructura que le das a tu texto hila las ideas adecuadamente y contribuye a dar fuerza a tus argumentos.",false),
                     ("La estructura que le das a tu texto es desordenada y no permite que desarrolles tus argumentos a todo su potencial.",false),
                     ("La estructura que le das a tu texto es demasiado expositiva y no permite que desarrolles a fondo una argumentación de tu propio análisis.",false),
                     ("Revisa la puntuación.",false),
                     ("Revisa la gramática.",false),
                     ("Utilizas palabras polémicas que deben ser problematizadas y no sólo mencionadas.",false),
                     ("Identificas todos los conceptos importantes y los desarrollas a profundidad.",false),
                     ("Identificas todos los conceptos importantes pero los desarrollas superficialmente.",false),
                     ("Parece que te has confundido un poco con las ideas presentadas en los textos. Te recomiendo discutir las lecturas con tus compañeros antes de escribir el trabajo.",false),
                     ("Las ideas que presentas son interesantes pero hace falta que trabajes más tu argumentación.",false),
                     ("Tus ideas están bastante sueltas, no están articuladas entre sí.",false)]
    }
    
    func getData() -> [(String,Bool)] {
        return data
    }
    
    func setData(newData:[(String,Bool)]) {
        data = newData
    }
    
}