
import SwiftUI

struct LoginView: View {

    @State private var correo: String = ""
    @State private var contrasena: String = ""
    @State private var esRegistro: Bool = false
    @State private var mensaje: String = ""
    @State private var cargando: Bool = false
    @State private var sesionActiva: Bool = false

    private let authService = FirebaseAuthService()

    var body: some View {
        NavigationView {
            VStack(spacing: 25) {

                Image(systemName: "waveform.circle.fill")
                    .font(.system(size: 75))
                    .foregroundColor(.blue)

                Text("Voz Accesible")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                Text(esRegistro ? "Crear cuenta" : "Iniciar sesión")
                    .font(.title2)
                    .fontWeight(.semibold)

                TextField("Correo electrónico", text: $correo)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                SecureField("Contraseña", text: $contrasena)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

                Button(action: autenticarUsuario) {
                    HStack {
                        Spacer()

                        if cargando {
                            ProgressView()
                        } else {
                            Text(esRegistro ? "Registrarse" : "Ingresar")
                                .font(.headline)
                        }

                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(cargando)

                Button(action: {
                    esRegistro.toggle()
                    mensaje = ""
                }) {
                    Text(
                        esRegistro
                        ? "¿Ya tienes cuenta? Inicia sesión"
                        : "¿No tienes cuenta? Regístrate"
                    )
                    .foregroundColor(.blue)
                }

                if !mensaje.isEmpty {
                    Text(mensaje)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Acceso")
        }
    }

    // MARK: - Autenticación

    func autenticarUsuario() {
        let correoLimpio = correo.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !correoLimpio.isEmpty, !contrasena.isEmpty else {
            mensaje = "Completa el correo y la contraseña."
            return
        }

        cargando = true
        mensaje = ""

        Task {
            do {
                if esRegistro {
                    _ = try await authService.registrarUsuario(
                        correo: correoLimpio,
                        contrasena: contrasena
                    )
                } else {
                    _ = try await authService.iniciarSesion(
                        correo: correoLimpio,
                        contrasena: contrasena
                    )
                }

                await MainActor.run {
                    sesionActiva = true
                    cargando = false
                    mensaje = "Autenticación exitosa."
                }

            } catch {
                await MainActor.run {
                    mensaje = error.localizedDescription
                    cargando = false
                }
            }
        }
    }
}
