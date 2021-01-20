import Foundation
import SwiftUI

class City : NSObject, Decodable {
    var City_ID : String
    var City_Initial : String
    var City_Name : String
    var Province_ID : String
    var Province_Initial : String
    var Province_Name : String
    
    init(json: [String:Any]) {
        self.City_ID = json["CITY_ID"] as? String ?? ""
        self.City_Initial = json["CITY_INITIAL"] as? String ?? ""
        self.City_Name = json["CITY_NAME"] as? String ?? ""
        self.Province_ID = json["PROVINCE_ID"] as? String ?? ""
        self.Province_Initial = json["PROVINCE_INITIAL"] as? String ?? ""
        self.Province_Name = json["PROVINCE_NAME"] as? String ?? ""
        }
}

