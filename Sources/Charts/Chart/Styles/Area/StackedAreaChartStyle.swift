import SwiftUI
import Shapes

public struct StackedAreaChartStyle: ChartStyle {
    private let lineType: LineType
    private let colors: [Color]
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        ZStack {
            ForEach(Array(configuration.dataMatrix.transpose().stacked().enumerated()), id: \.self.offset) { enumeratedData in
                colors[enumeratedData.offset % colors.count].clipShape(
                    AreaChart(
                        unitData: enumeratedData.element,
                        lineType: self.lineType
                    )
                )
                .zIndex(-Double(enumeratedData.offset))
            }
        }
        .drawingGroup()
    }
    
    public init(_ lineType: LineType = .quadCurve, colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple]) {
        self.lineType = lineType
        self.colors = colors
    }
}

extension Collection where Element == [CGFloat] {
    func stacked() -> [[CGFloat]] {
        self.reduce([]) { (result, element) -> [[CGFloat]] in
            if let lastElement = result.last {
                return result + [zip(lastElement, element).compactMap(+)]
            } else {
                return [element]
            }
        }
    }
}

extension Array where Element == [CGFloat] {
    func transpose() -> [[CGFloat]] {
        let columnsCount = self.first?.count ?? 0
        let rowCount = self.count
        
        return (0..<columnsCount).map { columnIndex in
            (0..<rowCount).map { rowIndex in
                return self[rowIndex][columnIndex]
            }
        }
    }
}
