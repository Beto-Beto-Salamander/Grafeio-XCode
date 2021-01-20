import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetEmployee: ObservableObject {
    
    var didChange = PassthroughSubject<GetEmployee, Never>()
    var willChange = PassthroughSubject<Product, Never>()
    
    @Published var idE : String = "" {
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
    
    @Published var showDetail : Bool = false {
        didSet {
            didChange.send(self)
        }
    }
    
    @Published var Employees = [Employee]()
    
    func getEmployee(employee_id : String) {
        emptyArr()
        if employee_id != "" {
            idE = "/" + employee_id
        }
        self.idE = employee_id
        
        let url = URL(string: "http://localhost/PPTA/index.php/EMPLOYEE" + idE)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let EmployeeData = jsonObject["Data"] as? [AnyObject]
                        for obj in EmployeeData! {
                            let E = Employee(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Employees.append(E)
                                self.isLoading = false
                                self.isEmptyArr = false
                            }
                        }
                    }
                    catch{
                        self.isLoading = false
                        self.isEmptyArr = true
                        print("catch error")
                    }
                }
            }
        }.resume()
    }
    
    func emptyArr(){
        self.Employees.removeAll()
    }
}
