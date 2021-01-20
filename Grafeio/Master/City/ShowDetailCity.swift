//
//  ShowDetailCity.swift
//  Grafeio
//
//  Created by Ryan Octavius on 01/12/20.
//

import SwiftUI

struct ShowDetailCity: View {
    @EnvironmentObject var AuthUser : UserAuth
    @EnvironmentObject var CityDelete : DeleteCity
    @State var Cities : City? = nil
    
    var body: some View {
        if CityDelete.isSuccess {
            return AnyView(CityPage().environmentObject(AuthUser))
        }
        else {
            return AnyView(DetailCity(Cities : Cities))
        }
        
        //DetailCity(Cities : Cities)
    }
}

struct DetailCity : View {
    @State var Cities : City? = nil
    @State var BtnEditPressed : Bool = false
    @State var BtnDeletePressed : Bool = false
    @EnvironmentObject var CityDelete : DeleteCity
    @EnvironmentObject var CityEdit : EditCity
    @EnvironmentObject var CityGet : GetCity
    @EnvironmentObject var AuthUser : UserAuth
    
    var leftContent : some View {
        VStack(alignment : .leading){
            Group{
                Text("City ID")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("City Initial")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("City Name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Province Initial")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Province Name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    
            }
        }
    }
    
    var rightContent : some View {
        VStack(alignment : .leading){
            Group{
                Text(Cities!.City_ID)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Cities!.City_Initial)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Cities!.City_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Cities!.Province_Initial)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
                Text(Cities!.Province_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    
                    
            }
        }
    }
    
    var fullView : some View {
        ZStack(){
            Text("")
                .frame(width: 650, height: 310, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
    
            VStack(){
                HStack(){
                    Text("City Detail")
                        .font(.largeTitle)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .frame(width: 370, height: 50, alignment: .leading)
                    
                    Spacer().frame(width: 130, height: 2, alignment: .center)
                    
                    Button(action : {
                        
                        BtnEditPressed.toggle()
                    }){
                        HStack(){
                            Image(systemName: "pencil")
                                .scaleEffect(2)
                                .padding()
                                .foregroundColor(Color(.blue))
                                .frame(width: 45, height: 45, alignment: .center)
                        }
                    }
                    
                    Button(action : {
                        
                        BtnDeletePressed.toggle()
                        
                        
                    }){
                        HStack(){
                            Image(systemName: "trash.fill")
                                .scaleEffect(2)
                                .padding()
                                .foregroundColor(Color(.red))
                                .frame(width: 45, height: 45, alignment: .center)
                        }
                    }
                    
                    
                }
                
                Spacer()
                
                HStack(){
                    
                    leftContent.frame(alignment: .topLeading)
                    
                    Spacer().frame(width: 20, height: 0, alignment: .center)
                    
                    rightContent.frame(alignment: .topLeading)
                }.frame(width: 600, height: 200, alignment: .leading)
                
            }.frame(width: 600, height: 260, alignment: .leading)
            .padding()
        }
    }
    
    var body: some View{
        NavigationLink(destination: EditCityPage(Cities: Cities!), isActive: self.$BtnEditPressed) {EmptyView()}
        
        fullView
            .alert(isPresented: $BtnDeletePressed) {
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        CityGet.emptyArr()
                        CityDelete.deleteCity(city_id : Cities!.City_ID)
                        
                    }
                    let secondaryButton = Alert.Button.destructive(Text("No")) {
                       
                    }
                    return Alert(title: Text("Delete this City ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
        
    }
    
    
}

struct ShowDetailCity_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailCity()
    }
}
