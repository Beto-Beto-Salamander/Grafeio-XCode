//
//  ShowDetailProduct.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import SwiftUI
import Combine

struct ShowDetailProduct: View {
    @EnvironmentObject var ProductObj : GetProduct
    @EnvironmentObject var ProductEdit : EditProduct
    
    var body: some View {
        if ProductObj.btnBackDetailProductClicked{
            return AnyView(ProductPage()
            .navigationBarHidden(true))
            
        }else if ProductObj.btnEditProductClicked{
            return AnyView(EditProductPage(Products: ProductObj.tempProd)
            .navigationBarHidden(true))
            
        }else{
            return AnyView(DetailProduct()
            .padding(.top, 10)
            .navigationBarHidden(true))
            
        }
    }
}

struct DetailProduct : View {
    @State var btnEditClicked : Bool = false
    @State var btnDeleteClicked : Bool = false
    @State var btnRestoreClicked : Bool = false
    @State var isShowResult : Bool = false
    @State var isFinish : Bool = false
    
    @EnvironmentObject var ProductObj : GetProduct
    @EnvironmentObject var ProductDelete : DeleteProduct
    @EnvironmentObject var ProductEdit : EditProduct
    @EnvironmentObject var ProductGet : GetProduct
    @EnvironmentObject var AuthUser : UserAuth
    
    var buttonBack : some View {
        Button(action : {
            ProductObj.btnBackDetailProductClicked = true
            ProductObj.isSearchActive = false
        }){
            Image(systemName: "control")
                .foregroundColor(.blue)
                .rotationEffect(Angle.init(degrees: -90))
                .scaleEffect(2)
                .padding()
        }.disabled( isShowResult || btnRestoreClicked )
    }
    
    var cardTitle : some View {
        Text("Product Detail".uppercased())
            .padding([.vertical, .trailing])
            .font(.system(size: 30, weight: .heavy , design: .rounded))
            .frame(width : 300,alignment: .leading)
            .foregroundColor(.black)
    }
    
    var btnEdit : some View {
        Button(action : {
            
            ProductObj.btnEditProductClicked.toggle()
            ProductEdit.btnBackEditProductClicked = false
            
        }){
            ZStack(){
                
                HStack(){
                    
                    Image(systemName: "pencil.circle.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Edit")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .frame(alignment: .leading)
                    
                }.zIndex(2.0)
                
                RoundedRectangle(cornerRadius: 10)
                .frame(width: 100, height: 35)
                .foregroundColor(Color.blue)
                
            }.frame(alignment : .leading)
            
        }.disabled(isShowResult || btnRestoreClicked)
    }
    
    var btnDelete : some View {
        Button(action : {
            
            btnDeleteClicked.toggle()
            
        }){
            ZStack(){
                
                HStack(){
                    
                    Image(systemName: "trash.circle.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Delete")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .frame(alignment: .leading)
                    
                }.zIndex(2.0)
                
                RoundedRectangle(cornerRadius: 10)
                .frame(width: 110, height: 35)
                .foregroundColor(Color.red)
                
            }.frame(alignment : .leading)
            
        }.disabled(isShowResult || btnRestoreClicked)
    }
    
    var btnRestore : some View {
        Button(action : {
            
            btnRestoreClicked = true
            
        }){
            ZStack(){
                
                HStack(){
                    
                    Image(systemName: "arrow.counterclockwise.circle.fill")
                        .foregroundColor(Color.white)
                    
                    Text("Restore")
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .frame(alignment: .leading)
                    
                }.zIndex(2.0)
                
                RoundedRectangle(cornerRadius: 10)
                .frame(width: 120, height: 35)
                .foregroundColor(Color.green)
                
            }.frame(alignment : .leading)
            
        }.disabled(isShowResult || btnRestoreClicked)
    }
    
    var stockWarningInfo : some View {
        ZStack(){
            
            HStack(){
                
                Image(systemName: "xmark.bin.fill")
                    .foregroundColor(Color.red)
                
                Text("Almost empty")
                    .foregroundColor(Color.red)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(alignment: .leading)
                
            }.zIndex(2.0)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 180, height: 30)
            .foregroundColor(Color.white)


        }.frame(alignment : .leading)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.red, lineWidth: 2))
    }
    
    var notAvalableInfo : some View {
        ZStack(){
            
            HStack(){
                
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(Color.gray)
                
                Text("Not Available")
                    .foregroundColor(Color.gray)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .frame(alignment: .leading)
                
            }.zIndex(2.0)
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: 170, height: 30)
            .foregroundColor(Color.white)


        }.frame(alignment : .leading)
        .overlay(RoundedRectangle(cornerRadius: 10)
        .stroke(Color.gray, lineWidth: 2))
    }
    
    var leftContent : some View {
        VStack(alignment : .leading){
            
            Group{
                
                Text("Product Name")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Category")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Supplier").font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Buy Price").font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Sell Price").font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Stock").font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(stockWarning() ? Color.red : Color.black)
                
                Text("Min Stock").font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Product Description").font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Added at").font(.system(size: 20, weight: .bold, design: .rounded))
            }
            Group {
                Text("Updated at").font(.system(size: 20, weight: .bold, design: .rounded))
                
                Text("Deleted at").font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(ProductObj.tempProd!.Delete_At_Product != "-" ? Color.gray : Color.black)
                
                Text("Last modified by").font(.system(size: 20, weight: .bold, design: .rounded))
            }
        }
    }
    
    var rightContent : some View {
        
        VStack(alignment : .leading){
            
            Group{
                
                Text(ProductObj.tempProd!.Product_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(ProductObj.tempProd!.Category_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(self.concatSupp()).font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(convert(priceString: ProductObj.tempProd!.Buy_Price)).font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(convert(priceString: ProductObj.tempProd!.Sell_Price)).font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(ProductObj.tempProd!.Stock).font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(stockWarning() ? Color.red : Color.black)

                Text(ProductObj.tempProd!.Min_Stock).font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(ProductObj.tempProd!.Product_Description).font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(ProductObj.tempProd!.Create_At_Product).font(.system(size: 20, weight: .regular, design: .rounded))
                
            }.frame(alignment : .leading)
            
            Group {
                
                Text(ProductObj.tempProd!.Update_At_Product).font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(ProductObj.tempProd!.Delete_At_Product).font(.system(size: 20, weight: .regular, design: .rounded))
                    .foregroundColor(ProductObj.tempProd!.Delete_At_Product != "-" ? Color.gray : Color.black)
                
                Text(self.concatEmp()).font(.system(size: 20, weight: .regular, design: .rounded))
                
            }
        }
    }
    
    var imgProduct : some View {
        ZStack(){
            
            Image(uiImage : ProductObj.tempProd!.Photo.loadImage())
                .resizable()
                .frame(width: 500, height: 400)
                .scaledToFit()
                .cornerRadius(10)
            
            /*if ProductObj.tempProd!.Delete_At_Product != "-"{
                
                VStack(alignment : .center){
                    
                    Text("Not")
                        .foregroundColor(Color.white)
                        .font(.system(.title, design: .rounded))
                        
                    
                    Text("Available")
                        .foregroundColor(Color.white)
                        .font(.system(.title, design: .rounded))
                        
                }.zIndex(3.0)
                
                RoundedRectangle(cornerRadius: 10)
                .frame(width: 150, height: 70, alignment: .center)
                .foregroundColor(Color.black.opacity(0.5))
                
            }*/
        }
    }
    
    var restoreAlert : some View {
        VStack(){
            
            Text("Restore this product ? ")
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(width: 240, height: 45, alignment: .center)
                .foregroundColor(Color.black)
            
            Divider()
        
            HStack(alignment : .center){
            
                Button(action: {
                
                    ProductEdit.Product_ID = ProductObj.tempProd!.Product_ID
                
                    ProductEdit.restoreProduct(pname: ProductObj.tempProd!.Product_Name,
                                             catid: ProductObj.tempProd!.Category_ID,
                                             supid: ProductObj.tempProd!.Supplier_ID,
                                             buyp: ProductObj.tempProd!.Buy_Price,
                                             sellp: ProductObj.tempProd!.Sell_Price,
                                             stock: ProductObj.tempProd!.Stock,
                                             mstock: ProductObj.tempProd!.Min_Stock,
                                             empid: AuthUser.EmployeeID,
                                             desc: ProductObj.tempProd!.Product_Description,
                                             img: ProductObj.tempProd!.Photo.loadImage()
                                            )
                    
                    btnRestoreClicked = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        isShowResult = true
                    }
                    
                }, label: {
                    Text("Yes")
                }).font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(width: 130, height: 45, alignment: .center)
                .foregroundColor(.blue)
                .cornerRadius(10)
                .zIndex(2.0)
                
                Divider().frame(height: 35)
                
                Button(action: {
                    
                    btnRestoreClicked = false
                    
                }, label: {
                    Text("No")
                }).font(.system(size: 17, weight: .regular, design: .rounded))
                .frame(width: 130, alignment: .center)
                .foregroundColor(Color.red)
                .cornerRadius(10)
                .zIndex(2.0)
            }
            
        }.frame(width: 300, height: 120, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .zIndex(3.0)
    }
    
    var resultAlert : some View {
        VStack(){
            
            Image(systemName: ProductDelete.isSuccess || ProductEdit.isSuccessRestore ? "checkmark.circle" : "exclamationmark.triangle")
                .foregroundColor(ProductDelete.isSuccess || ProductEdit.isSuccessRestore ? .green : .red)
            
            Text(ProductDelete.isSuccess || ProductEdit.isSuccessRestore ? "Success".uppercased() : "Failed".uppercased())
                    .font(.system(size: 17, weight: .bold, design: .rounded))
                    .frame(width: 240, height: 45, alignment: .center)
                    .foregroundColor(ProductDelete.isSuccess || ProductEdit.isSuccessRestore ? .green : .red)
            
            
            Divider()
        
            Button(action: {
                if ProductDelete.isSuccess {
                    
                    ProductDelete.isFinish = true
                    isFinish = true
                    ProductObj.btnBackDetailProductClicked = true
                    
                }else if ProductEdit.isSuccessRestore{
                    
                    isFinish = true
                    ProductObj.btnBackDetailProductClicked = true
                    
                }else{
                    
                    ProductDelete.isFinish = false
                    
                }
                isShowResult = false
            }, label: {
                Text("Close")
            }).font(.system(size: 17, weight: .bold, design: .rounded))
                .frame(width: 150, height: 45, alignment: .center)
                .foregroundColor(.blue)
                .zIndex(2.0)
            
        }.frame(width: 300, height: 160, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 10))
            .foregroundColor(.white)
            .zIndex(3.0)
        
    }
    
    var fullView : some View {
        VStack(){
            
            HStack(){
                
                buttonBack
                
                cardTitle
                
                btnEdit
                
                if ProductObj.tempProd?.Delete_At_Product == "-" {
                    
                    btnDelete
                    
                }else{
                    
                    btnRestore
                    
                }
            }
            
            Divider()
            
            imgProduct
                .frame(width: 520, height: 420)
            
            HStack(){
                
                if stockWarning(){
                    
                    stockWarningInfo
                    
                    if ProductObj.tempProd?.Delete_At_Product != "-"{
                        
                        notAvalableInfo
                        
                    }

                }
                
            }
            
            HStack(){
                
                leftContent
                    .foregroundColor(.black)
                    .padding()
                
                Spacer().frame(width: 20, height: 0, alignment: .center)
                
                rightContent
                    .foregroundColor(.black)
                    .padding()
                
            }.padding()
            .frame(width: 600, height: 340, alignment: .leading)
            
        }.frame(width: 640, height: 880, alignment: .leading)
            
    }
    
    func stockWarning() -> Bool{
        
        let stockInt = (ProductObj.tempProd!.Stock as NSString).intValue
        let mStockInt = (ProductObj.tempProd!.Min_Stock as NSString).intValue
        
        return stockInt <= mStockInt
        
    }
    
    func concatSupp() -> String{
        let SName = ProductObj.tempProd!.FName_Supplier + " " + ProductObj.tempProd!.LName_Supplier
        let Owner = ProductObj.tempProd!.Owner
        
        return SName + " ( " + Owner + " ) "
    }
    
    func concatEmp() -> String{
        let EName = ProductObj.tempProd!.FName_Employee + " " + ProductObj.tempProd!.LName_Employee
        
        return EName
    }
    
    func convert(priceString : String) -> String {
        let number = (priceString as NSString).floatValue
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "id_ID")
        formatter.numberStyle = .currency
        let priceIDR = formatter.string(from: number as NSNumber)
        
        return priceIDR!
    }
    
    var body: some View{

        ZStack(){
            
            ZStack(){
                
                Image("sitting-2")
                    .frame(width: UIScreen.main.bounds.width, height: 950, alignment: .bottomTrailing)
                    .offset(x: 320, y: stockWarning() ? 455 : 435)
                    .scaleEffect(0.5)
                
                fullView
                    
            
            }.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.white, lineWidth: 1)
            .background(isShowResult || btnRestoreClicked ? Color.black : Color.clear)
            .opacity(isShowResult || btnRestoreClicked ? 0.2 : 0)
                .edgesIgnoringSafeArea(.all))
            .zIndex(2.0)
            
            .alert(isPresented: $btnDeleteClicked) {
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        ProductDelete.deleteProduct(product_id:ProductObj.tempProd!.Product_ID)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            isShowResult = true
                        }
                    }
                    let secondaryButton = Alert.Button.destructive(Text("No")) {
                        
                    }
                    return Alert(title: Text("Delete this product ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
                }
            
            RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width,
                   height: UIScreen.main.bounds.height)
            .foregroundColor(Color.init(red: 0.5, green: 0.6, blue: 0.8).opacity(0.1))
            .edgesIgnoringSafeArea(.all)
            .zIndex(1.0)
        
            RoundedRectangle(cornerRadius: 10)
            .frame(width: UIScreen.main.bounds.width - 120,
                   height: stockWarning() ? UIScreen.main.bounds.height - 120 : UIScreen.main.bounds.height - 145)
            .foregroundColor(.white)
            .zIndex(1.0)
            
            .disabled( isShowResult || btnRestoreClicked )
            
            if isShowResult {
                
                resultAlert
                
            }
            
            if btnRestoreClicked {
                
                restoreAlert
                
            }
        }
    }
}

struct ShowDetailProduct_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailProduct()
    }
}
