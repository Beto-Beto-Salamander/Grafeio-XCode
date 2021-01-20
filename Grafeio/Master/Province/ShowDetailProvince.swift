//
//  ShowDetailProvince.swift
//  Grafeio
//
//  Created by Ryan Octavius on 01/12/20.
//

import SwiftUI

struct ShowDetailProvince: View {
    @EnvironmentObject var AuthUser : UserAuth
    @EnvironmentObject var ProvinceDelete : DeleteProvince
    @State var Provinces : Province? = nil
    
    var body: some View {
        if ProvinceDelete.isSuccess {
            return AnyView(ProvincePage().environmentObject(AuthUser))
        }
        else {
            return AnyView(DetailProvince(Provinces : Provinces))
        }
        
        //DetailProvince(Provinces : Provinces)
    }
}

struct DetailProvince : View {
    @State var Provinces : Province? = nil
    @State var BtnEditPressed : Bool = false
    @State var BtnDeletePressed : Bool = false
    @EnvironmentObject var ProvinceDelete : DeleteProvince
    @EnvironmentObject var ProvinceEdit : EditProvince
    @EnvironmentObject var ProvinceGet : GetProvince
    @EnvironmentObject var AuthUser : UserAuth
    
    var leftContent : some View {
        VStack(alignment : .leading){
            Group{
                Text("Province ID")
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
                Text(Provinces!.Province_ID)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Provinces!.Province_Initial)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Provinces!.Province_Name)
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
                    Text("Province Detail")
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
        NavigationLink(destination: EditProvincePage(Provinces: Provinces!), isActive: self.$BtnEditPressed) {EmptyView()}
        
        fullView
            .alert(isPresented: $BtnDeletePressed) {
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        ProvinceGet.emptyArr()
                        ProvinceDelete.deleteProvince(province_id : Provinces!.Province_ID)
                        
                    }
                    let secondaryButton = Alert.Button.destructive(Text("No")) {
                       
                    }
                    return Alert(title: Text("Delete this Province ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
        
    }
    
    
}

struct ShowDetailProvince_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailProvince()
    }
}
