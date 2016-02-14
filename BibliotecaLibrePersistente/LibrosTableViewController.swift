//
//  LibrosTableViewController.swift
//  BibliotecaLibrePersistente
//
//  Created by Gabriel Urso Santana Reyes on 23/12/15.
//  Copyright © 2015 Gabriel Urso Santana Reyes. All rights reserved.
//

import UIKit
import CoreData

class LibrosTableViewController: UITableViewController {
    
    var libros = Array<Libro>()
    var contexto : NSManagedObjectContext? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Busquedas en OpenLibrary"
        
        self.contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let LibroEntidad = NSEntityDescription.entityForName("LibroP", inManagedObjectContext: self.contexto!)
        let peticion = LibroEntidad?.managedObjectModel.fetchRequestFromTemplateWithName("obtener", substitutionVariables: ["isbn":""])
        do{
            let libroObtener = try self.contexto?.executeFetchRequest(peticion!)
            if (libroObtener?.count>0){
                for li in libroObtener!{
                    var portada1 : UIImage? = nil
                    if li.valueForKey("portada") != nil{
                        portada1 = UIImage(data : li.valueForKey("portada") as! NSData)
                    }
                    
                    let libroBD = Libro(isbn: li.valueForKey("isbn") as! String, titulo: li.valueForKey("titulo") as! String, autores: [li.valueForKey("autores") as! String], portada: portada1)
                    libros.append(libroBD)
                }
            }
        }
        catch{
            
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return libros.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Celda", forIndexPath: indexPath)
        cell.textLabel?.text  = libros[indexPath.row].titulo

        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destino = segue.destinationViewController
        
        // Miramos el destino: detalle del libro
        if destino is BuscarViewController {
            let buscar = segue.destinationViewController as! BuscarViewController
            buscar.tablaBuscados = self
        }
        if destino is InfoLibroViewController {
            let infoLibro = segue.destinationViewController as! InfoLibroViewController
            let ip = self.tableView.indexPathForSelectedRow
            infoLibro.libro = libros[ip!.row]
        }
    }

}
