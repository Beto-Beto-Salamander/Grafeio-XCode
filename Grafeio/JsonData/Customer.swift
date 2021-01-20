import Foundation
import SwiftUI

class Customer : NSObject, Decodable {
    var Customer_ID : String
    var LName_Customer : String
    var FName_Customer : String
    var City_ID : String
    var City_Initial : String
    var City_Name : String
    var Province_ID : String
    var Province_Initial : String
    var Province_Name : String
    var Address_Customer : String
    var BDate_Customer : String
    var PNumber_Customer : String
    var Create_At_Customer : String
    var Update_At_Customer : String
    var Delete_At_Customer : String
    var Employee_ID : String
    var LName_Employee : String
    var FName_Employee : String
    var Role : String
    
    init(json: [String:Any]) {
        self.Customer_ID = json["CUSTOMER_ID"] as? String ?? ""
        self.LName_Customer = json["FNAME_CUSTOMER"] as? String ?? ""
        self.FName_Customer = json["LNAME_CUSTOMER"] as? String ?? ""
        self.City_ID = json["CITY_ID"] as? String ?? ""
        self.City_Initial = json["CITY_INITIAL"] as? String ?? ""
        self.City_Name = json["CITY_NAME"] as? String ?? ""
        self.Province_ID = json["PROVINCE_ID"] as? String ?? ""
        self.Province_Initial = json["PROVINCE_INITIAL"] as? String ?? ""
        self.Province_Name = json["PROVINCE_NAME"] as? String ?? ""
        self.Address_Customer = json["ADDRESS_CUSTOMER"] as? String ?? ""
        self.BDate_Customer = json["BDATE_CUSTOMER"] as? String ?? ""
        self.PNumber_Customer = json["PNUMBER_CUSTOMER"] as? String ?? ""
        self.Create_At_Customer = json["CREATE_AT_CUSTOMER"] as? String ?? "-"
        self.Update_At_Customer = json["UPDATE_AT_CUSTOMER"] as? String ?? "-"
        self.Delete_At_Customer = json["DELETE_AT_CUSTOMER"] as? String ?? "-"
        self.Employee_ID = json["EMPLOYEE_ID"] as? String ?? ""
        self.LName_Employee = json["FNAME_EMPLOYEE"] as? String ?? ""
        self.FName_Employee = json["LNAME_EMPLOYEE"] as? String ?? ""
        self.Role = json["ROLE"] as? String ?? ""
        }
}

