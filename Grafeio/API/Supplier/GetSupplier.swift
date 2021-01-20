//
//  GetSupplier.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetSupplier: ObservableObject {
    
    var didChange = PassthroughSubject<GetSupplier, Never>()
    var willChange = PassthroughSubject<Supplier, Never>()
    
    @Published var idSup : String = "" 
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isLoading : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var isEmptyArr : Bool = true {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var showDetail : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var tempSupplier : Supplier? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var Suppliers = [Supplier]()
    
    func getSupplier() {
        let url = URL(string: "http://localhost/PPTA/index.php/SUPPLIER")
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let SuppData = jsonObject["Data"] as? [AnyObject]
                        for obj in SuppData! {
                            let Sup = Supplier(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Suppliers.append(Sup)
                                self.isLoading = false
                                self.isEmptyArr = false
                            }
                        }
                    }
                    catch{
                        self.isLoading = false
                        self.isEmptyArr = true
                        print("catch error")
                    }
                }
            }
        }.resume()
    }
    
    func getSupplier2(supplier_id : String) {
        let url = URL(string: "http://localhost/PPTA/index.php/SUPPLIER/" + supplier_id)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let SuppData = jsonObject["Data"] as? [AnyObject]
                        for obj in SuppData! {
                            let Sup = Supplier(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.tempSupplier = Sup
                                self.isLoading = false
                                self.isEmptyArr = false
                            }
                        }
                    }
                    catch{
                        self.isLoading = false
                        self.isEmptyArr = true
                        print("catch error")
                    }
                }
            }
        }.resume()
    }
    
    func emptyArr(){
        self.Suppliers.removeAll()
    }
}
