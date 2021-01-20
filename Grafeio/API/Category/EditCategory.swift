//
//  EditCategory.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class EditCategory: ObservableObject {
    
    var didChange = PassthroughSubject<EditCategory, Never>()

    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isSuccess : Bool = false

    @Published var isFinish : Bool = false
    
    @Published var isEditClick : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var catid : String = ""
    
    
    func editCategory(catname : String , catdesc : String){
        
       
        
        let parameters: [String: Any] = ["category_name" : catname,
                                         "category_description" : catdesc
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/CATEGORY/" + catid , method: .put, parameters: parameters)
        
        
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
                        DispatchQueue.main.async {
                            self.isSuccess = false
                            self.isFinish = true
                            print(error)
                            print("error")
                        }
                        
                    }
                }.resume()
            }
    }
    
    func initCondition(){
        self.isSuccess = false
        self.isFinish = false
    }
    
}
