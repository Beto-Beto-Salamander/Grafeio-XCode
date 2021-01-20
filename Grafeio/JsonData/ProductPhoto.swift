import Foundation
import SwiftUI

class ProductPhoto : NSObject, Decodable {
    var Photo_ID : String
    var Product_ID : String
    var Product_Name : String
    var Photo : String
    
    init(json: [String:Any]) {
        self.Photo_ID = json["Photo_ID"] as? String ?? ""
        self.Product_ID = json["Product_ID"] as? String ?? ""
        self.Product_Name = json["Product_Name"] as? String ?? ""
        self.Photo = json["Photo"] as? String ?? ""
        }
}

