import Foundation
import SwiftUI

class Product : NSObject, Decodable {
    var Product_ID : String
    var Product_Name : String
    var Category_ID : String
    var Category_Name : String
    var Category_Description : String
    var Buy_Price : String
    var Sell_Price : String
    var Stock : String
    var Min_Stock : String
    var Product_Description : String
    var Supplier_ID : String
    var FName_Supplier : String
    var LName_Supplier : String
    var Owner : String
    var City_ID : String
    var City_Initial : String
    var City_Name : String
    var Province_ID : String
    var Province_Initial : String
    var Province_Name : String
    var Employee_ID : String
    var LName_Employee : String
    var FName_Employee : String
    var Role : String
    var Create_At_Product : String
    var Update_At_Product : String
    var Delete_At_Product : String
    var Photo : String
    
    init(json: [String:Any]) {
        self.Product_ID = json["PRODUCT_ID"] as? String ?? ""
        self.Product_Name = json["PRODUCT_NAME"] as? String ?? ""
        self.Product_Description = json["PRODUCT_DESCRIPTION"] as? String ?? "-"
        self.Category_ID = json["CATEGORY_ID"] as? String ?? ""
        self.Category_Name = json["CATEGORY_NAME"] as? String ?? ""
        self.Category_Description = json["CATEGORY_DESCRIPTION"] as? String ?? "-"
        self.Buy_Price = json["BUY_PRICE"] as? String ?? ""
        self.Sell_Price = json["SELL_PRICE"] as? String ?? ""
        self.Stock = json["STOCK"] as? String ?? ""
        self.Min_Stock = json["MIN_STOCK"] as? String ?? ""
        self.Supplier_ID = json["SUPPLIER_ID"] as? String ?? ""
        self.FName_Supplier = json["FNAME_SUPPLIER"] as? String ?? ""
        self.LName_Supplier = json["LNAME_SUPPLIER"] as? String ?? ""
        self.Owner = json["OWNER"] as? String ?? ""
        self.City_ID = json["CITY_ID"] as? String ?? ""
        self.City_Initial = json["CITY_INITIAL"] as? String ?? ""
        self.City_Name = json["CITY_NAME"] as? String ?? ""
        self.Province_ID = json["PROVINCE_ID"] as? String ?? ""
        self.Province_Initial = json["PROVINCE_INITIAL"] as? String ?? ""
        self.Province_Name = json["PROVINCE_NAME"] as? String ?? ""
        self.Create_At_Product = json["CREATE_AT_PRODUCT"] as? String ?? "-"
        self.Update_At_Product = json["UPDATE_AT_PRODUCT"] as? String ?? "-"
        self.Delete_At_Product = json["DELETE_AT_PRODUCT"] as? String ?? "-"
        self.Employee_ID = json["EMPLOYEE_ID"] as? String ?? ""
        self.LName_Employee = json["FNAME_EMPLOYEE"] as? String ?? ""
        self.FName_Employee = json["LNAME_EMPLOYEE"] as? String ?? ""
        self.Role = json["ROLE"] as? String ?? ""
        self.Photo = json["PHOTO"] as? String ?? ""
        }
}

