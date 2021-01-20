//
//  GetCategory.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetCategory: ObservableObject {
    
    var didChange = PassthroughSubject<GetCategory, Never>()
    
    
    @Published var idCat : String = "" {
        didSet {
            didChange.send(self)
        }
    }
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isLoading : Bool = false
    
    @Published var isEmptyArr : Bool = true 
    
    @Published var showDetail : Bool = false
    
    @Published var tempCategory : Category? = nil {
        willSet {
            objectWillChange.send()
        }
    }
    
    @Published var Categories = [Category]() {
        willSet {
            objectWillChange.send()
        }
    }
    
    func getCategory() {
        self.Categories.removeAll()
        let url = URL(string: "http://localhost/PPTA/index.php/CATEGORY")
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let CategoryData = jsonObject["Data"] as? [AnyObject]
                        for obj in CategoryData! {
                            let Cat = Category(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Categories.append(Cat)
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
    
    func getCategory2(category_id : String) {
        let url = URL(string: "http://localhost/PPTA/index.php/CATEGORY/" + category_id)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let CategoryData = jsonObject["Data"] as? [AnyObject]
                        for obj in CategoryData! {
                            let Cat = Category(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.tempCategory = Cat
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
        self.Categories.removeAll()
    }
}
