

import Foundation

struct EventTrackerModel: Codable {
    var event: Int?
    var methods: Int?
    var url: String?
    var ext: ExtModel?
}

struct ExtModel: Codable {
    var vendorKey: String?
    var verification_parameters: String?
}
