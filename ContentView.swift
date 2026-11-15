
import SwiftUI
import AVFoundation

struct ContentView: View {

    // MARK: - Variables
    @State private var textoMensaje: String = ""
    @State private var mensajeReproducido: Bool = false

    // Sintetizador de voz
    private let sintetizador = AVSpeechSynthesizer()

    // MARK: - Interfaz principal
    var body: some View {
        NavigationView {
            VStack(spacing: 25) {

                // Título de la aplicación
                Text("Voz Accesible")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                Text("Expresa tus ideas mediante la voz")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                // Campo para escribir mensajes
                TextEditor(text: $textoMensaje)
                    .frame(height: 180)
                    .padding(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue, lineWidth: 1)
                    )

                // Botón para reproducir el mensaje
                Button(action: reproducirVoz) {
                    Label(
                        "Reproducir mensaje",
                        systemImage: "speaker.wave.3.fill"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                // Botón para detener la voz
                Button(action: detenerVoz) {
                    Label(
                        "Detener reproducción",
                        systemImage: "stop.fill"
                    )
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Comunicación")
        }
    }

    // MARK: - Función de síntesis de voz
    func reproducirVoz() {

        // Verifica que exista un mensaje
        if textoMensaje.trimmingCharacters(
            in: .whitespacesAndNewlines
        ).isEmpty {
            return
        }

        // Prepara el mensaje para convertirlo en voz
        let mensaje = AVSpeechUtterance(
            string: textoMensaje
        )

        // Configura el idioma español
        mensaje.voice = AVSpeechSynthesisVoice(
            language: "es-SV"
        )

        // Configura la velocidad de reproducción
        mensaje.rate = AVSpeechUtteranceDefaultSpeechRate

        // Reproduce el mensaje
        sintetizador.speak(mensaje)
    }

    // MARK: - Función para detener la voz
    func detenerVoz() {
        sintetizador.stopSpeaking(
            at: .immediate
        )
    }
}
