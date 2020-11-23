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
import Instructions

class MapViewController: UIViewController, GMSMapViewDelegate, CoachMarksControllerDataSource, CoachMarksControllerDelegate {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var mapFrame: UIView!
    @IBOutlet weak var reCenterButton: UIButton!
    @IBOutlet weak var speciesCountLabel: UILabel!
    
    let coachMarksController = CoachMarksController()
    var coachMarksViews: [UIView] = []
    let coachMarksMessages = [
        "Welcome to the Human Evolution Timeline! We're starting in the present day, but you can explore our evolutionary past up to 7 million years ago.",
        "Use this slider to change the point in time represented by the map. The map will then refresh.",
        "Early human species often coexisted. This label tells you how many different species of early human were thought to exist during the time period you selected.",
        "Each pin on the map represents a species of early human in a certain region of the world. Pinch and zoom around the map, selecting any pin to learn about a species. If you need, click this button to zoom the map back out. Let's get started!"
    ]
    
    let monkeyPin = UIImage(named: "monkey-head-icon")?.scaled(newSize: CGSize(width: 37.5, height: 52))
    let africaEuropeAsiaZoom = GMSCameraPosition.camera(withLatitude: 10, longitude: 45, zoom: 1.0)
    var activeMarkers: Set<String> = Set()
    var mapView: GMSMapView = GMSMapView.map(withFrame: .zero, camera: .init())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.coachMarksController.dataSource = self
        self.coachMarksController.overlay.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        coachMarksViews = [yearLabel, slider, speciesCountLabel, reCenterButton]
        
        slider.minimumValue = 0
        slider.maximumValue = 7.00
        slider.setValue(0.0, animated: true)
        sliderDragged(self)
    
        mapView = GMSMapView.map(withFrame: mapFrame.frame, camera: africaEuropeAsiaZoom)
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
    
    // MARK: Guided Tutorial Configuration
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.coachMarksController.start(in: .window(over: self))
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.coachMarksController.stop(immediately: true)
    }
    
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return coachMarksMessages.count
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        return coachMarksController.helper.makeCoachMark(for: coachMarksViews[index])
    }
    
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: UIView & CoachMarkBodyView, arrowView: (UIView & CoachMarkArrowView)?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(
            withArrow: true,
            arrowOrientation: coachMark.arrowOrientation
        )

        coachViews.bodyView.hintLabel.text = coachMarksMessages[index]
        coachViews.bodyView.nextLabel.text = (index == coachMarksMessages.count - 1) ? "Start" : "Next"

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
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
                for (latitude, longitude) in information["pins"] as! Array<(CLLocationDegrees, CLLocationDegrees)> {
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    marker.appearAnimation = lastActiveMarkers.contains(name) ? .none : .pop
                    marker.title = name
                    marker.icon = monkeyPin
                    marker.map = mapView
                }
                activeMarkers.insert(name)
            }
        }
        
        speciesCountLabel.text = "\(activeMarkers.count) active species"
    }
    
    @IBAction func reCenterMapTapped(_ sender: Any) {
        mapView.animate(to: africaEuropeAsiaZoom)
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
}
