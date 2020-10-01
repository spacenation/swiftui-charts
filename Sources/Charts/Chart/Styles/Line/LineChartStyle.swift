import SwiftUI
import Shapes

public struct LineChartStyle: ChartStyle {

    private let lineType: LineType
    private let lineColor: Color
    private let lineWidth: CGFloat

    @Binding private var trimFrom: CGFloat
    @Binding private var trimTo: CGFloat

    @ViewBuilder
    public func makeBody(configuration: Configuration) -> some View {
        switch lineType {
        case .line:
            Line(unitData: configuration.dataMatrix.map { $0.reduce(0, +) })
                .trim(from: trimFrom, to: trimTo)
                .stroke(lineColor, style: .init(lineWidth: lineWidth, lineCap: .round))
        case .quadCurve:
            QuadCurve(unitData: configuration.dataMatrix.map { $0.reduce(0, +) })
                .trim(from: trimFrom, to: trimTo)
                .stroke(lineColor, style: .init(lineWidth: lineWidth, lineCap: .round))
        }
    }
    
    public init(_ lineType: LineType = .quadCurve, lineColor: Color = .accentColor, lineWidth: CGFloat = 1, trimFrom: Binding<CGFloat> = .constant(0), trimTo: Binding<CGFloat> = .constant(1)) {
        self.lineType = lineType
        self.lineColor = lineColor
        self.lineWidth = lineWidth
        _trimFrom = trimFrom
        _trimTo = trimTo
    }
}
