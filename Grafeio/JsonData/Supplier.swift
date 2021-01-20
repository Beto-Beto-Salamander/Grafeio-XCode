import Foundation
import SwiftUI

class Supplier : NSObject, Decodable {
    var Supplier_ID : String
    var LName_Supplier : String
    var FName_Supplier : String
    var City_ID : String
    var City_Initial : String
    var City_Name : String
    var Province_ID : String
    var Province_Initial : String
    var Province_Name : String
    var Owner : String
    var Address_Supplier : String
    var PNumber_Supplier : String
    var Create_At_Supplier : String
    var Update_At_Supplier : String
    var Delete_At_Supplier : String
    var Employee_ID : String
    var LName_Employee : String
    var FName_Employee : String
    var Role : String
    
    init(json: [String:Any]) {
        self.Supplier_ID = json["SUPPLIER_ID"] as? String ?? ""
        self.LName_Supplier = json["FNAME_SUPPLIER"] as? String ?? ""
        self.FName_Supplier = json["LNAME_SUPPLIER"] as? String ?? ""
        self.City_ID = json["CITY_ID"] as? String ?? ""
        self.City_Initial = json["CITY_INITIAL"] as? String ?? ""
        self.City_Name = json["CITY_NAME"] as? String ?? ""
        self.Province_ID = json["PROVINCE_ID"] as? String ?? ""
        self.Province_Initial = json["PROVINCE_INITIAL"] as? String ?? ""
        self.Province_Name = json["PROVINCE_NAME"] as? String ?? ""
        self.Owner = json["Owner"] as? String ?? ""
        self.Address_Supplier = json["ADDRESS_SUPPLIER"] as? String ?? ""
        self.PNumber_Supplier = json["PNUMBER_SUPPLIER"] as? String ?? ""
        self.Create_At_Supplier = json["CREATE_AT_SUPPLIER"] as? String ?? ""
        self.Update_At_Supplier = json["UPDATE_AT_SUPPLIER"] as? String ?? ""
        self.Delete_At_Supplier = json["DELETE_AT_SUPPLIER"] as? String ?? ""
        self.Employee_ID = json["EMPLOYEE_ID"] as? String ?? ""
        self.LName_Employee = json["FNAME_EMPLOYEE"] as? String ?? ""
        self.FName_Employee = json["LNAME_EMPLOYEE"] as? String ?? ""
        self.Role = json["ROLE"] as? String ?? ""
        }
}

