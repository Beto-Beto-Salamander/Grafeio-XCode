//
//  ProductDetailPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 27/11/20.
//

import SwiftUI
import Combine

struct EditProductPage: View {
    let Products : Product?
    @EnvironmentObject var ProductEdit : EditProduct
    @EnvironmentObject var ProductObj : GetProduct
    @EnvironmentObject var AuthUser: UserAuth
    
    var body: some View {
        if ProductEdit.btnBackEditProductClicked{
            return AnyView(ShowDetailProduct()
            .navigationBarHidden(true))
            
        }else if ProductEdit.isSuccess{
            return AnyView(ProductPage()
            .navigationBarHidden(true))
            
        }else{
            return AnyView(EditViewProduct(Products: ProductObj.tempProd)
            .padding(.top, 10)
            .navigationBarHidden(true))
            
        }
    }
}

struct EditViewProduct : View {
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var ProductEdit: EditProduct
    @EnvironmentObject var ProductObj: GetProduct
    @EnvironmentObject var CategoryObj : GetCategory
    @EnvironmentObject var SupplierObj : GetSupplier
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
    @State var isShowPickerCategory : Bool = false
    @State var isShowPickerSupplier : Bool = false
    @State var isShowResult : Bool = false
    @State var isNothingChanges : Bool = false
    
    @State var showingImagePicker : Bool = false
    
    @State var SelectedCategory : String = ""
    @State var SelectedSupplier : String = ""
    
    
   
    @State var Finish : Bool = false
    
    let Products : Product?
    
    func initText(){
        DispatchQueue.main.async {
            Pname = ProductObj.tempProd!.Product_Name
            CategoryName = ProductObj.tempProd!.Category_Name
            SupplierName = ProductObj.tempProd!.FName_Supplier + ProductObj.tempProd!.LName_Supplier
            BuyPrice = ProductObj.tempProd!.Buy_Price
            SellPrice = ProductObj.tempProd!.Sell_Price
            Stock = ProductObj.tempProd!.Stock
            MinStock = ProductObj.tempProd!.Min_Stock
            ProductDescription = ProductObj.tempProd!.Product_Description
            CategoryObj.tempCategory = nil
            SupplierObj.tempSupplier = nil
            CategoryObj.getCategory2(category_id: ProductObj.tempProd!.Category_ID)
            SupplierObj.getSupplier2(supplier_id: ProductObj.tempProd!.Supplier_ID)
        }
        
    }
    
    var ButtonBack : some View {
        Button(action : {
            
            ProductObj.btnEditProductClicked = false
            ProductEdit.btnBackEditProductClicked = true
            ProductObj.isSearchActive = false
            
        }){
            Image(systemName: "control")
                .foregroundColor(Color.blue)
                .rotationEffect(Angle.init(degrees: -90))
                .scaleEffect(2)
                .padding()
        }.disabled(isShowAlert())
    }
    
    var HeaderEdit : some View {
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
                            
                            let fname = ProductObj.tempProd?.FName_Supplier ?? ""
                            let lname = ProductObj.tempProd?.LName_Supplier ?? ""
                            self.SupplierName = fname + " " + lname
                            
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
                    .foregroundColor(.blue)
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
                    .scaledToFit()
                    .cornerRadius(10)
            }else{
                Image(uiImage: Products!.Photo.loadImage())
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
                    .cornerRadius(10)
                
            }
        }
        
    }
    
    var BtnPostProduct : some View {
        Button(action : {
           
            falseAllPicker()
            
            falseAllTextField()
            
            BtnSubmitPresssed = true
            
        }){
            HStack(){
                
                Image(systemName: "checkmark.circle")
                
                Text("Submit")
                    .padding()
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    
            }.foregroundColor(.white)
            .frame(width: 150, height: 45, alignment: .center)
            .background(Color.blue)
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
                    .frame(width: 130, height: 45, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .zIndex(2.0)
                    
                    Divider().frame(height: 35)
                    
                    Button(action: {
                        
                        falseAllPicker()
                        
                    }, label: {
                        Text("Cancel")
                    }).font(.system(size: 17, weight: .regular, design: .rounded))
                    .frame(width: 130, alignment: .center)
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
                    .frame(width: 130, alignment: .center)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                    .zIndex(2.0)
                    
                    Divider().frame(height: 35)
                    
                    Button(action: {
                        falseAllPicker()
                    }, label: {
                        Text("Cancel")
                    }).font(.system(size: 17, weight: .regular, design: .rounded))
                    .frame(width: 130, alignment: .center)
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
            
            Image(systemName: ProductEdit.isSuccess ? "checkmark.circle" : "exclamationmark.triangle")
                .foregroundColor(ProductEdit.isSuccess ? .green : .red)
            
            Text(ProductEdit.isSuccess ? "Success".uppercased() : "Failed".uppercased())
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 240, height: 45, alignment: .center)
                    .foregroundColor(ProductEdit.isSuccess ? .green : .red)
            
            if !ProductEdit.isSuccess {
                Text(ProductEdit.errorMessage)
                    .font(.system(.body, design: .rounded))
                    .frame(width: 240, height: 45, alignment: .center)
                    .foregroundColor(.red)
            }
            
            Divider()
        
            Button(action: {
                
                if ProductEdit.isSuccess{
                    ProductEdit.isFinish = true
                    Finish = true
                    
                }else{
                    ProductEdit.isFinish = false
                }
                isShowResult = false
                
            }, label: {
                Text("Close")
            }).font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(height: 45, alignment: .center)
                .foregroundColor(.blue)
                .zIndex(2.0)
            
        }.frame(width: 300, height: ProductEdit.isSuccess ? 160 : 200, alignment: .center)
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
    
    var sameAlert : some View {
        VStack(){
            
            Text("Nothing changes")
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(width: 240, height: 45, alignment: .center)
                .foregroundColor(Color.red)
            
                Divider()
            
                Button(action: {
                    
                    isNothingChanges.toggle()
                    
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
    
    func checkEmpty(){
        
        if (Pname == "" ||
                CategoryName == "" ||
                SupplierName == "" ||
                BuyPrice == "" ||
                SellPrice == "" ||
                Stock == "" ||
                MinStock == "" ||
                ProductDescription == "" ||
                inputImage == nil){
            
            isEmptyField = true
            
        }else{
            
            isEmptyField = false
            
        }
    }
    
    func checkChanges(){
        
        if Pname == ProductObj.tempProd!.Product_Name &&
            CategoryName == ProductObj.tempProd!.Category_Name &&
            SupplierName == ( ProductObj.tempProd!.FName_Supplier + " " + ProductObj.tempProd!.LName_Supplier ) &&
            BuyPrice == ProductObj.tempProd!.Buy_Price &&
            SellPrice == ProductObj.tempProd!.Sell_Price &&
            Stock == ProductObj.tempProd!.Stock &&
            MinStock == ProductObj.tempProd!.Min_Stock &&
            ProductDescription == ProductObj.tempProd!.Product_Description &&
            inputImage == nil {
            
            isNothingChanges = true
            
        }else{
            
            isNothingChanges = false
        }
        
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
    
    func isShowAlert() -> Bool{
        return isShowResult||isEmptyField||isShowPickerSupplier||isShowPickerCategory||isNothingChanges
    }

    var body : some View {
        ZStack(){
            
            VStack{
        
                HeaderEdit
                
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
                        
                        checkEmpty()
                        
                        if isEmptyField {
                            
                        }else{
                            
                            checkChanges()
                            
                            if isNothingChanges{
                                
                                
                                
                            }
                            
                            else{
                                
                                if inputImage == nil {
                                    
                                    inputImage = ProductObj.tempProd!.Photo.loadImage()
                                    
                                }
                                
                                ProductEdit.Product_ID = ProductObj.tempProd!.Product_ID
                                
                                ProductEdit.editProduct(pname: Pname,
                                                             catid: CategoryObj.tempCategory!.Category_ID,
                                                             supid: SupplierObj.tempSupplier!.Supplier_ID,
                                                             buyp: BuyPrice,
                                                             sellp: SellPrice,
                                                             stock: Stock,
                                                             mstock: MinStock,
                                                             empid: AuthUser.EmployeeID,
                                                             desc: ProductDescription,
                                                             img : inputImage!
                                                            )
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isShowResult.toggle()
                                }
                                
                            }
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
                    .scaleEffect()
                    .transition(.opacity)
                    .animation(.easeOut)
                    
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
            
            if isNothingChanges {
                
                sameAlert
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
                
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage){
            ImagePicker(image: self.$inputImage)
        }
    }
}

/*struct EditProductPage_Previews: PreviewProvider {
    static var previews: some View {
        EditProductPage()
    }
}*/
