
import SwiftUI
import AVFoundation

struct CategoriasView: View {

    let categorias: [CategoriaMensaje] = [
        CategoriaMensaje(
            nombre: "Necesidades básicas",
            icono: "heart.fill",
            frases: [
                "Tengo hambre.",
                "Tengo sed.",
                "Quiero descansar.",
                "Quiero ir al baño."
            ]
        ),
        CategoriaMensaje(
            nombre: "Salud",
            icono: "cross.case.fill",
            frases: [
                "No me siento bien.",
                "Me duele algo.",
                "Necesito un médico.",
                "Necesito mi medicamento."
            ]
        ),
        CategoriaMensaje(
            nombre: "Emociones",
            icono: "face.smiling",
            frases: [
                "Estoy feliz.",
                "Estoy triste.",
                "Estoy preocupado.",
                "Estoy tranquilo."
            ]
        ),
        CategoriaMensaje(
            nombre: "Social",
            icono: "person.2.fill",
            frases: [
                "Hola, ¿cómo estás?",
                "Muchas gracias.",
                "Por favor.",
                "Hasta luego."
            ]
        ),
        CategoriaMensaje(
            nombre: "Ayuda",
            icono: "hand.raised.fill",
            frases: [
                "Necesito ayuda.",
                "No entiendo.",
                "Por favor, repite.",
                "Acompáñame, por favor."
            ]
        )
    ]

    var body: some View {
        NavigationView {
            List {
                ForEach(categorias) { categoria in
                    NavigationLink(
                        destination: DetalleCategoriaView(
                            categoria: categoria
                        )
                    ) {
                        HStack(spacing: 15) {
                            Image(systemName: categoria.icono)
                                .font(.title2)
                                .foregroundColor(.blue)
                                .frame(width: 40)

                            Text(categoria.nombre)
                                .font(.headline)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Categorías")
        }
    }
}

struct CategoriaMensaje: Identifiable {
    let id = UUID()
    let nombre: String
    let icono: String
    let frases: [String]
}

struct DetalleCategoriaView: View {

    let categoria: CategoriaMensaje

    private let sintetizador = AVSpeechSynthesizer()

    var body: some View {
        VStack(spacing: 15) {

            Text(categoria.nombre)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)

            Text("Selecciona un mensaje para reproducirlo.")
                .font(.subheadline)
                .foregroundColor(.gray)

            ScrollView {
                VStack(spacing: 12) {
                    ForEach(categoria.frases, id: \.self) { frase in
                        Button(action: {
                            reproducirFrase(frase)
                        }) {
                            HStack {
                                Text(frase)
                                    .font(.headline)

                                Spacer()

                                Image(systemName: "speaker.wave.2.fill")
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                        }
                    }
                }
                .padding()
            }

            Button(action: {
                sintetizador.stopSpeaking(at: .immediate)
            }) {
                Label("Detener voz", systemImage: "stop.fill")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .padding(.top)
        .navigationTitle("Mensajes")
    }

    func reproducirFrase(_ frase: String) {
        sintetizador.stopSpeaking(at: .immediate)

        let mensaje = AVSpeechUtterance(string: frase)
        mensaje.voice = AVSpeechSynthesisVoice(language: "es-SV")
        mensaje.rate = AVSpeechUtteranceDefaultSpeechRate

        sintetizador.speak(mensaje)
    }
}
