//
//  libro.swift
//  BibliotecaLibrePersistente
//
//  Created by Gabriel Urso Santana Reyes on 23/12/15.
//  Copyright © 2015 Gabriel Urso Santana Reyes. All rights reserved.
//

import Foundation
import UIKit
import CoreData


enum LibroError: ErrorType {
    case FormatDataError
    case ErrorDeConexion
    case ISBNNoEncontrado
}


struct Libro{
    var isbn : String
    var titulo : String
    var autores : [String]
    var portada : UIImage?
    
    init(isbn : String) throws{
        self.isbn = isbn
        do{
            let destino = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:" + isbn
            let url = NSURL(string : destino )
            let datos : NSData? = NSData(contentsOfURL: url!)
            
            if datos == nil{
                throw LibroError.ErrorDeConexion
            }
            let dat = NSString(data: datos!, encoding: NSUTF8StringEncoding)
            if dat! as String == "{}"{
                throw LibroError.ISBNNoEncontrado
            }
            
            let json  = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            var jlibro = json as! NSDictionary
            jlibro = jlibro["ISBN:"+isbn] as! NSDictionary
            self.autores = []
            for i in jlibro["authors"] as! NSArray{
                self.autores.append(i["name"] as! String)
            }
            self.titulo = jlibro["title"] as! String
            if jlibro["cover"] == nil{
                self.portada = nil
                print("sin portada")
            }else{
                print(jlibro["cover"])
                let cover = jlibro["cover"]
                if cover is NSDictionary{
                    let co = cover!["small"] as! String
                    print (co)
                    let urlImagen:NSURL? = NSURL(string: co)
                    let dataImagen:NSData? = NSData(contentsOfURL : urlImagen!)
                    if dataImagen == nil{
                        self.portada = nil
                    }else{
                        self.portada = UIImage(data : dataImagen!)
                    }
                }
            }
        }catch _{
            throw LibroError.FormatDataError
        }
    }
    
    init(isbn: String, titulo : String, autores : [String], portada : UIImage?){
        self.isbn = isbn
        self.titulo = titulo
        self.autores = autores
        self.portada = portada
    }

}
