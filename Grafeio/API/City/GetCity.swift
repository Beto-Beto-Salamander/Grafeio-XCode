//
//  GetCity.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetCity: ObservableObject {
    
    var didChange = PassthroughSubject<GetCity, Never>()
    var willChange = PassthroughSubject<City, Never>()
    
    @Published var idCt : String = "" 
    
    var request: Alamofire.Request? {
        didSet {
            //oldValue?.cancel()
        }
    }
    
    @Published var isLoading : Bool = false
    
    @Published var isEmptyArr : Bool = true
    
    @Published var showDetail : Bool = false
    
    @Published var tempCategory : Category? = nil
    
    @Published var Cities = [City]()
    
    func getCity(city_id : String) {
        self.Cities.removeAll()
        if city_id != "" {
            idCt = "/" + city_id
        }
        self.idCt = city_id
        
        let url = URL(string: "http://localhost/PPTA/index.php/CITY" + idCt)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let CityData = jsonObject["Data"] as? [AnyObject]
                        for obj in CityData! {
                            let C = City(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Cities.append(C)
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
        self.Cities.removeAll()
    }
}
