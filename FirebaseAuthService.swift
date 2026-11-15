
import Foundation
import FirebaseAuth

// Servicio encargado de administrar la autenticación
// de los usuarios de Voz Accesible.
class FirebaseAuthService {

    // MARK: - Registrar usuario

    func registrarUsuario(
        correo: String,
        contrasena: String
    ) async throws -> String {

        let resultado = try await Auth.auth().createUser(
            withEmail: correo,
            password: contrasena
        )

        return resultado.user.uid
    }

    // MARK: - Iniciar sesión

    func iniciarSesion(
        correo: String,
        contrasena: String
    ) async throws -> String {

        let resultado = try await Auth.auth().signIn(
            withEmail: correo,
            password: contrasena
        )

        return resultado.user.uid
    }

    // MARK: - Cerrar sesión

    func cerrarSesion() throws {
        try Auth.auth().signOut()
    }

    // MARK: - Obtener usuario actual

    func obtenerUsuarioActual() -> String? {
        return Auth.auth().currentUser?.uid
    }

    // MARK: - Verificar sesión

    func haySesionActiva() -> Bool {
        return Auth.auth().currentUser != nil
    }
}
