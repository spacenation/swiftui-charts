
import Shapes
import SwiftUI

public struct BarChartStyle<Bar: View>: ChartStyle {
    
    private let bar: Bar
    private let spacing: CGFloat
    
    public init(bar: Bar, spacing: CGFloat = 0) {
        self.bar = bar
        self.spacing = spacing
    }

    
    public func makeBody(configuration: Configuration) -> some View {
        let data: [ColumnData] = configuration.dataMatrix
            .map { $0.reduce(0, +) }
            .enumerated()
            .map { ColumnData(id: $0.offset, data: $0.element) }
        
        return GeometryReader { geometry in
            self.barChart(in: geometry, data: data)
        }
    }
    
    func barChart(in geometry: GeometryProxy, data: [ColumnData]) -> some View {
        let barHeight = (geometry.size.height - (CGFloat(data.count - 1) * spacing)) / CGFloat(data.count)
        
        return ZStack(alignment: .topLeading) {
            ForEach(data) { element in
                self.bar
                    .alignmentGuide(.top, computeValue: { dimension in
                        CGFloat(element.id) * (spacing + barHeight)
                    })
                    .frame(width: element.data * geometry.size.width, height: barHeight)
            }
        }
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .bottom)
    }

}
