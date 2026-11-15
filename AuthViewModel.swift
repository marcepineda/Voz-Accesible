
import SwiftUI
import FirebaseAuth
import Combine

@MainActor
final class AuthViewModel: ObservableObject {

    @Published var usuario: FirebaseAuth.User?

    private var listener: AuthStateDidChangeListenerHandle?

    init() {
        usuario = Auth.auth().currentUser

        listener = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            Task { @MainActor in
                self?.usuario = user
            }
        }
    }
}
