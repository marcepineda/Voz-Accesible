
import Foundation
import FirebaseFirestore

// Modelo de datos para representar una frase almacenada en Firebase.
struct FraseFirebase: Identifiable {
    var id: String
    var texto: String
    var categoria: String
    var fecha: Date
}

// Servicio encargado de administrar las frases en Firebase Firestore.
class FirebaseService {

    private let db = Firestore.firestore()

    // MARK: - Guardar frase

    func guardarFrase(
        texto: String,
        categoria: String
    ) async throws {

        let datos: [String: Any] = [
            "texto": texto,
            "categoria": categoria,
            "fecha": Timestamp(date: Date())
        ]

        try await db.collection("frases")
            .addDocument(data: datos)
    }

    // MARK: - Obtener frases

    func obtenerFrases() async throws -> [FraseFirebase] {

        let resultado = try await db.collection("frases")
            .order(by: "fecha", descending: true)
            .getDocuments()

        let frases = resultado.documents.map { documento in

            let datos = documento.data()

            return FraseFirebase(
                id: documento.documentID,
                texto: datos["texto"] as? String ?? "",
                categoria: datos["categoria"] as? String ?? "General",
                fecha: (datos["fecha"] as? Timestamp)?.dateValue() ?? Date()
            )
        }

        return frases
    }

    // MARK: - Eliminar frase

    func eliminarFrase(id: String) async throws {

        try await db.collection("frases")
            .document(id)
            .delete()
    }
}
