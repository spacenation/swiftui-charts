import SwiftUI
import Shapes

public struct AreaChartStyle<Fill: View>: ChartStyle {
    private let lineType: LineType
    private let fill: Fill
    private let yMirror: Bool
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        fill
            .clipShape(
                AreaChart(unitData: configuration.dataMatrix.map { $0.reduce(0, +) }, lineType: self.lineType, yMirror: yMirror)
            )
    }
    
    public init(_ lineType: LineType = .quadCurve, fill: Fill, yMirror: Bool = false) {
        self.lineType = lineType
        self.fill = fill
        self.yMirror = yMirror
    }
}
