import SwiftUI
import Shapes

public struct ColumnChartStyle<Column: View>: ChartStyle {
    private let column: Column
    private let spacing: CGFloat
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        let data: [ColumnData] = configuration.dataMatrix
            .map { $0.reduce(0, +) }
            .enumerated()
            .map { ColumnData(id: $0.offset, data: $0.element) }
        
        let hasNegativeValues = data.contains(where: {$0.data < 0})
        
        return GeometryReader { geometry in
            self.columnChart(in: geometry, data: data, hasNegativeValues: hasNegativeValues)
        }
    }
    
    private func columnChart(in geometry: GeometryProxy, data: [ColumnData], hasNegativeValues: Bool) -> some View {
        let columnWidth = (geometry.size.width - (CGFloat(data.count - 1) * spacing)) / CGFloat(data.count)
    
        return ZStack(alignment: .center) {

            HStack(alignment: hasNegativeValues ? .center : .bottom, spacing: spacing) {
                ForEach(data) { element in
                    self.column
                        .frame(width: columnWidth, height: self.columnHeight(data: element.data, in: geometry.size.height, hasNegativeValues: hasNegativeValues))
                        .offset(self.offset(for: element, geometry: geometry, columnWidth: columnWidth, dataCount: data.count, hasNegativeValues: hasNegativeValues))
                }
            }
           
        }
        .frame(width: geometry.size.width, height: geometry.size.height, alignment: hasNegativeValues ? .center : .bottom)
        .background(ZStack {
            if hasNegativeValues {
                Path { path in
                    path.addLine(from: CGPoint(x: 0, y:geometry.size.height/2), to: CGPoint(x: geometry.size.width, y: geometry.size.height/2))
                }
                .stroke(Color.gray.opacity(0.8), style: .init(lineWidth: 1, lineCap: .round))
            }
        })
    }
    
    private func offset(for element: ColumnData, geometry: GeometryProxy, columnWidth: CGFloat, dataCount: Int, hasNegativeValues: Bool) -> CGSize {
        let x: CGFloat = 0
        var y: CGFloat = 0
        let height = self.columnHeight(data: element.data, in: geometry.size.height, hasNegativeValues: hasNegativeValues)
        
        if hasNegativeValues {
            if element.data > 0 {
                y = -height/2
            }else {
                y = height/2
            }
        }
        
        return CGSize(width: x, height: y)
    }
    
    private func columnHeight(data: CGFloat, in availableHeight: CGFloat, hasNegativeValues: Bool) -> CGFloat {
        let height = availableHeight * abs(data)
        if hasNegativeValues {
            return height/2
        }
        return height
    }
    
    private func bottomAlignmentGuide(dimension: ViewDimensions, for data:CGFloat, in availableHeight: CGFloat, hasNegativeValues: Bool) -> CGFloat {
        let height = self.columnHeight(data: data, in: availableHeight, hasNegativeValues: hasNegativeValues)
        if data < 0 {
             return availableHeight/2 - height
        }else if hasNegativeValues {
             return availableHeight/2 + height
        }
        
        return height
    }
    
    private func leadingAlignmentGuide(for index: Int, in availableWidth: CGFloat, dataCount: Int) -> CGFloat {
        let columnWidth = (availableWidth - (CGFloat(dataCount - 1) * spacing)) / CGFloat(dataCount)
        return availableWidth - (CGFloat(index) * columnWidth) + (CGFloat(index - 1) * spacing)
    }
    
    public init(column: Column, spacing: CGFloat = 8) {
        self.column = column
        self.spacing = spacing
    }
}

struct ColumnData: Identifiable {
    let id: Int
    let data: CGFloat
}

public struct DefaultColumnView: View {
    public var body: some View {
        Rectangle().foregroundColor(.accentColor)
    }
}

public extension ColumnChartStyle where Column == DefaultColumnView {
    init(spacing: CGFloat = 8) {
        self.init(column: DefaultColumnView(), spacing: spacing)
    }
}


struct ColumnChartPreview: PreviewProvider {
    
    @State static var data3: [CGFloat] = [-0.5,-0.2,-0.1,0.1,0.2,0.5,1]
    @State static var data4: [CGFloat] = [0.1,0.2,0.5,0.9]
    
    static var previews: some View {
        Group {
            Chart(data: data3)
                .chartStyle(
                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                )
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .padding()
            
            Chart(data: data4)
                .chartStyle(
                    ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
                )
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .padding()
        }
       
    }
}
