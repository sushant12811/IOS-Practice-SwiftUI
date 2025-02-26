import SwiftUI

struct SettingView: View {
    @StateObject private var authScreenModel = AuthScreenModel()
    @State private var showLogoutAlert = false
    
    
    var body: some View {
        NavigationStack {
            Button {
                showLogoutAlert = true
                
            } label: {
                Text("Log Out")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.subheadline)
                    .padding()
                    .background(.red)
                    .clipShape(.rect(cornerRadius: 10))
            }
            .alert("Log Out", isPresented: $showLogoutAlert) {
                Button("Cancel", role: .cancel) {
                    // cancel
                }
                Button("Log Out", role: .destructive) {
                    Task {
                        await authScreenModel.handleLogout()
                        
                    }
                }
            } message: {
                Text("Are you sure you want to log out?")
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    SettingView()
}
