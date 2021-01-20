//
//  UserAuth.swift
//  Grafeio
//
//  Created by Ryan Octavius on 24/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class UserAuth: ObservableObject {
    
    var didChange = PassthroughSubject<UserAuth, Never>()
    var willChange = PassthroughSubject<Employee, Never>()
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var EmployeeID : String = ""{
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var isCorrect : Bool = true
    @Published var isConnected : Bool = true
    @Published var isLoading : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var isLoggedin : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var showDetail : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var Emp : Employee? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var tempProduct : Product? = nil {
        didSet {
            didChange.send(self)
        }
    }
    
    func cekLogin(password: String, employee_id: String){
        
        self.isLoading = true
        
        let parameters: [String: Any] = ["password" : password,
                                         "employee_id" : employee_id]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/USERLOG", method: .post, parameters: parameters)
        
            if let request = request as? DataRequest {
                request.responseString { response in
                    do{
                        let data = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                        let Err = data["Error"] as! Bool
                        
                        print(data)
                        
                        if Err {
                            self.isCorrect = false
                            self.isLoading = false
                            
                        }else{
                            self.EmployeeID = employee_id
                            self.getUserInfo(empID : employee_id)
                            self.isLoggedin = true
                            self.isCorrect = true
                            self.isLoading = false
                        }
                        
                    }catch{
                        print(error)
                        self.isCorrect = false
                        self.isLoading = false
                        
                    }
                }.resume()
            }
    }
    
    func getUserInfo(empID: String){
        self.isLoading = true
        let url = URL(string: "http://localhost/PPTA/index.php/EMPLOYEE/" + empID)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let EmpData = jsonObject["Data"] as? [AnyObject]
                        for obj in EmpData! {
                            let e = Employee(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Emp = e
                                self.isLoading = false
                            }
                                
                            
                        }
                    }
                    catch{
                        print("catch error")
                    }
                }
            }
        }.resume()
    }
}
