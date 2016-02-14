//
//  InfoLibroViewController.swift
//  BibliotecaLibrePersistente
//
//  Created by Gabriel Urso Santana Reyes on 23/12/15.
//  Copyright © 2015 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit

class InfoLibroViewController: UIViewController {

    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var autores: UILabel!
    @IBOutlet weak var portada: UIImageView!
    
    var libro:Libro?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titulo.text = libro?.titulo
        var aut = ""
        for i in libro!.autores{
            aut = aut + i + "\n"
        }
        self.autores.text = aut
        self.portada.image = libro?.portada

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }*/
    

}
