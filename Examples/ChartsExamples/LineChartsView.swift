import SwiftUI
import Charts

struct LineChartsView: View {
    @State var data1: [CGFloat] = (0...20).map { _ in .random(in: 0.1...1.0) }
    @State var data2: [CGFloat] = (0...50).map { _ in .random(in: 0.1...1.0) }
    @State var data3: [CGFloat] = (0...100).map { _ in .random(in: 0.1...1.0) }
    
    @State var data4: [CGFloat] = (0...100).map { _ in .random(in: 0.4...1.0) }
    @State var data5: [CGFloat] = (0...100).map { _ in .random(in: 0.1...0.3) }
    @State var data6: [CGFloat] = (0...100).map { _ in .random(in: 0.3...0.4) }
    
    var body: some View {
        ScrollView {
            Chart(data: data1)
                .chartStyle(
                    LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
                )
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            Chart(data: data2)
                .chartStyle(
                    AreaChartStyle(.quadCurve, fill:
                        LinearGradient(gradient: .init(colors: [Color.red.opacity(0.8), Color.red.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                    )
                )
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            Chart(data: data3)
                .chartStyle(
                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                )
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
            
            ZStack {
                Chart(data: data4)
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: .purple, lineWidth: 3)
                    )
                
                Chart(data: data4)
                    .chartStyle(
                        AreaChartStyle(.quadCurve, fill:
                            LinearGradient(gradient: .init(colors: [Color.purple.opacity(0.8), Color.purple.opacity(0.2)]), startPoint: .top, endPoint: .bottom)
                        )
                    )
                
                Chart(data: data5)
                    .chartStyle(
                        ColumnChartStyle(column: Color.white.opacity(0.5), spacing: 2)
                    )
                
                Chart(data: data6)
                    .chartStyle(
                        LineChartStyle(.line, lineColor: Color.white.opacity(0.2), lineWidth: 3)
                    )
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .frame(height: 300)
                .padding()
        }
    }
}

struct LineChartsView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartsView()
    }
}
