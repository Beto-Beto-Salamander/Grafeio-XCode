import Foundation
import SwiftUI

class Province : NSObject, Decodable {
    var Province_ID : String
    var Province_Initial : String
    var Province_Name : String
    
    init(json: [String:Any]) {
        self.Province_ID = json["PROVINCE_ID"] as? String ?? ""
        self.Province_Initial = json["PROVINCE_INITIAL"] as? String ?? ""
        self.Province_Name = json["PROVINCE_NAME"] as? String ?? ""
        }
}

