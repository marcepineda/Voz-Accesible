
import SwiftUI
import AVFoundation

struct MisFrasesView: View {

    @State private var frases: [FraseFirebase] = []
    @State private var cargando: Bool = false
    @State private var mensajeError: String = ""

    private let firebaseService = FirebaseService()
    private let sintetizador = AVSpeechSynthesizer()

    var body: some View {
        NavigationView {
            VStack {

                if cargando {
                    ProgressView("Cargando frases...")
                        .padding()

                } else if frases.isEmpty {
                    VStack(spacing: 15) {
                        Image(systemName: "text.bubble")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)

                        Text("No hay frases guardadas")
                            .font(.headline)

                        Text("Agrega frases personalizadas para comenzar.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    .padding()

                } else {
                    List {
                        ForEach(frases) { frase in
                            VStack(alignment: .leading, spacing: 10) {

                                Text(frase.texto)
                                    .font(.headline)

                                Text(frase.categoria)
                                    .font(.caption)
                                    .foregroundColor(.blue)

                                HStack {

                                    Button(action: {
                                        reproducirFrase(frase.texto)
                                    }) {
                                        Label(
                                            "Reproducir",
                                            systemImage: "speaker.wave.2.fill"
                                        )
                                    }

                                    Spacer()

                                    Button(role: .destructive, action: {
                                        eliminarFrase(frase.id)
                                    }) {
                                        Label(
                                            "Eliminar",
                                            systemImage: "trash"
                                        )
                                    }
                                }
                            }
                            .padding(.vertical, 8)
                        }
                    }
                }

                if !mensajeError.isEmpty {
                    Text(mensajeError)
                        .foregroundColor(.red)
                        .padding()
                }
            }
            .navigationTitle("Mis frases")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: cargarFrases) {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
            .onAppear {
                cargarFrases()
            }
        }
    }

    // MARK: - Cargar frases desde Firebase

    func cargarFrases() {
        cargando = true
        mensajeError = ""

        Task {
            do {
                let resultado = try await firebaseService.obtenerFrases()

                await MainActor.run {
                    frases = resultado
                    cargando = false
                }

            } catch {
                await MainActor.run {
                    mensajeError = error.localizedDescription
                    cargando = false
                }
            }
        }
    }

    // MARK: - Reproducir frase

    func reproducirFrase(_ texto: String) {
        sintetizador.stopSpeaking(at: .immediate)

        let mensaje = AVSpeechUtterance(string: texto)

        mensaje.voice = AVSpeechSynthesisVoice(language: "es-SV")

        mensaje.rate = AVSpeechUtteranceDefaultSpeechRate

        sintetizador.speak(mensaje)
    }

    // MARK: - Eliminar frase

    func eliminarFrase(_ id: String) {
        Task {
            do {
                try await firebaseService.eliminarFrase(id: id)

                await MainActor.run {
                    frases.removeAll { $0.id == id }
                }

            } catch {
                await MainActor.run {
                    mensajeError = "No se pudo eliminar la frase."
                }
            }
        }
    }
}
