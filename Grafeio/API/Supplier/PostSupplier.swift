//
//  PostSupplier.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class PostSupplier: ObservableObject {
    
    var didChange = PassthroughSubject<PostSupplier, Never>()

    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isFinish : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var isSuccess : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    
    func postSupplier(fname : String ,
                      lname : String,
                      city_id : String,
                      owner : String,
                      pnumber : String,
                      address : String,
                      emp_id : String){
        
       
        
        let parameters: [String: Any] = ["fname_supplier" : fname,
                                         "lname_supplier" : lname,
                                         "city_id" : city_id,
                                         "owner" : owner,
                                         "pnumber_supplier" : pnumber,
                                         "address_supplier" : address,
                                         "employee_id" : emp_id
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/Supplier" , method: .post, parameters: parameters)
        
            if let request = request as? DataRequest {
                request.responseString { response in
                    do{
                        let data = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                        let Err = data["Error"] as! Bool
                        
                        print(data)
                        
                        if Err {
                            self.isSuccess = false
                            self.isFinish = true
                            print("gagal")
                            
                        }else{
                            self.isSuccess = true
                            self.isFinish = true
                            print("sukses")
                        }
                        
                    }catch{
                        self.isSuccess = false
                        self.isFinish = true
                        print(error)
                        print("error")
                        
                    }
                }.resume()
            }
    }
    
    func initCondition(){
        self.isSuccess = false
        self.isFinish = false
    }
    
}
