import SwiftUI
import MapKit

struct StoreMapView: View {
    let stores: [Store]
    @State private var region: MKCoordinateRegion

    init(stores: [Store]) {
        self.stores = stores
        let center = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.21)
        self._region = State(initialValue: MKCoordinateRegion(
            center: center,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))
    }

    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: stores) { store in
            MapAnnotation(coordinate: CLLocationCoordinate2D(
                latitude: store.latitude,
                longitude: store.longitude
            )) {
                VStack {
                    Image(systemName: "mappin.circle.fill")
                        .font(.title2)
                        .foregroundColor(stockColor(for: store))
                    Text(store.name)
                        .font(.caption)
                }
            }
        }
    }

    private func stockColor(for store: Store) -> Color {
        if store.stock > 10 { .green }
        else if store.stock > 0 { .yellow }
        else { .red }
    }
}
