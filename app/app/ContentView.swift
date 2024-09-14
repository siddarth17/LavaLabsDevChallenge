import SwiftUI

@main
struct appApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
