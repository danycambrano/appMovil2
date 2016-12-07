//: Playground - noun: a place where people can play

import UIKit
import AFNetworking

var str = "Hello, playground"


extension String {
    func reversa ()-> String
    {
        print ("Reversando")
        return "Hola"
    }
    func IntValue () -> Int
    {
        return Int(self)!
    }
    func validar () -> Bool {
        return self.characters.first == "A"
    }
}
Int ("0")
"0".IntValue()
"B".validar()
"dany".validar()
"Alfred".validar()

extension Int {
    func cuadrado () -> Int {
        return self * self
    }
}

3.cuadrado()


extension UIImageView {
    
    func loadPicture(url: String){
    
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
}

