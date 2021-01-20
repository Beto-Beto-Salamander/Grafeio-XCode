//
//  EditCity.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class EditCity: ObservableObject {
    
    var didChange = PassthroughSubject<EditCity, Never>()

    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isFinish : Bool = false 
    
    @Published var isSuccess : Bool = false
    
    @Published var City_ID : String = ""
    
    
    func editCity(provid : String , cname : String , cinitial : String){
        
       
        
        let parameters: [String: Any] = ["province_id" : provid,
                                         "city_initial" : cinitial,
                                         "city_name" : cname
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/CITY/" + City_ID , method: .put, parameters: parameters)
        
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
