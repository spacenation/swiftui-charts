import SwiftUI
import Charts

struct LineChartsView: View {
    var body: some View {
        Chart(data: [0.1, 0.9, 0.1])
            .frame(height: 300)
            .chartStyle(
                LineChartStyle(lineColor: .blue, lineWidth: 3)
            )
    }
}

struct LineChartsView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartsView()
    }
}
