import SwiftUI

struct OtherProfilePreview: View {
    @State private var userVM = UserViewModel()
    @State private var liveUser: User?
    
    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()
            
            if let user = liveUser {
                OtherProfile(user: .constant(user))
                    .environment(userVM)
            } else {
                ProgressView("Chargement du profil...")
                    .tint(.white)
                    .foregroundStyle(.white)
            }
        }
        .task {
            do {
                let briandID = "rec15VTfdnBrUWmBb"
                self.liveUser = try await userVM.getUserById(briandID)
            } catch {
                print("Erreur de chargement dans la Preview : \(error)")
            }
        }
    }
}
