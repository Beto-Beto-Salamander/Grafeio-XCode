import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetPhoto: ObservableObject {
    
    var didChange = PassthroughSubject<GetPhoto, Never>()
    var willChange = PassthroughSubject<Product, Never>()
    
    @Published var idP : String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isLoading : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var isEmptyArr : Bool = true {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var PPhoto = [ProductPhoto]()
    
    func getPhoto(product_id : String) {
        let url = URL(string: "http://localhost/PPTA/index.php/PRODUCTPHOTO" + product_id)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let ProductData = jsonObject["Data"] as? [AnyObject]
                        for obj in ProductData! {
                            let P = ProductPhoto(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                if P.Photo != "" {
                                    P.Photo = "http://localhost/PPTA/index.php/PRODUCTPHOTO/" + P.Photo
                                }
                                self.PPhoto.append(P)
                                self.isLoading = false
                                self.isEmptyArr = false
                            }
                        }
                    }
                    catch{
                        DispatchQueue.main.async {
                            self.isLoading = false
                            self.isEmptyArr = true
                            print("catch error")
                        }
                    }
                }
            }
        }.resume()
    }
}
