
import SwiftUI
import AVFoundation

struct FrasesView: View {

    private let sintetizador = AVSpeechSynthesizer()

    @State private var fraseSeleccionada: String = ""

    let frases: [String] = [
        "Hola, ¿cómo estás?",
        "Necesito ayuda, por favor.",
        "Tengo hambre.",
        "Tengo sed.",
        "Muchas gracias.",
        "Quiero descansar.",
        "No entiendo.",
        "Por favor, repite.",
        "Me siento bien.",
        "Quiero ir al baño.",
        "Sí",
        "No"
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {

                Text("Frases frecuentes")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                Text("Selecciona una frase para comunicarte.")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                ScrollView {
                    VStack(spacing: 12) {

                        ForEach(frases, id: \.self) { frase in

                            Button(action: {
                                fraseSeleccionada = frase
                                reproducirFrase(frase)
                            }) {

                                HStack {
                                    Text(frase)
                                        .font(.headline)
                                        .foregroundColor(.blue)

                                    Spacer()

                                    Image(systemName: "speaker.wave.2.fill")
                                        .foregroundColor(.blue)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue.opacity(0.08))
                                .cornerRadius(12)
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                if !fraseSeleccionada.isEmpty {
                    Text("Frase seleccionada: \(fraseSeleccionada)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                }

                Button(action: detenerVoz) {
                    Label("Detener voz", systemImage: "stop.fill")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("Comunicación")
        }
    }

    func reproducirFrase(_ frase: String) {
        sintetizador.stopSpeaking(at: .immediate)

        let mensaje = AVSpeechUtterance(string: frase)
        mensaje.voice = AVSpeechSynthesisVoice(language: "es-SV")
        mensaje.rate = AVSpeechUtteranceDefaultSpeechRate

        sintetizador.speak(mensaje)
    }

    func detenerVoz() {
        sintetizador.stopSpeaking(at: .immediate)
    }
}
