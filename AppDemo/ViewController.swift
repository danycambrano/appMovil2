//
//  ViewController.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 05/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,
detalleViewControllerDelegate, AgregarViewControllerDelegate {
    @IBOutlet weak var btnBoton: UIButton!
        @IBOutlet weak var tblTabla: UITableView!
    
    var rootRef = FIRDatabaseReference()
    
    
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var lblNombre: UILabel!
    
    
    @IBAction func btnAgregar_Click(_ sender: Any) {
      performSegue(withIdentifier: "AgregarSegue", sender: self)
    }
    
    var arreglo1 = [("Dany", 20),("Uno", 30),("tres", 40)]
    var datos = [("Dany",30),("Jose",20),("ju",30), ("Dany",30),("Jose",20),("ju",30), ("Dany",30),("Jose",20),("ju",30) ]
    
  //  var arreglo : [(nombre: String, edad: Int, genero: String, foto: String)] = []
    
    var arreglo : [Persona] = [Persona]()
    
    var filaSeleccionada = -1
    var esEdicion = false
    
    @IBAction func btnAgregar(_ sender: Any) {
        let valor = Int(lblNombre.text!)!
        rootRef.child("Numeros").setValue(valor + 1)
    }
    
 
    @IBAction func btnRefres(_ sender: Any) {
      
        let idFacebook = FBSDKAccessToken.current().userID
            let cadenaUrl = "http://graph.facebook.com/\(idFacebook!)/picture?type=large"
            
            
                
                           imgFoto.loadPicture(url: cadenaUrl)
        
     /*let idFacebook = FBSDKAccessToken.current().userID
   // let cadenaUrl = "http://graph.facebook.com/\(idFacebook!)/picture?type=large"
        
        do
        {
       //     dato = try Data(contentsOf: url!)
            imgFoto.downloadData(url: "https://graph.facebook.com/\(idFacebook)/picture?type=large")
        
        
        }
        catch{
            print("Error cargando la imagen.\(error.localizedDescription)")
            imgFoto.image = UIImage(named: "gato")
        }*/
        
       // imgFoto.loadPicture(url: cadenaUrl)
        
        sincronizarData()
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
     
        
        rootRef = FIRDatabase.database().reference()
        
        arreglo = Persona.selectTodos()
        tblTabla.reloadData()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.rootRef.child("Numeros").observe(.value, with: {(snap: FIRDataSnapshot) in self.lblNombre.text = "\(snap.value!)"
        })
        
       
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
        //view.dato = arreglo[filaSeleccionada].nombre
        //view.datoNumero = arreglo[filaSeleccionada].edad
     
     view.dato = arreglo[filaSeleccionada].nombre!
     view.datoNumero = Int(arreglo[filaSeleccionada].edad)
        
        view.delegado = self
            break
            
            case "AgregarSegue":
            let view = segue.destination as! AgregarViewController
            if (esEdicion)
            {
                view.fila = filaSeleccionada
          //      view.Nombre = arreglo[filaSeleccionada].nombre
            //    view.Edad = arreglo[filaSeleccionada].edad
                
                view.Nombre = arreglo[filaSeleccionada].nombre!
                view.Edad = Int(arreglo[filaSeleccionada].edad)
                
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
    
    func sincronizarData(){
        let url = (string: "http://kke.mx/demo/contactos2.php")
        
        var request = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 1000)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in guard (error == nil) else {
            print("Ocurrio un error con la peticion: \(error)")
            return
            }
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                print("Ocurrio un error con la respuesta.")
                return
            }
            if (!(statusCode >= 200 && statusCode <= 299))
            {
                print("Respuesta no válida")
                return
            }
            let cad = String (data: data!, encoding: .utf8)
            print("Response: \(response!.description)")
            print("error: \(error)")
            print("data: \(cad!)")
            
            var parsedResult: Any!
            do{
                parsedResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            }
            catch{
                parsedResult = nil
                print("Error: \(error)")
                return
            }
            guard let datos = (parsedResult as? Dictionary<String, Any?>)?["datos"] as! [Dictionary<String, Any>]! else {
                print("Error: \(error)")
                return
            }
            self.arreglo.removeAll()
            
            let (agregados, modificados, errores) = Persona.agregarTodos(datos: datos)
            
            print("se agregaron \(agregados) registros; modificaron \(modificados); \(errores) registros de error")
            
          /*  for d in datos{
                let nombre = (d["nombre"] as! String)
                let edad = (d["edad"] as! Int)
                let foto = d["foto"] as! String
                let genero = d["genero"] as! String
                
                self.arreglo.append((nombre: nombre, edad: edad, genero: genero, foto: foto))
            }*/
            self.arreglo = Persona.selectTodos()
            print("se leyeron \(self.arreglo.count) registros")
            
            self.tblTabla.reloadData()
          
            })
        task.resume()
        
    }




// MARK: -TableDelegate

 func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int

 {
    return arreglo.count
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
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(self.arreglo[indexPath.row])
        self.arreglo.remove(at: indexPath.row)
        
        self.tblTabla.deleteRows(at: [indexPath], with: .fade)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
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
    let view = tableView.dequeueReusableCell(withIdentifier: "proto1") as! filaTableViewCell
    
    
    
    //let proto = (indexPath.row % 2 == 0) ? "proto1": "proto2"
    
    let dato = arreglo[indexPath.row]
    dato.edad = Int16(indexPath.row)
    
    //(UIApplication)
 
    
    //let vista = tableView.dequeueReusableCell(withIdentifier: "proto1", for: indexPath) as! filaTableViewCell
    
    view.lblIzquierda.text = "\(dato.nombre!)"
    view.lblDerecha.text = "\(dato.edad)"
    
    let idFacebook = FBSDKAccessToken.current().userID
    let cadenaURL = "http://graph.facebook.com/\(idFacebook!)/picture?type=large"
    
   // let url = URL(string: cadenaURL)
    // let dato: Data?
    
    if dato.genero == "m"
    {
        view.imgFoto.image = UIImage(named: "user_female")
    }
    else {
        view.imgFoto.image = UIImage(named: "user_male")
    }
    view.imgFoto.downloadData(url: dato.foto!)
    
    /*do {
        dato = try Data(contentsOf: url!)
        vista.imgFoto.image = UIImage(data: dato!)
        
    }
    catch{
        print("Error cargando la imagen.! \(error.localizedDescription)")
        dato = nil
        imgFoto.image = UIImage(named: "gato")
    }*/
   

    
    
    
    return view
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
