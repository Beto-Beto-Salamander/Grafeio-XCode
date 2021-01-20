//
//  PostProvince.swift
//  Grafeio
//
//  Created by Ryan Octavius on 01/12/20.
//

import SwiftUI

struct PostProvincePage: View {
    @EnvironmentObject var ProvincePost: PostProvince
    @EnvironmentObject var AuthUser: UserAuth
    var deviceHeight: CGFloat {
        UIScreen.main.bounds.height
    }

      func calcPadding() -> CGFloat {
            var padding: CGFloat = 0.0
            switch self.deviceHeight {
            case 568.0: padding = 94.0 + 6.0
            case 667.0: padding = 96.0 + 10.0
            case 736.0: padding = 96.0 + 10.0
            case 812.0: padding = 106.0 + 10.0
            case 896.0: padding = 106.0 + 10.0
            default:
                padding = 106.0
            }

        return padding
    }
    
    var body: some View {
            //if ProvinceObj.isEmptyArr {
            //    ProvinceEmpty()
            //}else{
        
        if ProvincePost.isSuccess {
            return AnyView(ProvincePage().environmentObject(AuthUser))
        }
        else {
            return AnyView(PostViewProvince())
        }
    }
}

struct PostViewProvince : View {
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var ProvincePost: PostProvince
    @EnvironmentObject var ProvinceGet: GetProvince
    
    @State var BtnSubmitPresssed : Bool = false
    @State var ProvinceName : String = ""
    @State var ProvinceInitial : String = ""
    
    var PInitTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Province Initial")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$ProvinceInitial)
                .foregroundColor(.black)
                .padding()
                .font(.headline)
                .frame(width: 380, height: 50, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                
            Spacer()
        }
    }
    
    var PNameTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Province Name")
                .frame(width: 200, height: 50, alignment: .topLeading)
                .font(.title)
            
            TextField("", text : self.$ProvinceName)
                .foregroundColor(.black)
                .padding()
                .font(.headline)
                .frame(width: 380, height: 50, alignment: .topLeading)
                .background(Color.white)
                .cornerRadius(20)
                .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.blue, lineWidth: 2)
                        )
            
            Spacer()
        }
    }
    
    
    var BtnSubmit : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Spacer()
            
            Button(action : {
                self.BtnSubmitPresssed.toggle()
            }){
                HStack(){
                    Text("Submit")
                        .padding()
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                    Image(systemName: "checkmark.circle")
                        
                }.foregroundColor(.white)
                .frame(width: 150, height: 45, alignment: .center)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemIndigo), .blue]), startPoint: .leading, endPoint: .bottom)
                )
                .cornerRadius(20)
                
            }
            
            Spacer()
                .frame(width: 75, height: 100, alignment: .center)

        }
    }

    
    var body : some View {
        VStack{
            Spacer()
                .frame(width: 100, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            PInitTextF
            
            PNameTextF
            
            BtnSubmit
            
            Spacer()
            
        }.alert(isPresented: $BtnSubmitPresssed) {
                let primaryButton = Alert.Button.default(Text("Yes")) {
                    self.ProvincePost.postProvince(pname : self.ProvinceName,
                                                   pinitial : self.ProvinceInitial)
                    
                    ProvinceGet.emptyArr()
                    
                }
                let secondaryButton = Alert.Button.destructive(Text("No")) {
                   
                }
                return Alert(title: Text("Submit ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}
struct PostProvincePage_Previews: PreviewProvider {
    static var previews: some View {
        PostProvincePage()
    }
}
