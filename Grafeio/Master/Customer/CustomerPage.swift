//
//  CustomerPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 01/12/20.
//

import SwiftUI

struct CustomerPage: View {
    @EnvironmentObject var AuthUser : UserAuth
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
            //if ProductObj.isEmptyArr {
            //    ProductEmpty()
            //}else{
        ZStack(){
               VStack(){
                    HeaderCustomer()
                    ListCustomer()
                }

            PostCustomerFloatingButton()
        }
            //}
        
        .navigationBarTitle("Customer Page", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
    }
}

struct CustomerLoading : View {
    @EnvironmentObject var CustomerDel : DeleteCustomer
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var LoadingProgress: some View {
        Text(CustomerDel.isSuccess ? "Success" : "Failed")
            .font(.system(size: 20))
            .bold()
            .transition(.slide)
            .frame(width: 200, height: 100, alignment: .center)
            .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                    )
            .foregroundColor(.white)
            .background(CustomerDel.isSuccess ? Color.green : Color.red)
            .cornerRadius(20)
            
    }
    
    var body: some View{
        LoadingProgress
        
    }
    
}

struct PostCustomerFloatingButton : View {
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var btn : some View {
        
        Text("+")
        .font(.system(size: 40, weight: .medium, design: .rounded))
        .foregroundColor(.white)
        .frame(width: 70, height: 70, alignment: .center)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.systemIndigo), .blue]), startPoint: .leading, endPoint: .bottom)
        )
        .cornerRadius(35)
                    
    }
    
    var body: some View {
        VStack(){
            Spacer()
            HStack(){
                Spacer()
                NavigationLink(
                    destination: PostCustomerPage()){
                self.btn
                }
            }
            .padding()
            .padding(.trailing,10)
        }
    }
}

struct HeaderCustomer : View {
    @State var SearchText : String = ""
    @State private var showCancelButton: Bool = false
    @EnvironmentObject var CustomerDelete : DeleteCustomer
    @EnvironmentObject var CustomerPost : PostCustomer
    @EnvironmentObject var CustomerEdit : EditCustomer
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    @EnvironmentObject var CustomerObj : GetCustomer
    
    var ButtonSort : some View {
        Button(action : {
            
        }){
            HStack(){
                Image(systemName: "arrow.up.arrow.down")
                Text("Sort")
            }
            .padding()
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .frame(width: 100, height: 45, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemIndigo), .blue]), startPoint: .leading, endPoint: .bottom)
            )
            .cornerRadius(20)
        }
    }
    
    var ButtonFilter : some View {
        Button(action : {
           
        }){
            HStack(){
                Image(systemName: "line.horizontal.3.decrease.circle")
                Text("Filter")
            }
            .padding()
            .font(.system(size: 13, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .frame(width: 100, height: 45, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [Color(.systemIndigo), .blue]), startPoint: .leading, endPoint: .bottom)
            )
            .cornerRadius(20)
        }
    }
    
    var body: some View {
        HStack(){
                HStack {
                    Spacer().frame(width: 10, height: 30, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        Image(systemName: "magnifyingglass")
                        TextField("Type product name", text: $SearchText, onEditingChanged: { isEditing in
                        self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        })
                        .frame(width: 465, height: 30)
                        .foregroundColor(.primary)
                            Button(action: {
                        self.SearchText = ""
                        }) {
                            Image(systemName: "xmark.circle.fill").opacity(SearchText == "" ? 0 : 1)
                                .padding(.trailing,10)
                        }
                    
                }.background(Color.init(red: 0.5, green: 0.6, blue: 0.8)
                                .opacity(0.1))
                .cornerRadius(20)
            
                self.ButtonSort
                self.ButtonFilter
                Spacer()
        }.padding()
        .onAppear(perform: {
            CustomerObj.emptyArr()
            CustomerObj.getCustomer(customer_id: "")
            CustomerPost.initCondition()
            CustomerEdit.initCondition()
            CustomerDelete.initCondition()
        })
        }
}

struct CustomerEmpty : View {
    var TextEmpty : some View {
        VStack(){
            Text("A little bit empty here . . .")
                .font(.largeTitle)
            
            Text("Have you check your connection ??")
                .font(.title)
        }
    }
    
    var ImgEmpty : some View {
        ZStack(){
            Text("")
                .frame(width: 300, height: 300, alignment: .center)
                .background(
                    Color.init(red: 0.5, green: 0.6, blue: 0.8)
                    .opacity(0.1)
                )
                .cornerRadius(20.0)
            
            Image("sitting-4")
                .resizable()
                .frame(width: 300, height: 300, alignment: .center)
                .cornerRadius(20.0)
            
        }
    }
    
    var body: some View {
        VStack(){
            TextEmpty
            ImgEmpty
        }
        
    }
}

struct CardViewCustomer : View {
    
    @State var FName : String = ""
    @State var LName : String = ""
    @State var Adr : String = ""
    @State var Bdate : String = ""
    @State var Pnumber : String = ""
    @State var CustID : String = ""
   
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var InfoCard : some View {
        VStack(){
            Text(FName.uppercased() + " " + LName.uppercased())
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .frame(width: 220, height: 20, alignment: .topLeading)
                .padding(.trailing,20)
            
            Text(Adr)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .frame(width: 250, height: 20, alignment: .topLeading)
                .padding(.leading,10)
            
            Text(Bdate)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .frame(width: 250, height: 20, alignment: .topLeading)
                .padding(.leading,10)
            
            Text(Pnumber)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .frame(width: 250, height: 20, alignment: .topLeading)
                .padding(.leading,10)
            
            HStack(){
                Image(systemName: "staroflife.circle")
                    .background(gradient.mask(Image(systemName: "staroflife.circle")))
                
                Text("Customer ID : " + CustID)
                    .foregroundColor(Color.clear)
                    .background(gradient.mask(Text("Customer ID : " + CustID)))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .frame(width: 220, height: 20, alignment: .leading)
            }
        }
    }
    
    var BgCard : some View {
        Text("")
            .frame(width: 320, height: 140, alignment: .center)
            .padding()
            .background(Color.white)
            .cornerRadius(20.0)
            .opacity(1.0)
    }
    
    var body : some View {
        ZStack(){
            HStack(){
                InfoCard
                    .zIndex(1.0)
                
                Spacer()
                    .frame(width: 40, height: 200, alignment: .center)
                
                
            }.zIndex(1.0)
            .frame(width: 340, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            BgCard
            
        }
    }
}



struct ListCustomer : View {
    let colors : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    let columns = [GridItem(.adaptive(minimum: 300))]
    @State var Categories : Customer?
    @State var isPressed : Bool = false
    @State var changeView : Bool = false
    @State var showDetail : Bool = false
    @State var notAvailable : Bool = false
   
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var CustomerObj : GetCustomer
    
    var body : some View {
            VStack(){
                ScrollView{
                    LazyVGrid(columns: columns , spacing : 20 ) {
                        ForEach(CustomerObj.Customers, id: \.Customer_ID){ i in
                            NavigationLink(destination: ShowDetailCustomer(Customers : i)){
                                CardViewCustomer( FName : i.FName_Customer,
                                    LName : i.LName_Customer,
                                    Adr   : i.Address_Customer,
                                    Bdate : i.BDate_Customer,
                                    Pnumber :i.PNumber_Customer ,
                                    CustID : i.Customer_ID
                                                ).id(i.Customer_ID)
                               }
                            }
                        }
                    }.padding([.top, .horizontal, .bottom], 30)
                }.background(Color.init(red: 0.5, green: 0.6, blue: 0.8).opacity(0.1))
        }
    func disappearResult() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            //CustomerDel.showResult = false
        }
    }
}

struct CustomerPage_Previews: PreviewProvider {
    static var previews: some View {
        CustomerPage()
    }
}
