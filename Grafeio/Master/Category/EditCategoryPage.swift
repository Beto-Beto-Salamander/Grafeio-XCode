//
//  EditCategoryPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//
import SwiftUI
import Combine

struct EditCategoryPage: View {
    let Categories : Category?
    
    @EnvironmentObject var CategoryEdit: EditCategory
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
            //if CategoryObj.isEmptyArr {
            //    CategoryEmpty()
            //}else{
        
        if CategoryEdit.isSuccess {
            return AnyView(CategoryPage().environmentObject(AuthUser))
        }
        else {
            return AnyView(EditViewCategory(Categories: Categories))
        }
    }
}

struct EditViewCategory : View {
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var CategoryEdit: EditCategory
    @EnvironmentObject var CategoryPost: PostCategory
    @EnvironmentObject var CategoryGet: GetCategory
    
    @State var BtnSubmitPresssed : Bool = false
    @State var CategoryName : String = ""
    @State var CategoryDescription : String = ""
    
    let Categories : Category?
    
    var PNameTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Category Name")
                .font(.title)
                .frame(width: 200, height: 50, alignment: .topLeading)
            
            TextField(Categories!.Category_Name, text : self.$CategoryName)
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
    
    var CNameTextF : some View {
        HStack(){
            Spacer()
                .frame(width: 100, height: 100, alignment: .center)
            
            Text("Category Description")
                .frame(width: 200, height: 100, alignment: .topLeading)
                .font(.title)
            
            TextField(Categories!.Category_Description, text : self.$CategoryDescription)
                .foregroundColor(.black)
                .padding()
                .font(.headline)
                .frame(width: 380, height: 100, alignment: .topLeading)
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
            
            PNameTextF
            
            CNameTextF
            
            BtnSubmit
            
            Spacer()
            
        }.alert(isPresented: $BtnSubmitPresssed) {
                let primaryButton = Alert.Button.default(Text("Yes")) {
                    CategoryEdit.catid = Categories!.Category_ID
                    self.CategoryEdit.editCategory(catname: CategoryName,
                                                   catdesc: CategoryDescription)
                    
                }
                let secondaryButton = Alert.Button.destructive(Text("No")) {
                   
                }
                return Alert(title: Text("Submit ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
        }
    }
}
