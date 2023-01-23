//
//  SignupView.swift
//  SignUp
//
//  Created by Andrei-Gabriel Popa on 17.12.2022.
//

import SwiftUI

extension SignupView {
    @MainActor class ViewModel: ObservableObject {
        @Published var username = ""
        @Published var usernameError = ""
        @Published var password = ""
        @Published var confirmPassword = ""
        @Published var passwordError = ""
        @Published var confirmPasswordError = ""
        @Published var email = ""
        @Published var emailError = ""
        @Published var isSecure = true
        @Published var checkBox = false
        @Published var checkBoxError = ""
        @Published var toSuccess = false
        
        func isUsernameValid() -> Bool {
            if username.isEmpty {
                usernameError = "Type your username !"
                return false
            }
            if username.contains(where: {$0.isWhitespace}) == true {
                usernameError = "White spaces are not allowed !"
                return false
            }
            
            usernameError = ""
            return true
        }
        
        func isEmailValid() -> Bool {
            if email.isEmpty {
                emailError = "Type your email !"
                return false
            }
            
            if email.contains("@") && email.contains(".") {
                emailError = ""
                return true
            }
            emailError = ("Your email format is wrong !")
            return false
        }
        
        func isPasswordValid() -> Bool {
            
            if password.isEmpty {
                passwordError = "Type your password !"
                return false
            } else {
                passwordError = ""
            }
            
            if password.count < 8 {
                passwordError = "Password must have at least 8 characters !"
                return false
            } else {
                passwordError = ""
            }
            
            if password.contains(where: { $0.isNumber }) == false {
                passwordError = "Password must contain at least one number !"
                return false
            } else {
                passwordError = ""
            }
            
            if password.contains(where: {$0.isSymbol || $0.isPunctuation }) == false {
                passwordError = "Password must contain at least one symbol or one punctuation !"
                return false
            } else {
                passwordError = ""
            }
            
            if password.contains(where: {$0.isLowercase}) == false {
                passwordError = "Password must contain at least one lowercased !"
                return false
            } else {
                passwordError = ""
            }
            
            if password.contains(where: {$0.isUppercase}) == false {
                passwordError = "Password must contain at least one uppercased !"
                return false
            } else {
                passwordError = ""
            }
            
            if password != confirmPassword {
                confirmPasswordError = "Passwords are not the same !"
                return false
            } else {
                confirmPasswordError = ""
            }
            
            return true
        }
        
        func isTermsAccepted() -> Bool {
            if checkBox == false {
                checkBoxError = "You must aggree to Terms & Conditions !"
                return false
            } else {
                checkBoxError = ""
            }
            return true
        }
        
        func handleCreateAccount() {
            if isUsernameValid() && isEmailValid() && isPasswordValid() && isTermsAccepted() {
                toSuccess = true
            }
        }
    }
}

struct SignupView: View {
    
    @StateObject var viewModel: ViewModel = .init()
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        Spacer()
                        Text("Sign Up")
                            .bold()
                            .font(.title)
                            .foregroundColor(.blue)
                            .padding(.bottom, 30)
                        
                        VStack(alignment: .leading) {
                            ZStack {
                                SignUpBar().shadow(color: viewModel.usernameError == "" ? .white : .red, radius: 3)
                                
                                HStack {
                                    Image(systemName: "person.circle.fill")
                                        .padding(.leading, 40)
                                    TextField("Username", text: $viewModel.username)
                                        .padding(.leading, 5)
                                }
                            }
                            
                            if viewModel.usernameError.isEmpty == false {
                                Text(viewModel.usernameError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.leading, 45)
                                    .padding(.top, 5)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            ZStack {
                                SignUpBar().shadow(color: viewModel.emailError == "" ? .white : .red, radius: 3)
                                
                                HStack {
                                    Image(systemName: "envelope.fill")
                                        .padding(.leading, 40)
                                    TextField("Email", text: $viewModel.email)
                                        .padding(.leading, 5)
                                }
                            }
                            
                            if viewModel.emailError.isEmpty == false {
                                Text(viewModel.emailError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.leading, 45)
                                    .padding(.top, 5)
                            }
                            
                        }
                        
                        VStack(alignment: .leading) {
                            ZStack {
                                SignUpBar().shadow(color: viewModel.passwordError == "" ? .white : .red, radius: 3)
                                
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .padding(.leading, 40)
                                    if viewModel.isSecure {
                                        SecureField("Password", text: $viewModel.password)
                                            .padding(.leading, 5)
                                    } else {
                                        TextField("Password", text: $viewModel.password)
                                            .padding(.leading, 5)
                                    }
                                    Button {
                                        viewModel.isSecure.toggle()
                                    } label: {
                                        Image(systemName: viewModel.isSecure ? "eye" : "eye.slash")
                                        
                                    }
                                    .padding(.trailing, 45)
                                }
                            }
                            if viewModel.passwordError.isEmpty == false {
                                Text(viewModel.passwordError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.leading, 45)
                                    .padding(.top, 5)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            ZStack {
                                SignUpBar().shadow(color: viewModel.confirmPasswordError == "" ? .white : .red, radius: 3)
                                
                                HStack {
                                    Image(systemName: "lock.fill")
                                        .padding(.leading, 40)
                                    if viewModel.isSecure {
                                        SecureField("Confirm Password", text: $viewModel.confirmPassword)
                                            .padding(.leading, 5)
                                    } else {
                                        TextField("Confirm Password", text: $viewModel.confirmPassword)
                                            .padding(.leading, 5)
                                    }
                                    Button {
                                        viewModel.isSecure.toggle()
                                    } label: {
                                        Image(systemName: viewModel.isSecure ? "eye" : "eye.slash")
                                        
                                    }
                                    .padding(.trailing, 45)
                                }
                            }
                            
                            if viewModel.confirmPasswordError.isEmpty == false {
                                Text(viewModel.confirmPasswordError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.leading, 45)
                                    .padding(.top, 5)
                            }
                        }
                        
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: viewModel.checkBox ? "checkmark.square.fill" : "square")
                                    .onTapGesture {
                                        self.viewModel.checkBox.toggle()
                                    }
                                Text("I read and agree to Terms & Conditions")
                                    .font(.caption)
                            }
                            .padding(.trailing)
                            
                            if viewModel.checkBox == false {
                                Text(viewModel.checkBoxError)
                                    .foregroundColor(.red)
                                    .font(.caption)
                                    .padding(.horizontal)
                                    .padding(.top, 5)
                            }
                        }
                        
                        Button {
                            viewModel.handleCreateAccount()
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 50)
                                    .padding(.horizontal, 30)
                                    .scaledToFit()
                                    .foregroundColor(.blue)
                                    .frame(width: 250)
                                Text("Create Account")
                                    .foregroundColor(.white)
                            }
                        }

                        Spacer()
                    }.padding()
                }
                
                NavigationLink(isActive: $viewModel.toSuccess) {
                    SuccesfullSignUp()
                } label: {
                    EmptyView()
                }

            }
            
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
