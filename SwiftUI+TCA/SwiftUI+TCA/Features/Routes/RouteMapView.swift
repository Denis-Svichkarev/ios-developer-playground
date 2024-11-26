//
//  RouteMapView.swift
//  SwiftUI+TCA
//
//  Created by Denis Svichkarev on 26/11/24.
//

import SwiftUI
import MapKit

struct RouteMapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    let route: Route
    let onAppear: () -> Void
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        if let first = route.locations.first {
            let startAnnotation = RouteAnnotation(
                coordinate: first.coordinate,
                type: .start
            )
            mapView.addAnnotation(startAnnotation)
        }
        
        if let last = route.locations.last {
            let endAnnotation = RouteAnnotation(
                coordinate: last.coordinate,
                type: .end
            )
            mapView.addAnnotation(endAnnotation)
        }
        
        // Добавляем линию маршрута
        let polyline = MKPolyline(
            coordinates: route.locations.map { $0.coordinate },
            count: route.locations.count
        )
        mapView.addOverlay(polyline)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(region, animated: true)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Coordinator для обработки делегатов карты
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: RouteMapView
        
        init(_ parent: RouteMapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let routeAnnotation = annotation as? RouteAnnotation else {
                return nil
            }
            
            let identifier = "RouteMarker"
            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            
            // Create UIView from SwiftUI RouteMarker
            let markerType: RouteMarker.MarkerType = routeAnnotation.type == .start ? .start : .end
            let routeMarker = RouteMarker(type: markerType)
            let hostingController = UIHostingController(rootView: routeMarker)
            hostingController.view.backgroundColor = .clear
            
            annotationView.addSubview(hostingController.view)
            hostingController.view.frame = CGRect(x: -6, y: -6, width: 12, height: 12)
            
            return annotationView
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let renderer = MKPolylineRenderer(overlay: polyline)
                renderer.strokeColor = .systemBlue
                renderer.lineWidth = 4
                return renderer
            }
            return MKOverlayRenderer()
        }
        
        func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
            parent.region = mapView.region
        }
    }
}

class RouteAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let type: AnnotationType
    
    enum AnnotationType {
        case start
        case end
    }
    
    init(coordinate: CLLocationCoordinate2D, type: AnnotationType) {
        self.coordinate = coordinate
        self.type = type
        super.init()
    }
}

struct RouteMarker: View {
    let type: MarkerType
    
    enum MarkerType {
        case start
        case end
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(type == .start ? Color.green : Color.red)
                .frame(width: 12, height: 12)
            
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: 12, height: 12)
        }
    }
}
