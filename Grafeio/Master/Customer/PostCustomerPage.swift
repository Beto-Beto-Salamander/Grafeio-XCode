//
//  PostCustomerPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 01/12/20.
//

import SwiftUI

struct PostCustomerPage: View {
    @EnvironmentObject var CustomerPost: PostCustomer
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
            //if CustomerObj.isEmptyArr {
            //    CustomerEmpty()
            //}else{
        
        if CustomerPost.isSuccess {
            return AnyView(CustomerPage().environmentObject(AuthUser))
        }
        else {
            return AnyView(PostViewCustomer())
        }
    }
}

struct PostViewCustomer : View {
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var CustomerPost: PostCustomer
    @EnvironmentObject var CustomerGet: GetCustomer
    
    @State var BtnSubmitPresssed : Bool = false
    @State var FName : String = ""
    @State var LName : String = ""
    @State var CityID : String = ""
    @State var Address : String = ""
    @State var Bdate : String = ""
    @State var PNumber : String = ""
    
    var FNameTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("First Name")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$FName)
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
    
    var LNameTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Last Name")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$LName)
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
    
    var CityTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("City")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$CityID)
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
    
    var AdrTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Address")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$Address)
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
    
    var BDateTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Birth Date")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$Bdate)
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
    
    var PNumTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Phone Number")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField("", text : self.$PNumber)
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
            
            FNameTextF
            
            LNameTextF
            
            CityTextF
            
            AdrTextF
            
            BDateTextF
            
            PNumTextF
            
            BtnSubmit
            
            Spacer()
            
        }.alert(isPresented: $BtnSubmitPresssed) {
                let primaryButton = Alert.Button.default(Text("Yes")) {
                    self.CustomerPost.postCustomer(fname: self.FName,
                                                   lname: self.LName,
                                                   city_id: self.CityID,
                                                   bdate: self.Bdate,
                                                   pnumber: self.PNumber,
                                                   address: self.Address,
                                                   emp_id: self.AuthUser.EmployeeID)
                    
                    CustomerGet.emptyArr()
                    
                }
                let secondaryButton = Alert.Button.destructive(Text("No")) {
                   
                }
                return Alert(title: Text("Submit ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}

struct PostCustomerPage_Previews: PreviewProvider {
    static var previews: some View {
        PostCustomerPage()
    }
}
