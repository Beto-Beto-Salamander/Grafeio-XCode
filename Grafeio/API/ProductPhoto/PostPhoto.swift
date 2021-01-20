//
//  PostPhoto.swift
//  Grafeio
//
//  Created by Ryan Octavius on 08/12/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class PostPhoto: ObservableObject {
    
    var didChange = PassthroughSubject<PostPhoto, Never>()

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
    
    
    func postPhoto(img : UIImage, idp : String){
        
        let imageData = img.jpegData(compressionQuality: 0.1)
        let param: [String:Any] = ["product_id" : idp]
        Alamofire.upload(multipartFormData:
            {
                (multipartFormData) in
                multipartFormData.append(imageData!, withName: "photo", fileName: "file.jpeg", mimeType: "image/jpeg")
                for (key, value) in param
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
        }, to:"http://localhost/PPTA/index.php/PRODUCTPHOTO",headers:nil)
        { (result) in
            switch result {
            case .success(let upload,_,_ ):
                upload.uploadProgress(closure: { (progress) in
                    //Print progress
                })
                upload.responseJSON
                    { response in
                        //print response.result
                        if response.result.value != nil
                        {
                            let dict :NSDictionary = response.result.value! as! NSDictionary
                            let status = dict.value(forKey: "Message")as! String
                            if status=="Berhasil"
                            {
                              print("DATA UPLOAD SUCCESSFULLY")
                            }
                        }
                }
            case .failure(let encodingError):
                break
            }
        }
    }
    
    func initCondition(){
        self.isSuccess = false
        self.isFinish = false
    }
    
}
