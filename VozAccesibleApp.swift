
import SwiftUI
import FirebaseCore

// Punto de entrada de la aplicación Voz Accesible.
@main
struct VozAccesibleApp: App {

    // Inicialización de Firebase al iniciar la aplicación.
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
