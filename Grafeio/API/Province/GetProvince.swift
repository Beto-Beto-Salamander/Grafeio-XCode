//
//  GetProvince.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import Foundation
import Combine
import SwiftUI
import SystemConfiguration
import Alamofire

class GetProvince: ObservableObject {
    
    var didChange = PassthroughSubject<GetProvince, Never>()
    var willChange = PassthroughSubject<Province, Never>()
    
    @Published var idProv : String = "" {
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
    
    @Published var tempProvince : Province? = nil
    
    @Published var Provinces = [Province]()
    
    func getProvince(province_id : String) {
        self.Provinces.removeAll()
        if province_id != "" {
            idProv = "/" + province_id
        }
        self.idProv = province_id
        
        let url = URL(string: "http://localhost/PPTA/index.php/PROVINCE" + idProv)
        URLSession.shared.dataTask(with: url!){
            (data,response,err) in
            if err != nil{
                print("error", err ?? "")
            }
            else{
                if let useable = data{
                    do{
                        let jsonObject = try JSONSerialization.jsonObject(with: useable, options: .mutableContainers) as AnyObject
                        
                        let ProvinceData = jsonObject["Data"] as? [AnyObject]
                        for obj in ProvinceData! {
                            let P = Province(json: obj as! [String:Any])
                            DispatchQueue.main.async {
                                self.Provinces.append(P)
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
        self.Provinces.removeAll()
    }
}
