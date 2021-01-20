//
//  PostProduct.swift
//  Grafeio
//
//  Created by Ryan Octavius on 28/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class PostProduct: ObservableObject {
    
    var didChange = PassthroughSubject<PostProduct, Never>()

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
    
    @Published var isFinish : Bool = false
    @Published var Product_ID : String = ""
    @Published var errorMessage : String = ""
    
    
    func postProduct(pname : String , catid : String, supid : String, buyp : String, sellp : String, stock
                        : String, mstock : String, pdesc: String, empid : String, img : UIImage){
        
       
        
        let parameters: [String: Any] = ["product_name" : pname,
                                         "category_id" : catid,
                                         "supplier_id" : supid,
                                         "buy_price" : buyp,
                                         "sell_price" : sellp,
                                         "stock" : stock,
                                         "min_stock" : mstock,
                                         "product_description" : pdesc,
                                         "employee_id" : empid
                                        ]
        
        let imageData = img.jpegData(compressionQuality: 0.1)
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(imageData!, withName: "photo", fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key, value) in parameters
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
            }, to:"http://localhost/PPTA/index.php/PRODUCT",method: .post, headers:nil)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                upload.responseJSON
                    { response in
                        //print response.result
                        if response.result.value != nil {
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                            let status = dict.value(forKey: "Error")as! Bool
                            
                            if !status {
                                DispatchQueue.main.async {
                                    self.isSuccess = true
                                }
                                
                              print("DATA UPLOAD SUCCESSFULLY")
                                
                            }else{
                                
                                let msg = dict.value(forKey: "Message")as! NSDictionary
                                let errorMsg = msg.value(forKey: "product_name")as! String
                                
                                if !errorMsg.isEmpty {
                                    
                                    self.errorMessage = "Product's name already exist"
                                    
                                }

                            }
                        }
                }
            case .failure(let encodingError):
                DispatchQueue.main.async {
                    self.isSuccess = true
                }
                print("\(encodingError)")
                break
            }
        }
    }
    
    func initCondition(){
        self.isSuccess = false
        self.isFinish = false
    }
    
}
