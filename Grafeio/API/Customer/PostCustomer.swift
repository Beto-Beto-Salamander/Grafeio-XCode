//
//  PostCustomer.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class PostCustomer: ObservableObject {
    
    var didChange = PassthroughSubject<PostCustomer, Never>()

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
    
    
    func postCustomer(fname : String ,
                      lname : String,
                      city_id : String,
                      bdate : String,
                      pnumber : String,
                      address : String,
                      emp_id : String){
        
       
        
        let parameters: [String: Any] = ["fname_customer" : fname,
                                         "lname_customer" : lname,
                                         "city_id" : city_id,
                                         "bdate_customer" : bdate,
                                         "pnumber_customer" : pnumber,
                                         "address_customer" : address,
                                         "employee_id" : emp_id
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/CUSTOMER" , method: .post, parameters: parameters)
        
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
