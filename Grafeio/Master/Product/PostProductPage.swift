//
//  PostProductPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 28/11/20.
//

import SwiftUI
import Combine
struct PostProductPage: View {
    @EnvironmentObject var ProductPost: PostProduct
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var ProductObj : GetProduct
    
    @State var Finish : Bool = false
    
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
        if ProductObj.btnBackPostProductClicked{
            return AnyView(ProductPage()
            .navigationBarHidden(true))
        }else{
            return AnyView(PostViewProduct()
            .padding(.top, 10)
            .navigationBarHidden(true))
        }
        
    }
}

struct PostViewProduct : View {
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var ProductPost: PostProduct
    @EnvironmentObject var CategoryObj : GetCategory
    @EnvironmentObject var SupplierObj : GetSupplier
    @EnvironmentObject var ProductObj : GetProduct
    @EnvironmentObject var PhotoPost : PostPhoto
    
    @State var BtnSubmitPresssed : Bool = false
    @State var PID : String = ""
    @State var Pname : String = ""
    @State var CategoryName : String = ""
    @State var CategoryID : String = ""
    @State var SupplierName : String = ""
    @State var SupplierID : String = ""
    @State var BuyPrice : String = ""
    @State var SellPrice : String = ""
    @State var Stock : String = ""
    @State var MinStock : String = ""
    @State var ProductDescription : String = ""
    @State var image : Image?
    @State var inputImage: UIImage?
    
    @State var isActivePName : Bool = false
    @State var isActiveCName : Bool = false
    @State var isActiveSName : Bool = false
    @State var isActiveBPrice : Bool = false
    @State var isActiveSPrice : Bool = false
    @State var isActiveStock : Bool = false
    @State var isActiveMStock : Bool = false
    @State var isActivePDesc : Bool = false
    
    @State var isEmptyField : Bool = false
    
    @State var showingImagePicker : Bool = false
    
    @State var SelectedCategory : String = ""
    @State var isShowPickerCategory : Bool = false
    
    @State var SelectedSupplier : String = ""
    @State var isShowPickerSupplier : Bool = false
    
    @State var isShowResult : Bool = false
    @State var Finish : Bool = false
    
    var ButtonBack : some View {
        Button(action : {
            ProductObj.btnBackPostProductClicked = true
            ProductObj.isSearchActive = false
        }){
            Image(systemName: "control")
                .foregroundColor(Color.blue)
                .rotationEffect(Angle.init(degrees: -90))
                .scaleEffect(2)
                .padding()
        }.disabled(isShowAlert())
    }
    
    var HeaderPost : some View {
        HStack(){
            
            ButtonBack
            
            Text("Form Product".uppercased())
                .padding()
                .font(.system(size: 30, weight: .heavy , design: .rounded))
                .frame(width: 300, height: 50, alignment: .leading)
                .foregroundColor(Color.black)
            
            Spacer().frame(width: 90)
            
            BtnPostProduct
            
        }.padding(.bottom, 10)
        
    }
    
    var PNameTextF : some View {
        VStack(alignment: .leading){
            Text("Product Name")
                .font(.system( .body , design: .rounded))
                
            HStack {
                Image(systemName: "abc").foregroundColor(isActivePName ? Color.blue : Color.gray)
                
                Divider()
                    .frame(height : 17)
                
                TextField("Enter product name",text : self.$Pname)
                    .disabled(isShowAlert())
                    .simultaneousGesture(TapGesture().onEnded {
                        falseAllPicker()
                        falseAllTextField()
                        isActivePName.toggle()
                    })
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActivePName ? Color.blue : Color.gray, lineWidth: 1))
        }
    }

    var CNameTextF : some View {
        VStack(alignment: .leading){
            
            Text("Category Name")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
              Image(systemName: "rectangle.3.offgrid.fill").foregroundColor(isActiveCName ? Color.blue : Color.gray)
                
              Divider()
                .frame(height : 17)
                
              TextField("Pick category for this product",
                          text : self.$CategoryName)
                    .disabled(true)
                    .onReceive(CategoryObj.$tempCategory, perform: { Cat in
                        self.CategoryName = Cat?.Category_Name ?? ""
                    })
                
                Button(action : {
                    SupplierObj.Suppliers.removeAll()
                    CategoryObj.Categories.removeAll()
                    
                    SupplierObj.getSupplier()
                    CategoryObj.getCategory()
                    
                    falseAllPicker()
                    falseAllTextField()
                    
                    isShowPickerCategory.toggle()
                   
                    isActiveCName.toggle()
                    
                }){
                    Text("Select")
                        .font(.system(size: 17, weight: .bold))
                }.disabled(isShowAlert())
                
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActiveCName ? Color.blue : Color.gray, lineWidth: 1))
        }
    
    }
    
    var SNameTextF : some View {
        VStack(alignment: .leading){
            
            Text("Supplier Name")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
                Image(systemName: "shippingbox.fill").foregroundColor(isActiveSName ? .blue : .gray)
                
                Divider()
                    .frame(height : 17)
                
                TextField("Pick supplier for this product",
                          text : self.$SupplierName)
                    .disabled(true)
                    .onReceive(SupplierObj.$tempSupplier, perform: { Sup in
                        if SelectedSupplier.isEmpty{
                            self.SupplierName = ""
                        }else{
                            let fname = Sup?.FName_Supplier ?? ""
                            let lname = Sup?.LName_Supplier ?? ""
                            self.SupplierName = fname + " " + lname
                        }
                })
                
                Button(action : {
                    SupplierObj.Suppliers.removeAll()
                    CategoryObj.Categories.removeAll()
                    
                    SupplierObj.getSupplier()
                    CategoryObj.getCategory()
                    
                    falseAllPicker()
                    falseAllTextField()
                    
                    isShowPickerSupplier.toggle()
                    
                    isActiveSName.toggle()
                    
                }){
                    Text("Select")
                        .font(.system(size: 17, weight: .bold))
                }.disabled(isShowAlert())
                
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActiveSName ? Color.blue : Color.gray, lineWidth: 1))
        }
    }
    
    var BPriceTextF : some View {
        VStack(alignment: .leading){
            
            Text("Buy Price")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
              Image(systemName: "tag.fill").foregroundColor(isActiveBPrice ? Color.blue : Color.gray)
                
              Divider()
                .frame(height : 17)
                
              TextField("Enter buy price", text : self.$BuyPrice)
                .disabled(isShowAlert())
                .onReceive(Just(BuyPrice)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.BuyPrice = filtered
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    falseAllPicker()
                    
                    falseAllTextField()
                    
                    isActiveBPrice.toggle()
                })
                
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActiveBPrice ? Color.blue : Color.gray, lineWidth: 1))
        }
    }
    
    var SPriceTextF : some View {
        VStack(alignment: .leading){
            
            Text("Sell Price")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
              Image(systemName: "tag.fill").foregroundColor(isActiveSPrice ? Color.blue : Color.gray)
                
              Divider()
                .frame(height : 17)
                
              TextField("Enter sell price", text : self.$SellPrice)
                .disabled(isShowAlert())
                .onReceive(Just(SellPrice)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.SellPrice = filtered
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    falseAllPicker()
                    
                    falseAllTextField()
                    
                    isActiveSPrice.toggle()
                })
                
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActiveSPrice ? Color.blue : Color.gray, lineWidth: 1))
        }
    }
    
    var StockTextF : some View {
        VStack(alignment: .leading){
            
            Text("Stock")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
              Image(systemName: "cube.fill").foregroundColor(isActiveStock ? Color.blue : Color.gray)
                
              Divider()
                .frame(height : 17)
                
              TextField("Enter product stock", text : self.$Stock)
                .disabled(isShowAlert())
                .onReceive(Just(Stock)) { newValue in
                    let filtered = newValue.filter { "0123456789".contains($0) }
                    if filtered != newValue {
                        self.Stock = filtered
                    }
                }
                .simultaneousGesture(TapGesture().onEnded {
                    falseAllPicker()
                    
                    falseAllTextField()
                    
                    isActiveStock.toggle()
                })
                
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActiveStock ? Color.blue : Color.gray, lineWidth: 1))
        }
    }
    
    var MStockTextF : some View {
        VStack(alignment: .leading){
            
            Text("Minimal Stock")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
              Image(systemName: "cube.fill").foregroundColor(isActiveMStock ? Color.blue : Color.gray)
                
              Divider()
                .frame(height : 17)
                
              TextField("Enter product minimal stock", text : self.$MinStock)
                .disabled(isShowAlert())
                .onReceive(Just(MinStock)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.MinStock = filtered
                                }
                        }
                .simultaneousGesture(TapGesture().onEnded {
                    falseAllPicker()
                    
                    falseAllTextField()
                    
                    isActiveMStock.toggle()
                })
            }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActiveMStock ? Color.blue : Color.gray, lineWidth: 1))
        }
    }
    
    var BtnSelectImage : some View {
        Button(action : {
            
            showingImagePicker.toggle()
            
            falseAllPicker()
            
            falseAllTextField()
            
        }){
                Text("Select image")
                    .padding()
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .foregroundColor(isShowAlert() ? Color.black.opacity(0.2) : Color.blue)
        }
    }
    
    var imgView : some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.secondary)
                .frame(width: 200, height: 200)
            
            if image != nil {
                image?
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(10)
            
                if isShowAlert(){
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.secondary)
                        .frame(width: 200, height: 200)
                    
                }
            
            }else{
                Text("No picture yet")
                    .foregroundColor(.white)
            }
        }
        
    }
    
    var BtnPostProduct : some View {
        Button(action : {
            
            falseAllPicker()
            
            falseAllTextField()
            
            if (Pname == "" ||
                    CategoryName == "" ||
                    SupplierName == "" ||
                    BuyPrice == "" ||
                    SellPrice == "" ||
                    Stock == "" ||
                    MinStock == "" ||
                    ProductDescription == ""){
                
                isEmptyField.toggle()
                
            }else{
                BtnSubmitPresssed.toggle()
                
            }
        }){
            HStack(){
                
                Image(systemName: "checkmark.circle")
                
                Text("Submit")
                    .padding()
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    
            }.foregroundColor(.white)
            .frame(width: 150, height: 45, alignment: .center)
            .background(isShowAlert() ? Color.black.opacity(0.2) : Color.blue)
            .cornerRadius(10)
            
        }.disabled(isShowAlert())
    }
    
    var DescTextF : some View {
        VStack(alignment : .leading){
            
            Text("Description")
                .font(.system( .body , design: .rounded))
            
            HStack {
                
              Image(systemName: "doc.plaintext.fill").foregroundColor(isActivePDesc ? Color.blue : Color.gray)
                
              Divider()
                .frame(height : 17)
                
              TextField("Describe the product", text: $ProductDescription)
                .disabled(isShowAlert())
                .simultaneousGesture(TapGesture().onEnded {
                    falseAllPicker()
                    
                    falseAllTextField()
                    
                    isActivePDesc.toggle()
                })
              }
            .padding()
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(isActivePDesc ? Color.blue : Color.gray, lineWidth: 1))
        }
    }
    
    var pickerSupplier : some View {
        VStack(){
            
                Text("Select supplier :")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 150, height: 45, alignment: .center)
                    .foregroundColor(.black)
            
                Divider()
            
                Picker(selection: $SelectedSupplier, label:
                    Text("Pick one:")
                    , content: {
                        ForEach(SupplierObj.Suppliers, id: \.Supplier_ID) { Sup in
                            Text(Sup.FName_Supplier + " " + Sup.LName_Supplier)
                        }
                    }).frame(width: 200, height: 150, alignment: .center)
                    .padding()
                
                Divider()
            
                HStack(alignment : .center){
                
                    Button(action: {
                        
                        SupplierObj.getSupplier2(supplier_id: SelectedSupplier)
                        falseAllPicker()
                        
                    }, label: {
                        Text("Done")
                    }).font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 150, height: 45, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .zIndex(2.0)
                    
                    Divider().frame(height: 35)
                    
                    Button(action: {
                        
                        falseAllPicker()
                        
                    }, label: {
                        Text("Cancel")
                    }).font(.system(size: 17, weight: .regular, design: .rounded))
                    .frame(width: 140, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .zIndex(2.0)
                }
            
        }.frame(width: 300, height: 330, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .zIndex(2.0)
        
    }
    
    var pickerCategory : some View {
        VStack(){
            
                Text("Select Category")
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 150, height: 45, alignment: .center)
                    .foregroundColor(.black)
            
                Divider()
            
                Picker(selection: $SelectedCategory, label:
                    Text("Select Category")
                    , content: {
                        ForEach(CategoryObj.Categories, id: \.Category_ID) { Cat in
                            Text(Cat.Category_Name)
                        }
                    }).frame(width: 200, height: 150, alignment: .center)
                    .padding()
                
                Divider()
                
                HStack(alignment : .center){
                    
                    Button(action: {
                        CategoryObj.getCategory2(category_id: SelectedCategory)
                        falseAllPicker()
                    }, label: {
                        Text("Done")
                    }).font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 140, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .zIndex(2.0)
                    
                    Divider().frame(height: 35)
                    
                    Button(action: {
                        falseAllPicker()
                    }, label: {
                        Text("Cancel")
                    }).font(.system(size: 17, weight: .regular, design: .rounded))
                    .frame(width: 140, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .zIndex(2.0)
                }
            
        }
            .frame(width: 300, height: 330, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .zIndex(2.0)
    }
    
    var resultAlert : some View {
        VStack(){
            
            Image(systemName: ProductPost.isSuccess ? "checkmark.circle" : "exclamationmark.triangle")
                .foregroundColor(ProductPost.isSuccess ? .green : .red)
            
            Text(ProductPost.isSuccess ? "Success".uppercased() : "Failed".uppercased())
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 240, height: 45, alignment: .center)
                    .foregroundColor(ProductPost.isSuccess ? .green : .red)
            
            if !ProductPost.isSuccess {
                Text(ProductPost.errorMessage)
                    .font(.system(.body, design: .rounded))
                    .frame(width: 240, height: 45, alignment: .center)
                    .foregroundColor(.red)
            }
            
            Divider()
        
            Button(action: {
                if ProductPost.isSuccess{
                    ProductPost.isFinish = true
                    Finish = true
                }else{
                    ProductPost.isFinish = false
                }
                isShowResult = false
            }, label: {
                Text("Close")
            }).font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(width: 150, height: 45, alignment: .center)
                .foregroundColor(.blue)
                .zIndex(2.0)
            
        }.frame(width: 300, height: ProductPost.isSuccess ? 160 : 190, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .zIndex(2.0)
    }
    
    var emptyAlert : some View {
        VStack(){
            
            Text("Don't leave blank field(s)")
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(width: 240, height: 45, alignment: .center)
                .foregroundColor(Color.red)
            
                Divider()
            
                Button(action: {
                    isEmptyField.toggle()
                }, label: {
                    Text("Close")
                }).font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 150, height: 45, alignment: .center)
                    .foregroundColor(.blue)
                    .zIndex(2.0)
            
        }.frame(width: 300, height: 120, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .zIndex(2.0)
        
        
    }
    
    func falseAllPicker(){
        isShowPickerSupplier = false
        isShowPickerCategory = false
        
    }
    
    func falseAllTextField(){
        isActivePName = false
        isActiveCName  = false
        isActiveSName = false
        isActiveBPrice  = false
        isActiveSPrice  = false
        isActiveStock  = false
        isActiveMStock = false
        isActivePDesc  = false
    }
    
    func convert(priceString : String) -> String {
        let number = (priceString as NSString).floatValue
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        let priceIDR = formatter.string(from: number as NSNumber)
        
        return priceIDR!
        
    }
    
    func loadImage(){
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
    func uploadImage(){
        let imageData : Data = inputImage?.jpegData(compressionQuality: 0.1) ?? Data()
        let imageStr : String = imageData.base64EncodedString()
        
        guard let url: URL = URL(string: "http://localhost/PPTA/index.php/PRODUCTPHOTO") else {
            return
        }
        
        let paramStr : String = "image=\(imageStr)"
        let paramData : Data = paramStr.data(using: .utf8) ?? Data()
        
        var urlRequest : URLRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = paramData
        
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest, completionHandler: {(data, response, error) in
            guard let data = data else{
                print("invalid data")
                return
            }
            let responseStr : String = String(data: data, encoding: .utf8) ?? ""
            print(responseStr)
        })
    }
    
    func initText(){
        DispatchQueue.main.async {
            Pname  = ""
            CategoryName  = ""
            CategoryID = ""
            SupplierName  = ""
            SupplierID = ""
            BuyPrice  = ""
            SellPrice =  ""
            Stock = ""
            MinStock = ""
            ProductDescription = ""
            image = nil
            SupplierObj.tempSupplier = nil
            CategoryObj.tempCategory = nil
        }
    }
    
    func isShowAlert() -> Bool{
        return isShowResult||isEmptyField||isShowPickerSupplier||isShowPickerCategory
    }

    var body : some View {
        
        ZStack(){
            
            VStack{
        
                HeaderPost
                
                Divider().frame(width: UIScreen.main.bounds.width - 100)
                
                PNameTextF
                    .frame(width: 600, alignment: .leading)
                    
                CNameTextF
                    .frame(width: 600, alignment: .leading)
                   
                SNameTextF
                    .frame(width: 600, alignment: .leading)
                    
                HStack(){
                    BPriceTextF
                    SPriceTextF
                }.frame(width: 600, alignment: .leading)
                
                HStack(){
                    StockTextF
                    MStockTextF
                }.frame(width: 600, alignment: .leading)
                
                DescTextF
                    .frame(width: 600, alignment: .leading)
                
                HStack(){
                    
                    VStack(){
                        BtnSelectImage
                        imgView
                    }
                    
                    Spacer()
                        
                }.frame(width: 600, alignment: .trailing)
                .onAppear(perform: {
                    initText()
                })
                
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white, lineWidth: 1)
            .background(isShowAlert() ? Color.black : Color.clear)
            .opacity(isShowAlert() ? 0.2 : 0)
                .edgesIgnoringSafeArea(.all))
            .zIndex(2.0)

            .alert(isPresented: $BtnSubmitPresssed) {
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        
                        ProductPost.postProduct(pname: self.Pname,
                                                     catid: self.CategoryObj.tempCategory!.Category_ID,
                                                     supid: self.SupplierObj.tempSupplier!.Supplier_ID,
                                                     buyp: self.BuyPrice,
                                                     sellp: self.SellPrice,
                                                     stock: self.Stock,
                                                     mstock: self.MinStock,
                                                     pdesc: self.ProductDescription,
                                                     empid: self.AuthUser.EmployeeID,
                                                     img : self.inputImage!
                                                    )
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isShowResult.toggle()
                        }
                    }
                    let secondaryButton = Alert.Button.destructive(Text("No")) {
                       
                    }
                    return Alert(title: Text("Submit ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            .foregroundColor(Color.init(red: 0.5, green: 0.6, blue: 0.8).opacity(0.1))
            .edgesIgnoringSafeArea(.all)
            .zIndex(1.0)
                
            RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width - 100,
                   height: UIScreen.main.bounds.height - 100)
            .foregroundColor(Color.white)
            .cornerRadius(10)
            .zIndex(1.0)
            
            .disabled(isShowAlert())
            
            if isShowPickerCategory {
                
                pickerCategory
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)

            }
            if isShowPickerSupplier {
                
                pickerSupplier
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
                
            }
            if isShowResult {
                
                resultAlert
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
                
            }
            if isEmptyField {
                
                 emptyAlert
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
        
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

struct PostProductPage_Previews: PreviewProvider {
    static var previews: some View {
        PostProductPage()
    }
}
