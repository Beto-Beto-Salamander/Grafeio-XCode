//
//  ContentView.swift
//  Grafeio
//
//  Created by Ryan Octavius on 23/11/20.
//

import SwiftUI
import Combine

struct ContentView: View {
    @EnvironmentObject var AuthUser: UserAuth
    
    var body: some View {
        if !AuthUser.isLoggedin {
            return AnyView(LoginBlur())
        } else {
            return AnyView(HomeScreen().environmentObject(AuthUser))
        }           
    }
}

struct LoginBlur : View {
    @EnvironmentObject var AuthUser: UserAuth
    @State var text = ""
    let timer = Timer.publish(every: 0.2, on: .main, in: .common).autoconnect()

    var LoadingProgress: some View {
        ProgressView("Loading...")
            .progressViewStyle(CircularProgressViewStyle())
            .frame(width: 200, height: 100, alignment: .center)
            .background(Color.white)
            .cornerRadius(10)
            .zIndex(2.0)
    }
    
    var body: some View{
        ZStack(){
            
            if(AuthUser.isLoading){
                LoadingProgress
                    .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    .zIndex(1)
            }
            
            Login()
                .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.white, lineWidth: 1)
                            .background(AuthUser.isLoading ? Color.black : Color.clear).opacity(AuthUser.isLoading ? 0.2 : 0))
        }
    }
}

struct Login : View {
    @State var username: String = ""
    @State var password: String = ""
    @State var isActivePass : Bool = false
    @State var isActiveUser : Bool = false
    @State var isEmptyField = false
    @State var gradient:LinearGradient = LinearGradient(
        gradient: Gradient(colors: [Color(.systemIndigo), .blue]),
          startPoint: .leading,
          endPoint: .bottom
       )
    
    @EnvironmentObject var AuthUser: UserAuth
    var GrafeioText : some View {
        Text("GRAFEIO")
            .padding()
            .foregroundColor(Color.clear)
            .background(gradient.mask(Text("GRAFEIO")))
            .font(.system(size: 80, weight: .bold, design: .rounded))
            .offset(x: 0.0, y: -180.0).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
            
    }
    
    var SubHeadlineText : some View {
        Text("Please log in first !")
            .foregroundColor(Color.clear)
            .background(gradient.mask(Text("Please log in first !")))
            .font(.system(size: 30, weight: .bold, design: .rounded))
            .offset(x: 0.0, y: 0.0).zIndex(/*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
    }
    
    var usernameTextF : some View {
        HStack {
            
            Image(systemName: "person.fill").foregroundColor(Color.blue)
            
            Divider()
            
            TextField("Username", text : self.$username)
                .simultaneousGesture(TapGesture().onEnded {
                    self.isActiveUser = true
                    self.isActivePass = false
                })
            
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: isActiveUser ? 4 : 1))
        .background(Color.white)
    }
    
    var passwordTextF : some View {
        HStack {
            
            Image(systemName: "key.fill").foregroundColor(Color.blue)
            
            Divider()
            
            SecureField("Password", text: self.$password)
                .simultaneousGesture(TapGesture().onEnded {
                    self.isActiveUser = false
                    self.isActivePass = true
                })
            
        }
        .padding()
        .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: isActivePass ? 4 : 1))
        .background(Color.white)
    }
    
    var loginButton : some View {
        Button(action : {
            if(self.username.isEmpty || self.password.isEmpty){
                
                self.isEmptyField = true
                self.isActiveUser = false
                self.isActivePass = false
                
            }else{
                
                self.AuthUser.cekLogin(password: self.password, employee_id: self.username)
                self.isEmptyField = false
                self.isActiveUser = false
                self.isActivePass = false
                
            }
        }){
            Text("Log In")
                .padding()
                .font(.system(size: 17, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 150, height: 45, alignment: .center)
                .background(LinearGradient(gradient: Gradient(colors: [Color(.systemIndigo), .blue]), startPoint: .leading, endPoint: .bottom)
                )
                .cornerRadius(10)
        }.padding(.top, 20)
    }
    
    var personImage : some View {
        Image("standing-1")
            .resizable()
            .frame(width: 250, height: 350, alignment: .center)
            .padding(100)
            .offset(x: -210.0, y: 15.0)
    }
    
    var body: some View {
        VStack(alignment: .trailing, spacing: nil, content: {
            
            ZStack(){
                
                self.GrafeioText
                
                VStack(){
                    
                    Spacer().frame(width: 10, height: 30, alignment: .center)
                    
                    self.SubHeadlineText
                    
                    Spacer().frame(width: 10, height: 115, alignment: .center)
                    
                    VStack(alignment: .leading, spacing: 15, content: {
                        
                        Spacer().frame(width: 10, height: 50, alignment: .center)
                        
                        self.usernameTextF
                        self.passwordTextF
                        
                        if(!self.AuthUser.isCorrect && !self.isEmptyField){
                            Text("Wrong Username or Password")
                                .foregroundColor(.red)
                                .frame(width: 300, height: 30, alignment: .center)
                        }
                        
                        if(self.isEmptyField){
                            Text("Don't leave a blank field(s)")
                                .foregroundColor(.red)
                                .frame(width: 300, height: 30, alignment: .center)
                        }
                        
                        
                    }).padding(.bottom, 100)
                    .frame(width: 300, height: 20, alignment: .center)
                    
                    Spacer().frame(width: 10, height: 50, alignment: .center)
                    
                    self.loginButton
                    
                }.frame(width: 450, height: 330, alignment: .center)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                
                self.personImage
            }
            
        })
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            .background(
                Color.init(red: 0.5, green: 0.6, blue: 0.8).opacity(0.1)
                .edgesIgnoringSafeArea(.all)
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserAuth())
    }
}


