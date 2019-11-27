import SwiftUI
import Shapes

public struct AreaChartStyle<Fill: View>: ChartStyle {
    private let lineType: LineType
    private let fill: Fill
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        fill.clipShape(
            ChartArea(unitData: configuration.data, lineType: self.lineType)
        )
    }
    
    public init(_ lineType: LineType = .quadCurve, fill: Fill) {
        self.lineType = lineType
        self.fill = fill
    }
}

private struct ChartArea: Shape {
    private let lineType: LineType
    private let unitPoints: [UnitPoint]

    public func path(in rect: CGRect) -> Path {
        Path { path in
            switch self.lineType {
            case .line:
                path.addLines(self.unitPoints.points(in: rect))
            case .quadCurve:
                path.addQuadCurves(self.unitPoints.points(in: rect))
            }
            path.addLine(to: CGPoint(unitPoint: .topTrailing, in: rect))
            path.addLine(to: CGPoint(unitPoint: .topLeading, in: rect))
            
            path.closeSubpath()
        }
    }
    
    init<Data: RandomAccessCollection>(unitData: Data, lineType: LineType) where Data.Element : BinaryFloatingPoint {
        self.lineType = lineType
        let step: CGFloat = unitData.count > 1 ? 1.0 / CGFloat(unitData.count - 1) : 1.0
        self.unitPoints = unitData.enumerated().map { (index, dataPoint) in UnitPoint(x: step * CGFloat(index), y: CGFloat(dataPoint)) }
    }
}
