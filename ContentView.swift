
import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {

            // Pantalla de comunicación
            pantallaPrincipal
                .tabItem {
                    Image(systemName: "text.bubble.fill")
                    Text("Comunicación")
                }

            // Frases frecuentes
            FrasesView()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Frases")
                }

            // Categorías de mensajes
            CategoriasView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Categorías")
                }

            // Configuración
            ConfiguracionView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Ajustes")
                }
        }
        .tint(.blue)
    }

    var pantallaPrincipal: some View {
        NavigationView {
            VStack(spacing: 25) {

                Image(systemName: "waveform.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)

                Text("Voz Accesible")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)

                Text("Una forma sencilla de expresar tus ideas.")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)

                NavigationLink(destination: FrasesView()) {
                    Label(
                        "Frases frecuentes",
                        systemImage: "quote.bubble.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                NavigationLink(destination: CategoriasView()) {
                    Label(
                        "Categorías de mensajes",
                        systemImage: "square.grid.2x2.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                NavigationLink(destination: ConfiguracionView()) {
                    Label(
                        "Configuración",
                        systemImage: "gearshape.fill"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Inicio")
        }
    }
}
