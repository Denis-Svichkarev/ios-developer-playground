//
//  AuthView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = AuthViewModel(userService: DataSourceManager.shared.getUserService())
    
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Button("Login") {
                viewModel.login(email: email, password: password)
            }
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage).foregroundColor(.red)
            }
        }
        .padding()
        .onAppear {
            viewModel.onLoginSuccess = {
                coordinator.navigate(to: .newsFeed)
            }
        }
    }
}

#Preview {
    AuthView()
}
