//
//  EditProvince.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class EditProvince: ObservableObject {
    
    var didChange = PassthroughSubject<EditProvince, Never>()

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
    
    @Published var Province_ID : String = ""
    
    
    func editProvince(pname : String , pinitial : String){
        
       
        
        let parameters: [String: Any] = [
                                         "province_initial" : pinitial,
                                         "province_name" : pname
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/PROVINCE/" + Province_ID , method: .put, parameters: parameters)
        
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
