//
//  PostCategory.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class PostCategory: ObservableObject {
    
    var didChange = PassthroughSubject<PostCategory, Never>()

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
    
    @Published var Product_ID : String = ""
    
    
    func postCategory(catname : String , catdesc : String){
        
       
        
        let parameters: [String: Any] = ["category_name" : catname,
                                         "category_description" : catdesc
                                        ]
        
        self.request = Alamofire.request("http://localhost/PPTA/index.php/CATEGORY" , method: .post, parameters: parameters)
        
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
