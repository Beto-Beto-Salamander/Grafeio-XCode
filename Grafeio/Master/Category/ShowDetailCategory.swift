//
//  ShowDetailCategory.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import SwiftUI
import Combine

struct ShowDetailCategory: View {
    @EnvironmentObject var AuthUser : UserAuth
    @EnvironmentObject var CategoryDelete : DeleteCategory
    @State var Categories : Category? = nil
    
    var body: some View {
        if CategoryDelete.isSuccess {
            return AnyView(CategoryPage().environmentObject(AuthUser))
        }
        else {
            return AnyView(DetailCategory(Categories : Categories))
        }
        
        //DetailCategory(Categories : Categories)
    }
}

struct DetailCategory : View {
    @State var Categories : Category? = nil
    @State var BtnEditPressed : Bool = false
    @State var BtnDeletePressed : Bool = false
    @EnvironmentObject var CategoryDelete : DeleteCategory
    @EnvironmentObject var CategoryEdit : EditCategory
    @EnvironmentObject var CategoryGet : GetCategory
    @EnvironmentObject var AuthUser : UserAuth
    
    var leftContent : some View {
        VStack(alignment : .leading){
            Group{
                Text("Category ID")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Category Name")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                
                Text("Category Description")
                    .font(.system(size: 20, weight: .medium, design: .rounded))
                    .frame(width: 200, height: 60, alignment: .topLeading)
            }
        }
    }
    
    var rightContent : some View {
        VStack(alignment : .leading){
            Group{
                Text(Categories!.Category_ID)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Categories!.Category_Name)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                
                Text(Categories!.Category_Description)
                    .font(.system(size: 20, weight: .regular, design: .rounded))
                    .frame(height: 60, alignment: .topLeading)
            }
        }
    }
    
    var fullView : some View {
        ZStack(){
            Text("")
                .frame(width: 650, height: 310, alignment: .leading)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0.0, y: 0.0)
    
            VStack(){
                HStack(){
                    Text("Category Detail")
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
                }.frame(width: 600, height: 200, alignment: .leading)
                
            }.frame(width: 600, height: 260, alignment: .leading)
            .padding()
        }
    }
    
    var body: some View{
        NavigationLink(destination: EditCategoryPage(Categories: Categories!), isActive: self.$BtnEditPressed) {EmptyView()}
        
        fullView
            .alert(isPresented: $BtnDeletePressed) {
                    let primaryButton = Alert.Button.default(Text("Yes")) {
                        CategoryGet.emptyArr()
                        CategoryDelete.deleteCategory(catid : Categories!.Category_ID)
                        
                    }
                    let secondaryButton = Alert.Button.destructive(Text("No")) {
                       
                    }
                    return Alert(title: Text("Delete this Category ?"), message: Text(""), primaryButton: primaryButton, secondaryButton: secondaryButton)
            }
        
    }
    
    
}

struct ShowDetailCategory_Previews: PreviewProvider {
    static var previews: some View {
        ShowDetailCategory()
    }
}
