
import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct VozAccesibleApp: App {

    @State private var usuarioAutenticado: Bool =
        Auth.auth().currentUser != nil

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                if usuarioAutenticado {
                    ContentView()
                } else {
                    LoginView()
                }
            }
            .onAppear {
                verificarSesion()
            }
        }
    }

    // Verifica si existe una sesión activa.
    func verificarSesion() {
        usuarioAutenticado =
            Auth.auth().currentUser != nil
    }
}
