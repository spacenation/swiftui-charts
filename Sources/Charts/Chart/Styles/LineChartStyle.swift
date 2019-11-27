import SwiftUI
import Shapes

public struct LineChartStyle: ChartStyle {
    private let lineColor: Color
    private let lineWidth: CGFloat
    
    public func makeBody(configuration: Self.Configuration) -> some View {
        QuadCurve(unitData: configuration.data)
            .stroke(self.lineColor, style: .init(lineWidth: self.lineWidth, lineCap: .round))
    }
    
    public init(lineColor: Color = .accentColor, lineWidth: CGFloat = 1) {
        self.lineColor = lineColor
        self.lineWidth = lineWidth
    }
}
