import SwiftUI
import MapKit

struct StoreListView: View {
    // MARK: – ViewModels
    @StateObject private var vm = StoreViewModel()
    @StateObject private var favVM = FavoritesViewModel()

    // MARK: – 本地 State
    @State private var showMap = false
    @State private var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -25.2744, longitude: 133.7751),
        span: MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
    )
    @State private var selectedStore: Store?

    // MARK: – 支持的城市
    private let cities = [
        "All Australia",
        "Sydney",
        "Melbourne",
        "Brisbane",
        "Perth",
        "Adelaide"
    ]

    // MARK: – 过滤后的门店列表
    private var filteredStores: [Store] {
        guard vm.selectedCity != "All Australia" else {
            return vm.stores
        }
        return vm.stores.filter { $0.city == vm.selectedCity }
    }

    var body: some View {
        ZStack {
            // 背景色
            Theme.background
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // 标题
                Text("Stores")
                    .font(.largeTitle).fontWeight(.bold)
                    .foregroundColor(Theme.textPrimary)
                    .padding(.top, 16)

                // 城市下拉 + Map 切换
                HStack {
                    Menu {
                        ForEach(cities, id: \.self) { city in
                            Button(city) {
                                vm.selectedCity = city
                                centerMap(on: city)
                            }
                        }
                    } label: {
                        HStack {
                            Text(vm.selectedCity)
                                .foregroundColor(Theme.textPrimary)
                            Image(systemName: "chevron.down")
                                .font(.caption)
                                .foregroundColor(Theme.textPrimary)
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 12)
                        .background(Theme.surface)
                        .cornerRadius(8)
                    }

                    Spacer()

                    Toggle("Map View", isOn: $showMap)
                        .toggleStyle(SwitchToggleStyle(tint: Theme.accent))
                        .foregroundColor(Theme.textPrimary)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)

                Divider()

                // 列表 / 地图 切换
                if showMap {
                    Map(coordinateRegion: $mapRegion,
                        annotationItems: filteredStores) { store in
                        MapAnnotation(coordinate: store.coordinate) {
                            StoreMarker(store: store)
                                .onTapGesture {
                                    selectedStore = store
                                }
                        }
                    }
                    .ignoresSafeArea(edges: .bottom)
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(filteredStores) { store in
                                StoreCardView(store: store, favVM: favVM)
                                    .diorCardStyle()
                                    .frame(width: 300)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                    }
                }

                Spacer()
            }
        }
        // 弹出详情页
        .sheet(item: $selectedStore) { store in
            StoreDetailView(store: store, favVM: favVM)
        }
        .onAppear {
            centerMap(on: vm.selectedCity)
        }
    }

    // MARK: – 切换城市时更新地图
    private func centerMap(on city: String) {
        switch city {
        case "Sydney":
            mapRegion.center = CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093)
            mapRegion.span   = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        case "Melbourne":
            mapRegion.center = CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631)
            mapRegion.span   = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        case "Brisbane":
            mapRegion.center = CLLocationCoordinate2D(latitude: -27.4698, longitude: 153.0251)
            mapRegion.span   = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        case "Perth":
            mapRegion.center = CLLocationCoordinate2D(latitude: -31.9505, longitude: 115.8605)
            mapRegion.span   = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        case "Adelaide":
            mapRegion.center = CLLocationCoordinate2D(latitude: -34.9285, longitude: 138.6007)
            mapRegion.span   = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        default:
            mapRegion.center = CLLocationCoordinate2D(latitude: -25.2744, longitude: 133.7751)
            mapRegion.span   = MKCoordinateSpan(latitudeDelta: 20, longitudeDelta: 20)
        }
    }
}

// MARK: – 地图标注视图
struct StoreMarker: View {
    let store: Store

    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: "mappin.circle.fill")
                .font(.title)
                .foregroundColor(Theme.accent)
            Text(store.name)
                .font(.caption)
                .foregroundColor(Theme.textPrimary)
        }
        .shadow(radius: 4)
    }
}

// MARK: – 预览
struct StoreListView_Previews: PreviewProvider {
    static var previews: some View {
        StoreListView()
    }
}
