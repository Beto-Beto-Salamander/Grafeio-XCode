//
//  CategoryPage.swift
//  Grafeio
//
//  Created by Ryan Octavius on 30/11/20.
//

import SwiftUI
import Combine

struct CategoryPage: View {
    @EnvironmentObject var AuthUser : UserAuth
    @EnvironmentObject var CategoryDelete : DeleteCategory
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
                    HeaderCategory()
                    ListCategory()
                }

            PostCategoryFloatingButton()
        }
            //}
        
        .navigationBarTitle("Category Page", displayMode: .inline)
        .navigationBarBackButtonHidden(false)
    }
}

struct CategoryLoading : View {
    @EnvironmentObject var CategoryDel : DeleteCategory
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var LoadingProgress: some View {
        Text(CategoryDel.isSuccess ? "Success" : "Failed")
            .font(.system(size: 20))
            .bold()
            .transition(.slide)
            .frame(width: 200, height: 100, alignment: .center)
            .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white, lineWidth: 2)
                    )
            .foregroundColor(.white)
            .background(CategoryDel.isSuccess ? Color.green : Color.red)
            .cornerRadius(20)
            
    }
    
    var body: some View{
        LoadingProgress
        
    }
    
}

struct PostCategoryFloatingButton : View {
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
                    destination: PostCategoryPage()){
                self.btn
                }
            }
            .padding()
            .padding(.trailing,10)
        }
    }
}

struct HeaderCategory : View {
    @State var SearchText : String = ""
    @State private var showCancelButton: Bool = false
    @EnvironmentObject var CategoryDelete : DeleteProduct
    @EnvironmentObject var CategoryPost : PostCategory
    @EnvironmentObject var CategoryEdit : EditCategory
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    @EnvironmentObject var CategoryObj : GetCategory
    
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
            CategoryObj.getCategory()
            CategoryPost.initCondition()
            CategoryEdit.initCondition()
            CategoryDelete.initCondition()
            print(CategoryEdit.isSuccess.description)
            print(CategoryDelete.isSuccess.description)
            print(CategoryPost.isSuccess.description)
        })
        }
}

struct CategoryEmpty : View {
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

struct CardViewCategory : View {
    
    @State var CName : String = ""
    @State var CDesc : String = ""
    @State var CID : String = ""
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    var InfoCard : some View {
        VStack(){
            Text(CName.uppercased())
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .bold, design: .rounded))
                .frame(width: 220, height: 20, alignment: .topLeading)
                .padding(.trailing,20)
            
            Text(CDesc)
                .foregroundColor(.black)
                .font(.system(size: 15, weight: .medium, design: .rounded))
                .frame(width: 220, height: 40, alignment: .topLeading)
                .padding(.trailing,20)
            
            HStack(){
                Image(systemName: "staroflife.circle")
                    .background(gradient.mask(Image(systemName: "staroflife.circle")))
                
                Text("Category ID : " + CID)
                    .foregroundColor(Color.clear)
                    .background(gradient.mask(Text("Category ID : " + CID)))
                    .font(.system(size: 15, weight: .bold, design: .rounded))
                    .frame(width: 220, height: 20, alignment: .leading)
            }
        }
    }
    
    var BgCard : some View {
        Text("")
            .frame(width: 320, height: 100, alignment: .center)
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
                    .frame(width: 40, height: 100, alignment: .center)
                
                
            }.zIndex(1.0)
            .frame(width: 340, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
            BgCard
            
        }
    }
}



struct ListCategory : View {
    let colors : [Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    let columns = [GridItem(.adaptive(minimum: 300))]
    @State var Categories : Category?
    @State var isPressed : Bool = false
    @State var changeView : Bool = false
    @State var showDetail : Bool = false
    @State var notAvailable : Bool = false
   
    @EnvironmentObject var AuthUser: UserAuth
    @EnvironmentObject var CategoryObj : GetCategory
    @EnvironmentObject var CategoryDelete : DeleteProduct
    @EnvironmentObject var CategoryPost : PostCategory
    @EnvironmentObject var CategoryEdit : EditCategory
    
    var body : some View {
            VStack(){
                ScrollView{
                    LazyVGrid(columns: columns , spacing : 20 ) {
                        ForEach(CategoryObj.Categories, id: \.Category_ID){ i in
                            NavigationLink(destination: ShowDetailCategory(Categories: i)){
                                CardViewCategory(CName: i.Category_Name,
                                                 CDesc: i.Category_Description,
                                                 CID: i.Category_ID).id(i.Category_ID)
                                    
                               }
                            }
                        }
                    }.padding([.top, .horizontal, .bottom], 30)
                }.background(Color.init(red: 0.5, green: 0.6, blue: 0.8).opacity(0.1))
        }
    func disappearResult() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            //CategoryDel.showResult = false
        }
    }
}

struct CategoryPage_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPage().environmentObject(UserAuth())
    }
}
