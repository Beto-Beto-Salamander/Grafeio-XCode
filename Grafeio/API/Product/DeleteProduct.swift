//
//  DeleteProduct.swift
//  Grafeio
//
//  Created by Ryan Octavius on 29/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class DeleteProduct: ObservableObject {
    
    var didChange = PassthroughSubject<DeleteProduct, Never>()
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isSuccess : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var isFinish : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var Product_ID : String = ""
    
    
    func deleteProduct(product_id : String){
        self.request = Alamofire.request("http://localhost/PPTA/index.php/PRODUCT/" + product_id , method: .delete, parameters: nil)
        
            if let request = request as? DataRequest {
                request.responseString { response in
                    do{
                        let data = try JSONSerialization.jsonObject(with: response.data!, options: .allowFragments) as! [String: Any]
                        let Err = data["Error"] as! Bool
                        
                        print(data)
                        
                        if Err {
                            
                            print(Err)
                            self.isSuccess = false
                            
                            print("ini gagal")

                            
                        }else{
                            print(Err)
                                self.isSuccess = true
                                
                                print("ini berhasil")
                            
                        }
                        
                    }catch{
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
