import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ChartsView()
                .navigationBarTitle("Charts")
        }
        .navigationViewStyle(
            StackNavigationViewStyle()
        )
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
