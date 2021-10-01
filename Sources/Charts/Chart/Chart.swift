import SwiftUI
@_exported import Shapes

public struct Chart: View {
    @Environment(\.chartStyle) private var style
    
    private var configuration: ChartStyleConfiguration
    
    public var body: some View {
        self.style.makeBody(configuration: self.configuration)
    }
}

extension Chart {
    init(_ configuration: ChartStyleConfiguration) {
        self.configuration = configuration
    }
}

extension Chart {
    public init<Data: RandomAccessCollection>(data: Data) where Data.Element : BinaryFloatingPoint {
        self.init(ChartStyleConfiguration(dataMatrix: data.map { [CGFloat($0)] }))
    }
    
    public init<Data: RandomAccessCollection>(data: [Data]) where Data.Element : BinaryFloatingPoint {
        self.init(ChartStyleConfiguration(dataMatrix: data.map({ $0.map { CGFloat($0) } })))
    }
}

struct Chart_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LineChartDemo()
            AreaChartDemo()
            ColumnChartDemo()
            BarChartDemo()
            StackedAreaChartDemo()
            CompositeChartDemo()
        }
    }
}


private struct LineChartDemo: View {
    @State var data1: [CGFloat] = (2010...2020).map { _ in .random(in: 0.0...1.0) }
    @State var trim: CGFloat = 0
    
    var body: some View {
        HStack {
            VStack {
                AxisLabels(.vertical, data: (-10...10).reversed(), id: \.self) {
                    Text("\($0 * 10)")
                        .fontWeight(.bold)
                        .font(Font.system(size: 8))
                        .foregroundColor(.secondary)
                }
                .frame(width: 20)

                Rectangle().foregroundColor(.clear).frame(width: 20, height: 20)
            }


            VStack {
                Chart(data: data1)
                    .chartStyle(
                        LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5, trimTo: $trim)
                    )
                    .padding()
                    .background(
                        GridPattern(horizontalLines: 20 + 1, verticalLines: data1.count + 1)
                            .inset(by: 1)
                            .stroke(Color.gray.opacity(0.1), style: .init(lineWidth: 2, lineCap: .round))
                    )
                    .onAppear {
                         trim = 0
                         withAnimation(.easeInOut(duration: 3)) {
                             trim = 1
                         }
                     }


                AxisLabels(.horizontal, data: 2010...2020, id: \.self) {
                    Text("\($0)".replacingOccurrences(of: ",", with: ""))
                        .fontWeight(.bold)
                        .font(Font.system(size: 8))
                        .foregroundColor(.secondary)
                }
                .frame(height: 20)
                .padding(.horizontal, 1)
            }
            .layoutPriority(1)
        }
        .padding()
    }
}

private struct AreaChartDemo: View {
    @State var data2: [CGFloat] = (0..<50).map { _ in .random(in: 0.1...1.0) }
    
    var body: some View {
        Chart(data: data2)
            .chartStyle(
                AreaChartStyle(.quadCurve, fill: LinearGradient(gradient: .init(colors: [Color.red.opacity(0.8), Color.red.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
            )
            .background(
                Color.gray.opacity(0.1)
                    .overlay(
                        GridPattern(horizontalLines: data2.count)
                            .inset(by: 1)
                            .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                    )
            )
            .cornerRadius(16)
            .padding()
    }
}

private struct ColumnChartDemo: View {
    @State var data3: [CGFloat] = [-0.5,-0.2,-0.1,0.1,0.2,0.5,1]
    
    var body: some View {
        Chart(data: data3)
            .chartStyle(
                ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
            )
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
            .padding()
    }
}

private struct BarChartDemo: View {
    @State var data3: [CGFloat] = (0..<10).map { _ in .random(in: 0.1...1.0) }
    
    var body: some View {
        Chart(data: data3)
            .chartStyle(
                BarChartStyle(bar: Capsule().foregroundColor(.green), spacing: 2)
            )
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
            .padding()
    }
}

private struct StackedAreaChartDemo: View {
    @State var matrixData: [[CGFloat]] = (0..<20).map { _ in (0..<3).map { _ in CGFloat.random(in: 0.00...0.33) } }
    
    var body: some View {
        Chart(data: matrixData)
            .chartStyle(
                StackedAreaChartStyle(.quadCurve, colors: [.yellow, .orange, .red])
            )
            .background(
                Color.gray.opacity(0.1)
                    .overlay(
                        GridPattern(verticalLines: matrixData.count)
                            .inset(by: 1)
                            .stroke(Color.red.opacity(0.2), style: .init(lineWidth: 1, lineCap: .round))
                    )
            )
            .cornerRadius(16)
            .padding()
    }
}

private struct CompositeChartDemo: View {
    @State var data4: [CGFloat] = (0..<100).map { _ in .random(in: 0.4...1.0) }
    @State var data5: [CGFloat] = (0..<100).map { _ in .random(in: 0.1...0.3) }
    @State var data6: [CGFloat] = (0..<100).map { _ in .random(in: 0.3...0.4) }
    
    var body: some View {
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
        .padding()
    }
}
