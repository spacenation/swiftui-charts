import SwiftUI

struct ContentView: View {
    @State private var selection = 0
 
    var body: some View {
        TabView(selection: $selection) {
            LineChartsView()
                .font(.title)
                .tabItem {
                    VStack {
                        Image(systemName: "arrow.swap")
                        Text("Line")
                    }
                }
                .tag(0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
