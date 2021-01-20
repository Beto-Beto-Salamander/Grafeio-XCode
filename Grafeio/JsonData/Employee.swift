import Foundation
import SwiftUI

class Employee : NSObject, Decodable {
    var Employee_ID : String
    var Password : String
    var LName_Employee : String
    var FName_Employee : String
    var City_ID : String
    var City_Initial : String
    var City_Name : String
    var Province_ID : String
    var Province_Initial : String
    var Province_Name : String
    var Address_Employee : String
    var BDate_Employee : String
    var PNumber_Employee : String
    var Role : String
    var Salary : String
    var Hire_Date : String
    var Create_At_Employee : String
    var Update_At_Employee : String
    var Delete_At_Employee : String
    
    init(json: [String:Any]) {
        self.Employee_ID = json["EMPLOYEE_ID"] as? String ?? ""
        self.Password = json["PASSWORD"] as? String ?? ""
        self.FName_Employee = json["FNAME_EMPLOYEE"] as? String ?? ""
        self.LName_Employee = json["LNAME_EMPLOYEE"] as? String ?? ""
        self.City_ID = json["CITY_ID"] as? String ?? ""
        self.City_Initial = json["CITY_INITIAL"] as? String ?? ""
        self.City_Name = json["CITY_NAME"] as? String ?? ""
        self.Province_ID = json["PROVINCE_ID"] as? String ?? ""
        self.Province_Initial = json["PROVINCE_INITIAL"] as? String ?? ""
        self.Province_Name = json["PROVINCE_NAME"] as? String ?? ""
        self.Address_Employee = json["ADDRESS_EMPLOYEE"] as? String ?? ""
        self.BDate_Employee = json["BDATE_EMPLOYEE"] as? String ?? ""
        self.PNumber_Employee = json["PNUMBER_EMPLOYEE"] as? String ?? ""
        self.Role = json["ROLE"] as? String ?? ""
        self.Salary = json["SALARY"] as? String ?? ""
        self.Hire_Date = json["HIRE_DATE"] as? String ?? ""
        self.Create_At_Employee = json["CREATE_AT_EMPLOYEE"] as? String ?? ""
        self.Update_At_Employee = json["UPDATE_AT_EMPLOYEE"] as? String ?? ""
        self.Delete_At_Employee = json["DELETE_AT_EMPLOYEE"] as? String ?? ""
        }
}

