//
//  EditEmployee.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class EditEmployee: ObservableObject {
    
    var didChange = PassthroughSubject<EditEmployee, Never>()

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
    
    @Published var empid : String = ""
    
    
    func editEmployee(fname : String ,
                      lname : String,
                      city_id : String,
                      bdate : String,
                      pnumber : String,
                      address : String,
                      role : String,
                      salary : String,
                      hire_date : String){
        
       
        
        let parameters: [String: Any] = ["fname_Employee" : fname,
                                         "lname_Employee" : lname,
                                         "city_id" : city_id,
                                         "bdate_Employee" : bdate,
                                         "pnumber_Employee" : pnumber,
                                         "address_Employee" : address,
                                         "role" : role,
                                         "salary" : salary,
                                         "hire_date" : hire_date
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/EMPLOYEE/" + empid , method: .put, parameters: parameters)
        
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
