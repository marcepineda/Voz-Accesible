
import SwiftUI

struct AgregarFraseView: View {

    @State private var textoFrase: String = ""
    @State private var categoriaSeleccionada: String = "General"
    @State private var mensajeEstado: String = ""
    @State private var guardando: Bool = false

    private let firebaseService = FirebaseService()

    let categorias = [
        "General",
        "Necesidades básicas",
        "Salud",
        "Emociones",
        "Social",
        "Ayuda"
    ]

    var body: some View {
        NavigationView {
            Form {

                Section(header: Text("Nueva frase")) {

                    TextField(
                        "Escribe tu frase",
                        text: $textoFrase,
                        axis: .vertical
                    )
                    .lineLimit(3...6)

                    Picker(
                        "Categoría",
                        selection: $categoriaSeleccionada
                    ) {
                        ForEach(categorias, id: \.self) { categoria in
                            Text(categoria)
                                .tag(categoria)
                        }
                    }
                }

                Section {
                    Button(action: guardarFrase) {
                        HStack {
                            Spacer()

                            if guardando {
                                ProgressView()
                            } else {
                                Label(
                                    "Guardar frase",
                                    systemImage: "square.and.arrow.down.fill"
                                )
                            }

                            Spacer()
                        }
                    }
                    .disabled(
                        textoFrase.trimmingCharacters(
                            in: .whitespacesAndNewlines
                        ).isEmpty || guardando
                    )
                }

                if !mensajeEstado.isEmpty {
                    Section {
                        Text(mensajeEstado)
                            .foregroundColor(.blue)
                    }
                }
            }
            .navigationTitle("Agregar frase")
        }
    }

    func guardarFrase() {
        let textoLimpio = textoFrase.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !textoLimpio.isEmpty else {
            mensajeEstado = "Escribe una frase antes de guardar."
            return
        }

        guardando = true
        mensajeEstado = ""

        Task {
            do {
                try await firebaseService.guardarFrase(
                    texto: textoLimpio,
                    categoria: categoriaSeleccionada
                )

                await MainActor.run {
                    mensajeEstado = "¡Frase guardada correctamente!"
                    textoFrase = ""
                    guardando = false
                }

            } catch {
                await MainActor.run {
                    mensajeEstado = "Error al guardar: \(error.localizedDescription)"
                    guardando = false
                }
            }
        }
    }
}
