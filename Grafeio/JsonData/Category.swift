import Foundation
import SwiftUI

class Category : NSObject, Decodable, Identifiable {
    var id = UUID()
    var Category_ID : String
    var Category_Name : String
    var Category_Description : String
    
    init(json: [String:Any]) {
        self.Category_ID = json["CATEGORY_ID"] as? String ?? ""
        self.Category_Name = json["CATEGORY_NAME"] as? String ?? ""
        self.Category_Description = json["CATEGORY_DESCRIPTION"] as? String ?? ""
        }
}

