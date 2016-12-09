//
//  UIImageView.swift
//  AppDemo
//
//  Created by ADMINISTRADORUTM on 07/12/16.
//  Copyright © 2016 tecrios. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadPicture(url: String)
       {
        if url.characters.count < 7
        {
        return
        }
       do {
        let dato = try Data (contentsOf: URL(string: url)!)
        self.image = UIImage(data: dato)
    
        } catch {
        print ("Error: \(error)")
    }
    }
 
         //self.image = UIImage(data: dato!)
        

    func downloadData(url: String){
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
            print("Response: \(response!.description)")
            print("error: \(error)")
            
            self.image = UIImage.init(data: data!)
        })
        
        task.resume()
    }
}
