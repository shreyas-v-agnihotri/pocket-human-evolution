//
//  MapViewController.swift
//  Human Evolution Mobile
//
//  Created by Shreyas Agnihotri on 11/5/20.
//  Copyright © 2020 Shreyas Agnihotri. All rights reserved.
//

import UIKit
import MapKit
import GoogleMaps
import Presentr

class MapViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var mapFrame: UIView!
    @IBOutlet weak var reCenterButton: UIButton!
    @IBOutlet weak var speciesCountLabel: UILabel!
    
    let monkeyPin = UIImage(named: "monkey-head-icon")?.scaled(newSize: CGSize(width: 37.5, height: 52))
    let africaZoom = GMSCameraPosition.camera(withLatitude: 23.8859, longitude: 45.0792, zoom: 1.0)
    var activeMarkers: [String] = []
    var mapView: GMSMapView = GMSMapView.map(withFrame: .zero, camera: .init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        slider.minimumValue = 0
        slider.maximumValue = 7.00
        slider.setValue(0.0, animated: true)
        sliderDragged(self)
    
        mapView = GMSMapView.map(withFrame: mapFrame.frame, camera: africaZoom)
        mapView.mapType = .satellite
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        reCenterButton.backgroundColor = .white
        reCenterButton.layer.cornerRadius = reCenterButton.frame.height / 2
        reCenterButton.layer.borderWidth = 1
        reCenterButton.layer.borderColor = UIColor.clear.cgColor
        self.view.bringSubviewToFront(reCenterButton)
        
        self.view.bringSubviewToFront(speciesCountLabel)
                
        plotPins(year: Double(exactly: slider.value)!)
    }

    @IBAction func sliderDragged(_ sender: Any) {
        
        let sliderValueRounded = round(100 * slider.value) / 100

        slider.setValue(sliderValueRounded, animated: true)
        yearLabel.text = "\(sliderValueRounded) million years ago"
        plotPins(year: Double(exactly: slider.value)!)
    }
    
    func plotPins(year: Double) {
        
        mapView.clear()
        let lastActiveMarkers = activeMarkers
        activeMarkers = []
        
        for (name, information) in species {
            
            if ((information["existedUntil"] as! Double) <= year && year <= (information["existedFrom"] as! Double)) {
                // Creates a marker in the center of the map.
                let marker = GMSMarker()
                marker.position = CLLocationCoordinate2D(latitude: information["latitude"] as! CLLocationDegrees, longitude: information["longitude"] as! CLLocationDegrees)
                marker.appearAnimation = lastActiveMarkers.contains(name) ? .none : .pop
                marker.title = name
                marker.icon = monkeyPin
                marker.map = mapView
                activeMarkers += [name]
            }
        }
        
        speciesCountLabel.text = "\(activeMarkers.count) active species"
    }
    
    @IBAction func reCenterMapTapped(_ sender: Any) {
        mapView.animate(to: africaZoom)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        let presenter = Presentr(presentationType: .bottomHalf)
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CardTableViewController") as! CardTableViewController
        
        controller.speciesName = marker.title!
        controller.speciesDetails = species[marker.title!]!
        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
        return true
    }
}


private extension UIImage {
    
    func scaled(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image.withRenderingMode(self.renderingMode)
    }
    
    func recolored(color: UIColor) -> UIImage? {
        let maskImage = cgImage!

        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)

        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)

        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
}
