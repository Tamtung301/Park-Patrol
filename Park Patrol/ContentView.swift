import SwiftUI

struct ContentView: View {
    @FetchRequest(
        entity: Report.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Report.timestamp, ascending: false)],
        animation: .default
    ) var reports: FetchedResults<Report>

    var body: some View {
        NavigationView {
            List(reports) { report in
                VStack(alignment: .leading) {
                    Text("Location: \(report.latitude), \(report.longitude)")
                        .font(.headline)
                    Text("Timestamp: \(report.timestamp ?? Date(), formatter: DateFormatter.shortDate)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
            .navigationTitle("Reports")
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
