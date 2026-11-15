
import SwiftUI

struct ContentView: View {

    var body: some View {
        TabView {

            pantallaPrincipal
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Inicio")
                }

            FrasesView()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Frases")
                }

            CategoriasView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Categorías")
                }

            MisFrasesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                    Text("Mis frases")
                }

            AgregarFraseView()
                .tabItem {
                    Image(systemName: "plus.circle.fill")
                    Text("Agregar")
                }

            ConfiguracionView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("Ajustes")
                }
        }
        .tint(.blue)
    }

    // MARK: - Pantalla principal

    var pantallaPrincipal: some View {

        NavigationView {
            ScrollView {
                VStack(spacing: 20) {

                    Image(systemName: "waveform.circle.fill")
                        .font(.system(size: 85))
                        .foregroundColor(.blue)

                    Text("Voz Accesible")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.blue)

                    Text("Expresa tus ideas mediante la voz.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)

                    NavigationLink(destination: FrasesView()) {
                        botonMenu(
                            titulo: "Frases frecuentes",
                            icono: "quote.bubble.fill",
                            color: .blue
                        )
                    }

                    NavigationLink(destination: CategoriasView()) {
                        botonMenu(
                            titulo: "Categorías de mensajes",
                            icono: "square.grid.2x2.fill",
                            color: .green
                        )
                    }

                    NavigationLink(destination: MisFrasesView()) {
                        botonMenu(
                            titulo: "Mis frases guardadas",
                            icono: "bookmark.fill",
                            color: .purple
                        )
                    }

                    NavigationLink(destination: AgregarFraseView()) {
                        botonMenu(
                            titulo: "Agregar una frase",
                            icono: "plus.circle.fill",
                            color: .orange
                        )
                    }

                    NavigationLink(destination: ConfiguracionView()) {
                        botonMenu(
                            titulo: "Configuración",
                            icono: "gearshape.fill",
                            color: .gray
                        )
                    }

                    Text("Una herramienta de comunicación accesible.")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                        .padding(.top, 10)
                }
                .padding()
            }
            .navigationTitle("Inicio")
        }
    }

    // MARK: - Diseño de botones

    func botonMenu(
        titulo: String,
        icono: String,
        color: Color
    ) -> some View {

        Label(titulo, systemImage: icono)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .padding()
            .background(color)
            .foregroundColor(.white)
            .cornerRadius(12)
    }
}
