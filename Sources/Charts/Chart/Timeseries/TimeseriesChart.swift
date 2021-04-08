//
//  File.swift
//  
//
//  Created by Alexander Heinrich on 08.04.21.
//

import Foundation
import SwiftUI
import Shapes

public struct TimeseriesChart: View {
    private let lineColors: [Color]
    private let lineWidth: CGFloat
    
    @Binding private var trimFrom: CGFloat
    @Binding private var trimTo: CGFloat
    
    private let timeseriesData: [[Float]]
    
    public init(_ timeseriesData: [[Float]], lineColors: [Color], lineWidth: CGFloat = 1, trimFrom: Binding<CGFloat> = .constant(0), trimTo: Binding<CGFloat> = .constant(1)) {
        self.timeseriesData = timeseriesData
        self.lineColors = lineColors
        self.lineWidth = lineWidth
        _trimFrom = trimFrom
        _trimTo = trimTo
    }
    
    public var body: some View {
        ZStack {
            ForEach(0..<self.timeseriesData.count) { (idx) in
                Chart(data: self.timeseriesData[idx])
                    .chartStyle(LineChartStyle(.line, lineColor: self.lineColors[idx], lineWidth: self.lineWidth))
            }
        }
    }
    
    public struct TimeEntry {
        let x: String
        let y: Float
    }
}
