import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetProduct: ObservableObject {
    
    var didChange = PassthroughSubject<GetProduct, Never>()
    var willChange = PassthroughSubject<Product, Never>()
    var idP : String = ""
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    var Prod = [Product]()
    var tempProd : Product? = nil
    var sortOrder : String = ""
    
    @Published var search : String = ""
    @Published var isSearchActive : Bool = false
    @Published var btnBackProductClicked : Bool = false
    @Published var btnBackPostProductClicked : Bool = false
    @Published var btnBackDetailProductClicked : Bool = false
    @Published var btnEditProductClicked : Bool = false
    @Published var isEmptyFiltered : Bool = false
    @Published var isLoading : Bool = false
    @Published var isEmptyArr : Bool = true
    @Published var showDetail : Bool = false
    @Published var Products = [Product]() {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var sortClicked : Bool = false
    @Published var Filtered = [Product]() {
        willSet {
            objectWillChange.send()
        }
    }
    @Published var Sorted = [Product]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    func getProduct(product_id : String) {
    
        isLoading = true
        
        emptyArr()
        
        if product_id != "" {
            idP = "/" + product_id
        }
        self.idP = product_id
        
        let url = URL(string: "http://localhost/PPTA/index.php/PRODUCT" + idP)
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
                            let P = Product(json: obj as! [String:Any])
                            if P.Photo != "" {
                                P.Photo = "http://localhost/PPTA/upload/product/" + P.Photo
                            }else{
                                P.Photo = "http://localhost/PPTA/upload/product/PRODUCT-1-2020-12-13-03-00-26.jpg"
                            }
                            self.Prod.append(P)
                            
                        }
                        DispatchQueue.main.async {
                            self.Products = self.Prod
                            self.isLoading = false
                            self.isEmptyArr = false
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
    
    func searchInList(){
        if (search.isEmpty){
            print("empty")
        }else{
            Filtered = Products.filter { $0.Product_Name.lowercased().contains(search.lowercased())}
            Products = Filtered
            if Filtered.isEmpty {
                isEmptyFiltered = true
            }else{
                isEmptyFiltered = false
            }
        }
    }
    
    func sortList(){
        if (sortOrder.isEmpty){
            
        }else if(sortOrder == "A - Z"){
            Sorted = Products.sorted { $1.Product_Name > $0.Product_Name}
            Products = Sorted
        }else if(sortOrder == "Z - A"){
            Sorted = Products.sorted { $0.Product_Name > $1.Product_Name}
            Products = Sorted
        }else if(sortOrder == "Price low - high"){
            Sorted = Products.sorted { $1.Sell_Price > $0.Sell_Price}
            Products = Sorted
        }else if(sortOrder == "Price high - low"){
            Sorted = Products.sorted { $0.Sell_Price > $1.Sell_Price}
            Products = Sorted
        }
    }
    
    func emptyArr(){
        self.Prod.removeAll()
    }
}
