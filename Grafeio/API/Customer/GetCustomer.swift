//
//  GetCustomer.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetCustomer: ObservableObject {
    
    var didChange = PassthroughSubject<GetCustomer, Never>()
    var willChange = PassthroughSubject<Customer, Never>()
    
    @Published var idCust : String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
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
    
    @Published var tempCustomer : Customer? = nil {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var Customers = [Customer]()
    
    func getCustomer(customer_id : String) {
        self.Customers.removeAll()
        if customer_id != "" {
            idCust = "/" + customer_id
        }
        self.idCust = customer_id
        
        let url = URL(string: "http://localhost/PPTA/index.php/CUSTOMER" + idCust)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let CustData = jsonObject["Data"] as? [AnyObject]
                        for obj in CustData! {
                            let Cat = Customer(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Customers.append(Cat)
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
        self.Customers.removeAll()
    }
}
