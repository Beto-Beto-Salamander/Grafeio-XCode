//
//  ShowDetailCustomer.swift
//  Grafeio
//
//  Created by Ryan Octavius on 01/12/20.
//

import SwiftUI

struct ShowDetailCustomer: View {
    @EnvironmentObject var AuthUser : UserAuth
    @EnvironmentObject var CustomerDelete : DeleteCustomer
    @State var Customers : Customer? = nil
    
    var body: some View {
        if CustomerDelete.isSuccess {
            return AnyView(CustomerPage().environmentObject(AuthUser))
        }
        else {
            return AnyView(DetailCustomer(Customers : Customers))
        }
        
        //DetailCustomer(Customers : Customers)
    }
}

struct DetailCustomer : View {
    @State var Customers : Customer? = nil
    @State var BtnEditPressed : Bool = false
    @State var BtnDeletePressed : Bool = false
    @EnvironmentObject var CustomerDelete : DeleteCustomer
    @EnvironmentObject var CustomerEdit : EditCustomer
    @EnvironmentObject var CustomerGet : GetCustomer
    @EnvironmentObject var AuthUser : UserAuth
    
    var leftContent : some View {
        VStack(alignment : .leading){
            Group{
                Text("Customer ID")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Customer Name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Birth Date")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Address")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Province Initial - Province Name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("City Initial - City Name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Phone Number")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Created At")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Updated At")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    
            }
            
            Group {
                Text("Deleted At")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Last Modified By")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
            }
        }
    }
    
    var rightContent : some View {
        VStack(alignment : .leading){
            Group{
                Text(Customers!.Customer_ID)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.FName_Customer + " " + Customers!.LName_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.BDate_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.Address_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                                    
                Text(Customers!.Province_Initial + " - " + Customers!.Province_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.City_Initial + " - " + Customers!.City_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.PNumber_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.Create_At_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.Update_At_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
            Group {
                
                Text(Customers!.Delete_At_Customer)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Customers!.Employee_ID + " - " + Customers!.FName_Employee + Customers!.LName_Employee)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
            }
        }
    }
    
    var fullView : some View {
        ZStack(){
            Text("")
                .frame(width: 650, height: 450, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
    
            VStack(){
                HStack(){
                    Text("Customer Detail")
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
                }.frame(width: 600, height: 340, alignment: .leading)
                
            }.frame(width: 600, height: 400, alignment: .leading)
            .padding()
        }
    }
    
    var body: some View{
        NavigationLink(destination: EditCustomerPage(Customers: Customers!), isActive: self.$BtnEditPressed) {EmptyView()}
        
        fullView
            .alert(isPresented: $BtnDeletePressed) {
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        
                        CustomerDelete.deleteCustomer(customer_id : Customers!.Customer_ID)
                        
                    }
                    let secondaryButton = Alert.Button.destructive(Text("No")) {
                       
                    }
                    return Alert(title: Text("Delete this Customer ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
        
    }
    
    
}

struct ShowDetailCustomer_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailCustomer()
    }
}
