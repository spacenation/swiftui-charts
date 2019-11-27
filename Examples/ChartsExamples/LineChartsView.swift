import SwiftUI
import Charts

struct LineChartsView: View {
    var body: some View {
        ScrollView {
            ZStack {
                Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
                    )
                
                Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
                    .chartStyle(
                        AreaChartStyle(.quadCurve, fill:
                            LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
                        )
                    )
            }
            .frame(height: 300)
        }
    }
}

struct LineChartsView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartsView()
    }
}
