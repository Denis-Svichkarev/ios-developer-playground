//
//  AuthView.swift
//  SwiftUI+MVVM
//
//  Created by Denis Svichkarev on 22/11/24.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            TextField("Email", text: $viewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .disabled(viewModel.isLoading)
            
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .disabled(viewModel.isLoading)
            
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.login()
                        coordinator.handle(.loginSuccess)
                    } catch {
                        print("Login failed: \(error.localizedDescription)")
                    }
                }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .tint(.white)
                } else {
                    Text("Login")
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(!viewModel.isValid || viewModel.isLoading)
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Login")
    }
}

#Preview {
    AuthView()
}
