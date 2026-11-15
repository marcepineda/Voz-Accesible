
import SwiftUI
import AVFoundation

struct ConfiguracionView: View {

    @State private var velocidad: Double = 0.5
    @State private var idiomaSeleccionado: String = "Español (El Salvador)"

    private let sintetizador = AVSpeechSynthesizer()

    let idiomas: [String] = [
        "Español (El Salvador)",
        "Español (México)",
        "Español (España)",
        "English (United States)"
    ]

    var body: some View {
        NavigationView {
            Form {

                Section(header: Text("Configuración de voz")) {

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Velocidad de la voz")
                            .font(.headline)

                        Slider(
                            value: $velocidad,
                            in: 0.1...1.0,
                            step: 0.1
                        )

                        Text("Velocidad: \(velocidad, specifier: "%.1f")")
                            .foregroundColor(.gray)
                    }
                    .padding(.vertical, 8)

                    Picker(
                        "Idioma",
                        selection: $idiomaSeleccionado
                    ) {
                        ForEach(idiomas, id: \.self) { idioma in
                            Text(idioma).tag(idioma)
                        }
                    }
                }

                Section(header: Text("Prueba de voz")) {

                    Button(action: reproducirPrueba) {
                        Label(
                            "Escuchar voz de prueba",
                            systemImage: "speaker.wave.2.fill"
                        )
                    }

                    Button(action: detenerVoz) {
                        Label(
                            "Detener reproducción",
                            systemImage: "stop.fill"
                        )
                        .foregroundColor(.red)
                    }
                }

                Section(header: Text("Información")) {
                    HStack {
                        Text("Aplicación")
                        Spacer()
                        Text("Voz Accesible")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Framework")
                        Spacer()
                        Text("SwiftUI")
                            .foregroundColor(.gray)
                    }

                    HStack {
                        Text("Motor de voz")
                        Spacer()
                        Text("AVSpeechSynthesizer")
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Configuración")
        }
    }

    func reproducirPrueba() {
        detenerVoz()

        let mensaje = AVSpeechUtterance(
            string: "Hola, esta es una prueba de Voz Accesible."
        )

        mensaje.voice = AVSpeechSynthesisVoice(
            language: codigoIdioma()
        )

        mensaje.rate = Float(velocidad)

        sintetizador.speak(mensaje)
    }

    func detenerVoz() {
        sintetizador.stopSpeaking(at: .immediate)
    }

    func codigoIdioma() -> String {
        switch idiomaSeleccionado {
        case "Español (El Salvador)":
            return "es-SV"

        case "Español (México)":
            return "es-MX"

        case "Español (España)":
            return "es-ES"

        case "English (United States)":
            return "en-US"

        default:
            return "es-SV"
        }
    }
}
