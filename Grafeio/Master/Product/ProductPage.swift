//
//  ProductPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 26/11/20.
//

import SwiftUI
import Combine

struct ProductPage: View {
    @EnvironmentObject var ProductObj : GetProduct

    var body: some View {
        if ProductObj.btnBackProductClicked {
            return AnyView(HomeScreen()
            .navigationBarHidden(true))
        }else{
            return AnyView(FullProductView()
            .navigationBarHidden(true))
        }
    }
}

struct FullProductView : View {
    @EnvironmentObject var ProductObj : GetProduct
    
    var sortCard : some View {
        
        VStack(){
            
            Group{
                
                Text("Sort product by : ")
                        .font(.system(size: 17, weight: .bold, design: .rounded))
                        .frame(width: 240, height: 45, alignment: .center)
                        .foregroundColor(.black)
                
                Divider()
                
                HStack(){
                    
                    Button(action: {
                        ProductObj.sortClicked = false
                        ProductObj.sortOrder = "A - Z"
                        ProductObj.sortList()
                    }, label: {
                        Text("A - Z")
                            .font(.system(size: 17, weight: ProductObj.sortOrder == "A - Z" ? .bold : .regular , design: .rounded))
                    }).frame(width: 150, height: 45, alignment: .center)
                    .foregroundColor(.blue)
                        
                    
                }
                
                Divider()
                
                Button(action: {
                    ProductObj.sortClicked = false
                    ProductObj.sortOrder = "Z - A"
                    ProductObj.sortList()
                }, label: {
                    Text("Z - A")
                        .font(.system(size: 17, weight: ProductObj.sortOrder == "Z - A" ? .bold : .regular, design: .rounded))
                }).frame(width: 150, height: 45, alignment: .center)
                .foregroundColor(.blue)
                    
                
                Divider()
                
                Button(action: {
                    ProductObj.sortClicked = false
                    ProductObj.sortOrder = "Price low - high"
                    ProductObj.sortList()
                }, label: {
                    Text("Price low - high")
                        .font(.system(size: 17, weight: ProductObj.sortOrder == "Price low - high" ? .bold : .regular, design: .rounded))
                }).frame(width: 180, height: 45, alignment: .center)
                .foregroundColor(.blue)
                    
                
                Divider()
            }
            
            Group{
                
                Button(action: {
                    ProductObj.sortClicked = false
                    ProductObj.sortOrder = "Price high - low"
                    ProductObj.sortList()
                }, label: {
                    Text("Price high - low")
                        .font(.system(size: 17, weight: ProductObj.sortOrder == "Price high - low" ? .bold : .regular, design: .rounded))
                }).frame(width: 180, height: 45, alignment: .center)
                .foregroundColor(.blue)
                    
                
                Divider()
                
                HStack(){
                    Button(action: {
                        ProductObj.sortClicked = false
                        ProductObj.sortOrder = ""
                        ProductObj.getProduct(product_id: "")
                    }, label: {
                        
                        Text("Reset")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                        
                    }).frame(width : 130)
                    .foregroundColor(.blue)
                    
                    
                    
                    
                    Divider()
                        .frame(height : 35)
                    
                    
                    
                    Button(action: {
                        
                        ProductObj.sortClicked = false
                        
                    }, label: {
                        Text("Cancel")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                    })
                    .frame(width : 130)
                    .foregroundColor(.red)
                    
                }
            }
            
        }.frame(width: 300, height: 390)
         .background(Color.white)
         .cornerRadius(10)
         .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1))
            .foregroundColor(.white)
            .zIndex(2.0)
        
    }
    
    var fullView: some View{
        ZStack(){
            
            Group(){
                VStack(){
                 
                     HeaderProduct()
                     ListProduct()
                 
                }.disabled(ProductObj.sortClicked)
                .padding(.top, 10)
                 
                 PostProductFloatingButton()
                     .offset(x: 10, y: 0)
                
            }.overlay(RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.white, lineWidth: 1)
                        .background(ProductObj.sortClicked ? Color.black : Color.clear)
                        .opacity(ProductObj.sortClicked ? 0.2 : 0)
                        .edgesIgnoringSafeArea(.all)
            )
               
            if ProductObj.sortClicked == true {
                
                sortCard
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
                
            }
        }
    }
    
    var body: some View{
        
        fullView
        
    }
}

struct PostProductFloatingButton : View {
    @EnvironmentObject var ProductPost : PostProduct
    @EnvironmentObject var ProductObj : GetProduct
    
    @State var BtnPostPressed : Bool = false
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
        .background(Color.blue)
        .cornerRadius(35)
                    
    }

    
    var body: some View {
        VStack(){
            
            Spacer()
            
            HStack(){
                
                Spacer()
                
                NavigationLink(
                    destination: PostProductPage()){
                    self.btn
                }.padding()
                .padding(.trailing,10)
                .simultaneousGesture(TapGesture().onEnded{
                    ProductPost.isFinish = false
                    ProductObj.isSearchActive = false
                    ProductObj.btnBackPostProductClicked = false
                })
                
            }
        }
    }
}

struct HeaderProduct : View {
    @State var SearchText : String = ""
    @State var isSearchActive : Bool = false
    @State private var showCancelButton: Bool = false
    
    @EnvironmentObject var ProductObj : GetProduct
    @EnvironmentObject var ProductDelete : DeleteProduct
    @EnvironmentObject var ProductPost : PostProduct
    @EnvironmentObject var ProductEdit : EditProduct
    
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )

    var ButtonSort : some View {
        Button(action : {
            
            ProductObj.sortClicked = true
            showCancelButton = false
            ProductObj.isSearchActive = false
            
        }){
            HStack(){
                
                Image(systemName: "arrow.up.arrow.down")
                
                Text("Sort")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
            }
            .padding()
            .foregroundColor(.white)
            .frame(width: 100, height: 40, alignment: .center)
            .background(Color.blue)
            .cornerRadius(10)
        }
    }
    
    var ButtonScan : some View {
        Button(action : {
           
        }){
            
            HStack(){
                
                Image(systemName: "camera.viewfinder")
                
                Text("ML")
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
            }
            .padding()
            .foregroundColor(.white)
            .frame(width: 100, height: 40, alignment: .center)
            .background(Color.init(.purple))
            .cornerRadius(10)
            
        }
    }
    
    var ButtonBack : some View {
        Button(action : {
            ProductObj.btnBackProductClicked = true
            ProductObj.isSearchActive = false
        }){
            
            Image(systemName: "control")
                .foregroundColor(.blue)
                .rotationEffect(Angle.init(degrees: -90))
                .scaleEffect(2)
                .padding()
            
        }.zIndex(3.0)
    }
    
    var SearchBar : some View {
    
        HStack() {
            
            Spacer().frame(width: 10)
            
            Image(systemName: "magnifyingglass")
        
            Divider().frame(height: 20)
        
            TextField("Type product name", text: $SearchText, onEditingChanged:
            { isEditing in
                showCancelButton = true
                }, onCommit: {
                    if(SearchText == ""){
                        ProductObj.isEmptyFiltered = false
                        ProductObj.isSearchActive = false
                        ProductObj.getProduct(product_id: "")
                        
                    }else{
                        ProductObj.search = SearchText
                        ProductObj.searchInList()
                    }
                })
            .simultaneousGesture(TapGesture().onEnded {
                ProductObj.isSearchActive = true
            })
            .frame(width: 405, height: 40)
            .foregroundColor(.primary)
            
            Button(action: {
                
                    SearchText = ""
                    ProductObj.isEmptyFiltered = false
                    ProductObj.isSearchActive = false
                    ProductObj.getProduct(product_id: "")
                
            }) {
                
                Image(systemName: "xmark.circle.fill").opacity( ( SearchText == "" || ProductObj.isLoading ) ? 0 : 1)
                    .padding(.trailing,10)
                
            }
            
        }.frame(alignment : .leading)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke( ( ProductObj.isSearchActive && !ProductObj.isLoading )  ? Color.blue : Color.init(red: 0.5, green: 0.6, blue: 0.8),
                    lineWidth: ( ProductObj.isSearchActive && !ProductObj.isLoading )  ? 4 : 1))
        .background(Color.init(red: 0.5, green: 0.6, blue: 0.8)
            .opacity( ( ProductObj.isSearchActive && !ProductObj.isLoading ) ?  0 : 0.1))
    }
    
    var body: some View {
        VStack(alignment : .leading, spacing : 5 ){
            
            HStack(){
                
                ButtonBack
                Text("Product Page".uppercased())
                    .padding([.vertical, .trailing])
                    .font(.system(size: 30, weight: .heavy , design: .rounded))
                    .frame(height: 50, alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    
                    ProductObj.Products = [Product]()
                    ProductObj.getProduct(product_id: "")
                    ProductObj.sortOrder = ""
                    ProductObj.isSearchActive = false
                    SearchText = ""
                    
                }, label: {
                    
                    ZStack(){
                        
                        HStack(){
                            
                            Image(systemName: "arrow.counterclockwise")
                                .foregroundColor(Color.white)
                            
                            Text("Refresh")
                                .font(.system(size: 17, weight: .bold , design: .rounded))
                                .foregroundColor(Color.white)
                            
                        }.zIndex(2.0)
                        
                        RoundedRectangle(cornerRadius: 10)
                        .frame(width: 110, height: 40)
                        .foregroundColor(Color.blue)
                        
                    }
 
                }).padding(.trailing, 13)
                .frame(width: 130, alignment: .center)
                .zIndex(2.0)
                
                
            }
            
            //Divider()
            
            HStack(){
                
                SearchBar
                ButtonSort
                ButtonScan
                
            }.padding()
            
        }.frame(width: UIScreen.main.bounds.width - 30)
    }
}

struct ProductEmpty : View {
    var TextEmpty : some View {
        VStack(){
            
            Text("A little bit empty here . . .")
                .font(.largeTitle)
            
            Text("Try to search with another keyword")
                .font(.title)
        }
    }
    
    var ImgEmpty : some View {
        Image("sitting-4")
            .resizable()
            .frame(width: 300, height: 300, alignment: .center)
            .cornerRadius(20.0)
    }
    
    var body: some View {
        VStack(){
            
            TextEmpty
            ImgEmpty
            
        }
    }
}

struct CardView : View {
    @State var PID : String = ""
    @State var PName : String = ""
    @State var Price : String = ""
    @State var Category : String = ""
    @State var Stock : String = ""
    @State var FSupplier : String = ""
    @State var LSupplier : String = ""
    @State var ProductImg : String = ""
    @State var DeleteDate : String = ""
    @State var MinStock : String = ""

    @EnvironmentObject var PhotoGet : GetPhoto
    
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var ImgCard : some View {
        ZStack(){
            
            Image(uiImage: ProductImg.loadImage())
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .scaledToFit()
                    .cornerRadius(10.0)
            
            /*if DeleteDate != "-"{
                
                VStack(alignment : .center){
                    
                    Text("Not")
                        .foregroundColor(Color.white)
                        .font(.system(.body, design: .rounded))
                        
                    
                    Text("Available")
                        .foregroundColor(Color.white)
                        .font(.system(.body, design: .rounded))
                        
                }.zIndex(3.0)
                
                RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 50, alignment: .center)
                .foregroundColor(Color.black.opacity(0.5))
                
            }*/
        }
        
        
    }
    
    var stockWarningInfo : some View {
        ZStack(){
            
            HStack(){
                
                Text("Almost empty")
                    .foregroundColor(Color.red)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                //Image(systemName: "xmark.bin.fill")
                //  .foregroundColor(Color.white)
                
            }.zIndex(2.0)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 120, height: 25)
            .foregroundColor(Color.white)


        }.frame(alignment : .leading)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.red, lineWidth: 2))
    }
    
    var notAvalableInfo : some View {
        ZStack(){
            
            HStack(){
                
                Text("NA")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 15, weight: .bold, design: .rounded))

                //Image(systemName: "exclamationmark.triangle.fill")
                    //.foregroundColor(Color.white)
                    //.font(.system(size: 15, weight: .semibold, design: .rounded))
                    //.frame(alignment: .leading)
                
            }.zIndex(2.0)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 35, height: 25)
            .foregroundColor(Color.white)


        }.frame(alignment : .leading)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 2))
    }
    
    var InfoCard : some View {
        VStack(alignment : .leading){
            
            Text(PName.uppercased())
                .foregroundColor(Color.black)
                .font(.system(size: 15, weight: .semibold , design: .rounded))
                .frame(width : 170, height: 60, alignment: .topLeading)
            
            HStack(){
                
                Text(convert(priceString: Price))
                    .foregroundColor(Color.black)
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                Text("·")
                    .foregroundColor(Color.black)
                    .font(.system(size: 15, weight: .heavy, design: .rounded))
                
                Text(Stock + " unit(s)")
                    .foregroundColor( stockWarning() ? Color.red : Color.black )
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                
                    
            }.frame(alignment : .leading)
            
            
            Text(( FSupplier + " " + LSupplier ).capitalized )
                .foregroundColor(Color.black)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .frame(alignment: .leading)
            
            
            Text(Category.capitalized)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .regular, design: .rounded))
                .frame(alignment: .leading)
            
            if stockWarning(){
                
                HStack(){
                    if DeleteDate != "-"{
                        
                        notAvalableInfo
                        
                    }
                    
                    stockWarningInfo
                    
                }.frame(alignment : .leading)
            }
        }
        .frame(alignment : .leading)
    }
    
    var BgCard : some View {
        
        RoundedRectangle(cornerRadius: 10)
        .frame(width: 350, height: 170, alignment: .center)
        .foregroundColor(Color.white)
        //.foregroundColor(DeleteDate == "-" ? Color.white : Color.black.opacity(0.2))
        //.shadow(color: Color.init(.black).opacity(0.2), radius: 5)
        /*.overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.0), lineWidth: 1)
                    .shadow(color: Color.init(.black).opacity(0.2), radius: 5))*/
    
    }
    
    func stockWarning() -> Bool{
        
        let stockInt = (Stock as NSString).intValue
        let mStockInt = (MinStock as NSString).intValue
        
        return stockInt <= mStockInt
    }
    
    func convert(priceString : String) -> String {
        let number = (priceString as NSString).floatValue
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        let priceIDR = formatter.string(from: number as NSNumber)
        
        return priceIDR!
    }
    
    var body : some View {
        ZStack(){
            
            HStack(){
                
                Spacer()
                    .frame(width: 24)
                
                ImgCard
                
                InfoCard
                    .frame(width: 180)
                    .zIndex(1.0)
                
                Spacer()
                
            }.zIndex(1.0)
            
            BgCard
            
        }
    }
}

struct ListProduct : View {
    let colors : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    let columns = [GridItem(.adaptive(minimum: 300))]
    @State var Products = [Product]()
    @State var isPressed : Bool = false
    @State var changeView : Bool = false
    @State var showDetail : Bool = false
    @State var notAvailable : Bool = false
    
    @EnvironmentObject var ProductDelete : DeleteProduct
    @EnvironmentObject var ProductPost : PostProduct
    @EnvironmentObject var ProductEdit : EditProduct
    
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var ProductObj : GetProduct
    
    var LoadingProgress: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .frame(width: 200, height: 100, alignment: .center)
            .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 2)
                    )
            .background(Color.white)
            .cornerRadius(10)
            .zIndex(2.0)
    }
    
    
    var productList : some View {
        VStack(alignment : .leading){
            
            if !ProductObj.isEmptyFiltered || !ProductObj.Products.isEmpty {
                
                HStack(){
                    
                    Text(ProductObj.Products.count.description + " Products")
                        .font(.system(.body, design: .rounded))
                        .foregroundColor(Color.gray)
                        .opacity(ProductObj.isLoading ? 0 : 1)
                    
                    if ProductObj.sortOrder != "" {
                        
                        Text("·")
                            .font(.system(.body, design: .rounded))
                            .foregroundColor(Color.gray)
                            .opacity(ProductObj.isLoading ? 0 : 1)
                        
                        Text("Sorted by : " + ProductObj.sortOrder)
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(Color.gray)
                            .opacity(ProductObj.isLoading ? 0 : 1)
                        
                    }
                    
                }.padding(.leading, 30)
                    
            }
            
            ZStack(){
                
                if ProductObj.isLoading {
                    
                    LoadingProgress
                    
                    
                }
                
                VStack(){
                    
                        ScrollView{
                            
                            LazyVGrid(columns: columns , spacing : 20 ) {
                                
                                ForEach(ProductObj.Products, id: \.Product_ID){ i in
                                    
                                        NavigationLink(destination: ShowDetailProduct()){
                                            
                                            CardView(PID : i.Product_ID,
                                                         PName: i.Product_Name,
                                                         Price: i.Sell_Price,
                                                         Category: i.Category_Name,
                                                         Stock: i.Stock,
                                                         FSupplier: i.FName_Supplier,
                                                         LSupplier: i.LName_Supplier,
                                                         ProductImg: i.Photo,
                                                         DeleteDate: i.Delete_At_Product,
                                                         MinStock : i.Min_Stock ).id(i.Product_ID)
                                                .disabled(ProductObj.isLoading)
                                            
                                            }.simultaneousGesture(TapGesture().onEnded{
                                               ProductObj.tempProd = i
                                               ProductObj.btnBackDetailProductClicked = false
                                               ProductObj.btnEditProductClicked = false
                                               ProductEdit.btnBackEditProductClicked = false
                                               ProductObj.isSearchActive = false
                                               ProductEdit.isSuccess = false
                                            })
                                    }
                                
                            }.padding([.top, .horizontal, .bottom], 20)
                            
                        }
                    
                }.zIndex(2.0)
                .onAppear(){
                    ProductObj.Products = [Product]()
                    ProductObj.getProduct(product_id: "")
                    ProductObj.sortOrder = ""
                    ProductObj.isSearchActive = false
                }
                
                RoundedRectangle(cornerRadius: 10)
                .foregroundColor(Color.init(red: 0.5, green: 0.6, blue: 0.8).opacity(0.1))
                .edgesIgnoringSafeArea(.all)
                .zIndex(1.0)
                
            }
        
        }
        
    }
    
    var body : some View {
        ZStack(){
            
            if ProductObj.isEmptyFiltered {
                
                productList
                    .opacity(0)
                    .disabled(true)
                ProductEmpty()
                
            }else{
                
                productList
            }
        }
    }
}

extension String {
    func loadImage() -> UIImage{
        do{
            guard let url = URL(string: self) else {
                    return UIImage()
        }
                
        let data: Data = try
            Data(contentsOf: url)
                
            return UIImage(data: data) ?? UIImage()
            
        }catch{
            
            print("error")
        }
        return UIImage()
    }
}


struct ProductPage_Previews: PreviewProvider {
    static var previews: some View {
        ProductPage().environmentObject(UserAuth())
    }
}
