//
//  UserView.swift
//  StudyProject-Swift
//
//  Created by Denis Svichkarev on 21/11/24.
//

import SwiftUI

struct UserView: View {
    @ObservedObject var userViewModel = UserViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            
            if let user = userViewModel.user {
                Text("Hello, \(user.name)!")
            } else {
                Text("No user data")
                    .font(Font.system(size: 18, weight: .medium))
            }
            
            Spacer()

            Button(action: {
                userViewModel.downloadUser()
            }) {
                Text("Fetch User")
            }
        }
    }
}

#Preview {
    UserView()
}
