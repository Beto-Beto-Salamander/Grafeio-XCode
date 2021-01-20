//
//  HomeScreen.swift
//  Grafeio
//
//  Created by Ryan Octavius on 24/11/20.
//

import SwiftUI
import Combine

struct HomeScreen: View {
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
        if AuthUser.isLoggedin{
            return AnyView(
                NavigationView{
                    
                    FullHomeContent()
                    .padding(.top, -calcPadding())
                    .environmentObject(AuthUser)
    
                }.navigationViewStyle(StackNavigationViewStyle()).navigationBarHidden(true)
            )
        }else{
            return AnyView(ContentView())
        }
       
        
    }
}

struct FullHomeContent : View {
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )

    var body: some View
    {
            VStack(){
                
                TopBar()
                    .padding()
                
                ScrollView(){
                    
                    VStack(){
                        
                        TransOrder()
                        
                        Spacer().frame(width: 10, height: 30, alignment: .center)
                        
                        MasterData()
                        
                        Spacer().frame(width: 10, height: 30, alignment: .center)
                        
                        AttendReport()
                        
                    }
                }
                
            }
    }
}

struct TopBar : View {
    @EnvironmentObject var AuthUser: UserAuth
    @State var FName : String = ""
    @State var LName : String = ""
    @State var accountTapped : Bool = false
    
    var WelcomeText : some View {
        Text("Welcome,")
            .foregroundColor(Color.black)
            .font(.system(size: 25, weight: .medium))
    }
    
    var NameText : some View {
        Text(FName + " " + LName)
            .foregroundColor(Color.black)
            .font(.system(size: 30, weight: .bold))
            .onReceive(AuthUser.$Emp, perform: { Emp in
                self.FName = Emp?.FName_Employee ?? "Test"
                self.LName = Emp?.LName_Employee ?? "Test"
            })
    }
    
    var accountButton : some View {
        Button(action : {
            
            accountTapped.toggle()
            
        }){
            
            Image("account")
                .resizable()
                .frame(width: 75, height: 75)
                .padding()
                
        }
    }
    
    var notifImg : some View {
        Image(systemName: "bell.fill")
            .scaleEffect(2)
            .foregroundColor(Color.blue)
            .padding()
    }
    
    var body: some View{
        ZStack(){
            
            HStack(){
                
                accountButton
                
                VStack(alignment: .leading){
                    
                    WelcomeText

                    NameText
                    
                }
                
                Spacer().frame(width: 300)
                
                notifImg

            }.zIndex(2.0)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width - 35, height: 120, alignment: .leading)
            .foregroundColor(Color.blue.opacity(0.2))
            
        }
        .alert(isPresented: $accountTapped) {
            
                let primaryButton = Alert.Button.default(Text("Yes")) {
                    AuthUser.isLoggedin = false
                    accountTapped = false
                }
            
                let secondaryButton = Alert.Button.destructive(Text("No")) {
                    accountTapped = false
                }
            
                return Alert(title: Text("Log out ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}

struct MasterData : View {
    
    @State var CardHeight : CGFloat = 80
    @State var CardWidth : CGFloat = 350
    @State var TextOffX : CGFloat = 0.0
    @State var TextOffY : CGFloat = 0.0
    @State var TextSize : CGFloat = 27
    
    @State public var ProductPress : Bool = false
    @State public var SupplierPress : Bool = false
    @State public var EmployeePress : Bool = false
    @State public var CustomerPress : Bool = false
    @State public var CategoryPress : Bool = false
    @State public var CityPress : Bool = false
    @State public var ProvincePress : Bool = false
    
    @EnvironmentObject var ProductObj : GetProduct
    
    let rows = [GridItem(.adaptive(minimum: 300))]
    
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var MasterText : some View {
        Text("Data")
            .foregroundColor(Color.black)
            .font(.system(size: 30, weight: .bold))
            .frame(width: UIScreen.main.bounds.width - 35, alignment: .leading)
            .padding(.leading)

    }
    
    var productCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "bag.fill")
                    .foregroundColor(Color(red: 0.7, green: 0.5, blue: 0.3))
                    .scaleEffect(2)
                    .padding()
                
                Text("Product")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var supplierCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "bag.badge.plus.fill")
                    .foregroundColor(Color(red: 0.7, green: 0.2, blue: 0.2))
                    .scaleEffect(2)
                    .padding()
                
                Text("Supplier")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var employeeCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "person.3.fill")
                    .foregroundColor(Color(red: 0.8, green: 0.7, blue: 0.1))
                    .scaleEffect(2)
                    .padding()
                
                Text("Employee")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var customerCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "person.2.fill")
                    .foregroundColor(Color(red: 0.4, green: 0.6, blue: 0.9))
                    .scaleEffect(2)
                    .padding()
                
                Text("Customer")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 100)
    
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var categoryCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "rectangle.3.offgrid.fill")
                    .foregroundColor(Color(red: 0.7, green: 0.5, blue: 0.9))
                    .scaleEffect(2)
                    .padding()
                
                Text("Category")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var cityCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "location.fill")
                    .foregroundColor(Color(red: 0.9, green: 0.4, blue: 0.7))
                    .scaleEffect(2)
                    .padding()
                
                Text("City")
                    .foregroundColor(.black)
                    .font(.system(size: 20))
                    .frame(width: 100)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
        
    var provinceCard : some View {
        ZStack(){
            
            VStack(){
                
                Image(systemName: "location.north.fill")
                    .foregroundColor(Color(red: 0.9, green: 0.4, blue: 0.4))
                    .scaleEffect(2)
                    .padding()
                
                Text("Province")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
                    .frame(width: 100)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 120 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var body: some View{
        NavigationLink(destination: ProductPage(), isActive: self.$ProductPress) {EmptyView()}
        NavigationLink(destination: SupplierPage(), isActive: self.$SupplierPress) {EmptyView()}
        NavigationLink(destination: EmployeePage(), isActive: self.$EmployeePress) {EmptyView()}
        NavigationLink(destination: CategoryPage(), isActive: self.$CategoryPress) {EmptyView()}
        NavigationLink(destination: CustomerPage(), isActive: self.$CustomerPress) {EmptyView()}
        NavigationLink(destination: CityPage(), isActive: self.$CityPress)
            {EmptyView()}
        NavigationLink(destination: ProvincePage(), isActive: self.$ProvincePress) {EmptyView()}
        
        VStack(){
            MasterText
                .padding(.top, -10)
        
            ScrollView(.horizontal){
                HStack(){
                    
                    Group{
                        
                        self.productCard
                            .onTapGesture {
                                self.ProductPress.toggle()
                                ProductObj.btnBackProductClicked = false
                                ProductObj.isSearchActive = false
                                ProductObj.isEmptyFiltered = false
                            }
                        
                        Spacer().frame(width: 20)
                        
                        self.supplierCard
                            .onTapGesture {
                                self.SupplierPress.toggle()
                            }
                        
                        Spacer().frame(width: 20)
                        
                        self.employeeCard
                            .onTapGesture {
                                self.EmployeePress.toggle()
                            }
                        
                        Spacer().frame(width: 20)
                        
                        self.customerCard
                            .onTapGesture {
                                self.CustomerPress.toggle()
                            }
                        
                        Spacer().frame(width: 20)
                    }
    
                    Group{
                        
                        self.categoryCard
                            .onTapGesture {
                                self.CategoryPress.toggle()
                            }
                        
                        Spacer().frame(width: 20)
                       
                        self.cityCard
                            .onTapGesture {
                                self.CityPress.toggle()
                            }
                        
                        Spacer().frame(width: 20)
                        
                        self.provinceCard
                            .onTapGesture {
                                self.ProvincePress.toggle()
                            }
                    }
                    
                }
                .padding()
            }
            .frame(width: UIScreen.main.bounds.width - 20, height: 130)
        }
        
    }
}

struct TransOrder : View {
    @State var TOCardW : CGFloat = 100
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var TransactText : some View {
        Text("Transaction & Order")
            .foregroundColor(Color.black)
            .font(.system(size: 30, weight: .bold))
            .frame(width: UIScreen.main.bounds.width - 35, alignment: .leading)
            .padding(.leading)
    }
    
    var TransactCard : some View {
        ZStack(){
            
            HStack(){
                
                Image(systemName: "banknote.fill")
                    .foregroundColor(Color(red: 0.2, green: 0.7, blue: 0.4))
                    .scaleEffect(2)
                    .padding()
                
                Text("Transaction")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .frame(width: 200)
                
                Image(systemName: "control")
                    .foregroundColor(Color.gray)
                    .rotationEffect(Angle.init(degrees: 90))
                    .scaleEffect(2)
                    .padding()
                    .opacity(0)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 80 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var OrdCard : some View {
        ZStack(){
            
            HStack(){
                
                Image(systemName: "shippingbox.fill")
                    .foregroundColor(Color(red: 0.7, green: 0.5, blue: 0.3))
                    .scaleEffect(2)
                    .padding()
                
                Text("Order")
                    .foregroundColor(.black)
                    .frame(width: 200)
                    .font(.system(size: 20, weight: .medium))
                
                Image(systemName: "control")
                    .foregroundColor(Color.gray)
                    .rotationEffect(Angle.init(degrees: 90))
                    .scaleEffect(2)
                    .padding()
                    .opacity(0)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
    
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 80 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var body: some View {
        VStack(){
            
            TransactText
        
                HStack(){
                    
                    Spacer()
                    
                    self.TransactCard
                        
                    Spacer()
                    
                    self.OrdCard
                    
                    Spacer()
                    
                }.frame(height : 100)
        }
    }
    
}

struct AttendReport : View {
    @State var TOCardW : CGFloat = 100
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var AttRepText : some View {
        Text("Attendance & Report")
            .foregroundColor(Color.black)
            .font(.system(size: 30, weight: .bold))
            .frame(width: UIScreen.main.bounds.width - 35, alignment: .leading)
            .padding(.leading)
            .background(Color.white)
    }
    
    var AttCard : some View {
        ZStack(){
            
            HStack(){
                
                Image(systemName: "calendar")
                    .foregroundColor(Color(red: 1.0, green: 0.2, blue: 0.4))
                    .scaleEffect(2)
                    .padding()
                
                Text("Attendance")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .frame(width: 200)
                
                Image(systemName: "control")
                    .foregroundColor(Color.gray)
                    .rotationEffect(Angle.init(degrees: 90))
                    .scaleEffect(2)
                    .padding()
                    .opacity(0)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 80 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var ReportCard : some View {
        ZStack(){
            
            HStack(){
                
                Image(systemName: "scroll.fill")
                    .foregroundColor(Color(red: 0.6, green: 0.6, blue: 0.6))
                    .scaleEffect(2)
                    .padding()
                
                Text("Report")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .frame(width: 200)
                
                Image(systemName: "control")
                    .foregroundColor(Color.gray)
                    .rotationEffect(Angle.init(degrees: 90))
                    .scaleEffect(2)
                    .padding()
                    .opacity(0)
                
            }.zIndex(2.0)
            .padding(.vertical, 20)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 350, height: 80 )
            .foregroundColor(.white)
            .shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        }
    }
    
    var body: some View {
        VStack(){
            
            AttRepText
                .padding(.top, -10)
            
            HStack(){
                
                Spacer()
                
                self.AttCard
                    
                Spacer()
                
                self.ReportCard
                
                Spacer()
                
            }
        }
    }

}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
            HomeScreen()
                .environmentObject(UserAuth())
    }
}
