import Foundation
import MapKit

struct Store: Identifiable, Codable {
    // 把 id 改成 String，与 stores.json 里的 "id": "westfield" 对应
    let id: String
    let name: String
    let city: String
    let stock: Int
    let hours: String
    let phone: String
    let crowd: String
    let latitude: Double
    let longitude: Double

    // MARK: – MapKit 坐标
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // MARK: – 拥挤度文本
    var crowdDescription: String {
        crowd
    }
}
