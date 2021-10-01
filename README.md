## SwiftUI Charts
Build custom charts with SwiftUI

<center>
<img src="Resources/customChart.png"/>
</center>

## Styles

### Line
<center>
<img src="Resources/lineChart.png"/>
</center>

```swift
Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
    .chartStyle(
        LineChartStyle(.quadCurve, lineColor: .blue, lineWidth: 5)
    )
```

### Area
<center>
<img src="Resources/areaChart.png"/>
</center>

```swift
Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
    .chartStyle(
        AreaChartStyle(.quadCurve, fill:
            LinearGradient(gradient: .init(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.05)]), startPoint: .top, endPoint: .bottom)
        )
    )
```

### Stacked Area

```swift
Chart(data: matrix)
    .chartStyle(
        StackedAreaChartStyle(.quadCurve, colors: [.yellow, .orange, .red])
    )
```

### Column
<center>
<img src="Resources/columnChart.png"/>
</center>

```swift
Chart(data: [0.1, 0.3, 0.2, 0.5, 0.4, 0.9, 0.1])
    .chartStyle(
        ColumnChartStyle(column: Capsule().foregroundColor(.green), spacing: 2)
    )
```

### Stacked Column

```swift
Chart(data: matrix)
    .chartStyle(
        StackedColumnChartStyle(spacing: 2, cornerRadius: 3, colors: [.yellow, .orange, .red])
    )
```

## Install
Add `Charts` to your project with Swift Package Manager

```swift
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT",
    dependencies: [
        .package(url: "https://github.com/spacenation/swiftui-charts.git", from: "1.0.0"),
    ]
)
```

## Roadmap
-  Bar chart style

## Code Contributions
Feel free to contribute via fork/pull request to master branch. If you want to request a feature or report a bug please start a new issue.
