import Foundation

struct TDD_averages: JSON, Equatable {
    var average_total_data: Decimal
    var weightedAverage: Decimal
    var past2hoursAverage: Decimal
    var date: Date

    init(
        average_total_data: Decimal,
        weightedAverage: Decimal,
        past2hoursAverage: Decimal,
        date: Date
    ) {
        self.average_total_data = average_total_data
        self.weightedAverage = weightedAverage
        self.past2hoursAverage = past2hoursAverage
        self.date = date
    }
}

extension TDD_averages {
    private enum CodingKeys: String, CodingKey {
        case average_total_data
        case weightedAverage
        case past2hoursAverage
        case date
    }
}
