//
//  ViewController.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 05/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
detalleViewControllerDelegate, AgregarViewControllerDelegate {
    @IBOutlet weak var btnBoton: UIButton!
        @IBOutlet weak var tblTabla: UITableView!
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBAction func btnAgregar_Click(_ sender: Any) {
      performSegue(withIdentifier: "AgregarSegue", sender: self)
    }
    
    var arreglo1 = [("Dany", 20),("Uno", 30),("tres", 40)]
    var datos = [("Dany",30),("Jose",20),("ju",30), ("Dany",30),("Jose",20),("ju",30), ("Dany",30),("Jose",20),("ju",30) ]
    
    var filaSeleccionada = -1
    var esEdicion = false
 
    @IBAction func btnRefres(_ sender: Any) {
        
        
     let idFacebook = FBSDKAccessToken.current().userID
    let cadenaUrl = "http://graph.facebook.com/\(idFacebook!)/picture?type=large"
        
       
        
        imgFoto.loadPicture(url: cadenaUrl)
        
    }
    
    @IBAction func btnPresionado(_sender:Any){
        print("Boton presionado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Vista cargada")
        imgFoto.image = UIImage(named: "gato")
        lblNombre.text = "Gato con botas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare( for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "Detalle Siguiente":
          
     let view = segue.destination as! detalleViewController
        view.numeroFila = filaSeleccionada
        
        view.numeroFila = filaSeleccionada
        view.dato = datos[filaSeleccionada].0
        view.datoNumero = datos[filaSeleccionada].1
        
        view.delegado = self
            break
            
            case "AgregarSegue":
            let view = segue.destination as! AgregarViewController
            if (esEdicion)
            {
                view.fila = filaSeleccionada
                view.Nombre = datos[filaSeleccionada].0
                view.Edad = datos[filaSeleccionada].1
                esEdicion = false
            }
            
            view.delegado = self
            break
            
        default:
            break
    }
    }
    func numeroCambiado(numero: Int) {
        print("numero cambiado \(numero)")
        datos [numero].1 = datos[numero].1 + 1
        tblTabla.reloadData()
    }
   


// MARK: -TableDelegate

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int

 {
    return datos.count
}

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?{
        let eliminar = UITableViewRowAction(style: .destructive, title: "Borrar", handler: borrarFila)
        let editar = UITableViewRowAction(style: .normal, title: "Editar", handler: editarFila )
        return [eliminar,editar]
        
    }
    
    func borrarFila(sender: UITableViewRowAction, indexPath : IndexPath)
    {
        datos.remove(at: indexPath.row)
        tblTabla.reloadData()
    }
    func editarFila(sender: UITableViewRowAction, indexPath: IndexPath)
    {
        esEdicion = true
        filaSeleccionada = indexPath.row
        performSegue(withIdentifier: "AgregarSegue", sender: sender)
    }
    func modificarRegistro(nombre: String, edad: Int, fila: Int) {
         datos[fila].0 = nombre
        datos[fila].1 = edad
        tblTabla.reloadData()
        
    }
    
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
 {
    let proto = (indexPath.row % 2 == 0) ? "proto1": "proto2"
    
 
    
    let vista = tableView.dequeueReusableCell(withIdentifier: "proto1", for: indexPath) as! filaTableViewCell
    
    let idFacebook = FBSDKAccessToken.current().userID
    let cadenaURL = "http://graph.facebook.com/\(idFacebook!)/picture?type=large"
    
    let url = URL(string: cadenaURL)
    let dato: Data?
    
    do {
        dato = try Data(contentsOf: url!)
        vista.imgFoto.image = UIImage(data: dato!)
        
    }
    catch{
        print("Error cargando la imagen.! \(error.localizedDescription)")
        dato = nil
        imgFoto.image = UIImage(named: "gato")
    }
   

    
    
    
    return vista
}
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        // Detalle siguiente
        filaSeleccionada = indexPath.row
        performSegue(withIdentifier: "Detalle Siguiente", sender: self )
        
    }
    
    func agregarRegistro(nombre: String, edad: Int) {
        datos.append((nombre, edad))
        tblTabla.reloadData()
    }
    
    
}
