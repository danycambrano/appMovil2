//
//  ViewController.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 05/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
detalleViewControllerDelegate, AgregarViewControllerDelegate {
    @IBOutlet weak var btnBoton: UIButton!
        @IBOutlet weak var tblTabla: UITableView!
    
    @IBAction func btnAgregar_Click(_ sender: Any) {
      performSegue(withIdentifier: "AgregarSegue", sender: self)
    }
    
    var arreglo1 = [("Dany", 20),("Uno", 30),("tres", 40)]
    var datos = [("Dany",30),("Jose",20),("ju",30)]
    
    var filaSeleccionada = -1
    var esEdicion = false
 
    
    @IBAction func btnPresionado(_sender:Any){
        print("Boton presionado")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
    
 
    
    let vista = tableView.dequeueReusableCell(withIdentifier: proto, for: indexPath) as! filaTableViewCell
    
    if indexPath.row % 2 == 0 {
        vista.lblIzquierda.text = datos [indexPath.row].0
        vista.lblDerecha.text = String (datos[indexPath.row].1)
    }
    else {
        vista.lblNom.text = datos [indexPath.row].0
      
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
