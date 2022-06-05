//
//  MapViewController.swift
//  SampleEmployeeListApp
//
//  Created by Vishnu Haridas on 05/06/22.
//

import Foundation
import MapKit


class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var lat: String = ""
    var lng: String = ""
    var coordinates: CLLocationCoordinate2D?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        let addAnotation = MKPointAnnotation()
        if let latDegree  = CLLocationDegrees(lat), let longDegree = CLLocationDegrees(lng) {
            let coords = CLLocationCoordinate2DMake(latDegree, longDegree)
            addAnotation.coordinate = CLLocationCoordinate2D(latitude: coords.latitude, longitude: coords.longitude)
            self.mapView.showAnnotations([addAnotation], animated: true)
        }
        
       
        mapView.delegate = self
        
    }
    
    
    
}


extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }

        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }

        return annotationView
    }
}
