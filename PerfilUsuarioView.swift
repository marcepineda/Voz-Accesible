
import SwiftUI
import FirebaseAuth

struct PerfilUsuarioView: View {

    @State private var correoUsuario: String = ""
    @State private var mensaje: String = ""
    @State private var sesionCerrada: Bool = false

    private let authService = FirebaseAuthService()

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {

                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)

                Text("Mi perfil")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                VStack(alignment: .leading, spacing: 10) {

                    Text("Correo electrónico")
                        .font(.headline)

                    Text(correoUsuario.isEmpty
                         ? "No disponible"
                         : correoUsuario)
                        .foregroundColor(.gray)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }

                Button(action: cerrarSesion) {
                    Label(
                        "Cerrar sesión",
                        systemImage: "rectangle.portrait.and.arrow.right"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                if !mensaje.isEmpty {
                    Text(mensaje)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Perfil")
            .onAppear {
                cargarPerfil()
            }
        }
    }

    // MARK: - Cargar perfil

    func cargarPerfil() {
        correoUsuario = Auth.auth().currentUser?.email ?? ""
    }

    // MARK: - Cerrar sesión

    func cerrarSesion() {
        do {
            try authService.cerrarSesion()

            sesionCerrada = true
            mensaje = "La sesión se ha cerrado correctamente."

        } catch {
            mensaje = "Error al cerrar sesión: \(error.localizedDescription)"
        }
    }
}
