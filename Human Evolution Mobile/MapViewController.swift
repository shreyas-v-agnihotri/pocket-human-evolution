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

    // Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var mapFrame: UIView!
    @IBOutlet weak var reCenterButton: UIButton!
    @IBOutlet weak var speciesCountLabel: UILabel!
    @IBOutlet weak var helpButton: UIButton!
    
    // Onboarding
    let coachMarksController = CoachMarksController()
    var coachMarksViews: [UIView] = []
    let coachMarksMessages = [
        "Welcome to the Human Evolution Timeline! We're starting in the present day, but you can explore our evolutionary past up to 7 million years ago, when our lineage began.",
        "Use this slider to move to the point in time you want to explore. This will update the species displayed on the map.",
        "This is the map. Each pin represents a species of early human in that general region of the world during the time period you selected. Tap any pin to learn about that species and where it lived.",
        "Early human species often coexisted. This label tells you how many different species of early human are currently shown on the map. Pins from the same species have the same color, to help you tell them apart.",
        "Be careful: for some periods of time, this label will show 0 active species. This just means we have yet to find the fossils necessary to classify the species alive at that time. Paleontology is a constantly-evolving field, and new discoveries will help us learn more about our ancestors.",
        "Much of human evolution took place in Africa, but we eventually expanded throughout the globe. Pan and zoom around the map to explore the locations of all species, then tap this button if you need to zoom back out.",
        "Tap this button to restart this tutorial at any time. Let's get started!"
    ]
    let mapIndex = 2
    
    // Map
    let pins = [
        UIImage(named: "red-pin")?.scaled(newSize: CGSize(width: 37.5, height: 52)),
        UIImage(named: "blue-pin")?.scaled(newSize: CGSize(width: 37.5, height: 52)),
        UIImage(named: "green-pin")?.scaled(newSize: CGSize(width: 37.5, height: 52)),
        UIImage(named: "purple-pin")?.scaled(newSize: CGSize(width: 37.5, height: 52)),
        UIImage(named: "yellow-pin")?.scaled(newSize: CGSize(width: 37.5, height: 52))
    ]
    let africaEuropeAsiaZoom = GMSCameraPosition.camera(withLatitude: 10, longitude: 55, zoom: 1.0)
    var activeMarkers: Set<String> = Set()
    var mapView: GMSMapView = GMSMapView.map(withFrame: .zero, camera: .init())
    
    // UI
    let overlayBackgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure onboarding coach marks
        self.coachMarksController.dataSource = self
        self.coachMarksController.overlay.backgroundColor = overlayBackgroundColor
        coachMarksViews = [yearLabel, slider, mapFrame, speciesCountLabel, speciesCountLabel, reCenterButton, helpButton]
    
        // Configure map
        mapView = GMSMapView.map(withFrame: mapFrame.frame, camera: africaEuropeAsiaZoom)
        mapView.mapType = .satellite
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        // Configure floating on-map buttons and labels
        reCenterButton.backgroundColor = .white
        reCenterButton.layer.cornerRadius = reCenterButton.frame.height / 2
        reCenterButton.layer.borderWidth = 1
        reCenterButton.layer.borderColor = UIColor.clear.cgColor
        helpButton.backgroundColor = .white
        helpButton.layer.cornerRadius = helpButton.frame.height / 2
        helpButton.layer.borderWidth = 1
        helpButton.layer.borderColor = UIColor.clear.cgColor
        self.view.bringSubviewToFront(reCenterButton)
        self.view.bringSubviewToFront(helpButton)
        self.view.bringSubviewToFront(speciesCountLabel)
        
        // Configure year slider
        slider.minimumValue = 0
        slider.maximumValue = 7.00
        slider.setValue(0.0, animated: true)
        sliderDragged(self)
    }
    
    // Configure onboarding appearance
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Only display onboarding on first open
        if !UserDefaults.standard.bool(forKey: "mapOnboarded") {
            self.coachMarksController.start(in: .window(over: self))
            UserDefaults.standard.set(true, forKey: "mapOnboarded")
        }
    }
    
    // Configure onboarding disappearance
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        // Stop displaying onboarding when leaving screen
        self.coachMarksController.stop(immediately: true)
    }
    
    // Configure number of coach marks to display
    func numberOfCoachMarks(for coachMarksController: CoachMarksController) -> Int {
        return coachMarksMessages.count
    }
    
    // Configure position of coachmarks
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkAt index: Int) -> CoachMark {
        var coachMark = coachMarksController.helper.makeCoachMark(for: coachMarksViews[index])
        if index == mapIndex { coachMark.arrowOrientation = .bottom }   // Display map callout above the map
        return coachMark
    }
    
    // Configure messages for each coach mark
    func coachMarksController(_ coachMarksController: CoachMarksController, coachMarkViewsAt index: Int, madeFrom coachMark: CoachMark) -> (bodyView: UIView & CoachMarkBodyView, arrowView: (UIView & CoachMarkArrowView)?) {
        
        let coachViews = coachMarksController.helper.makeDefaultCoachViews(withArrow: true, arrowOrientation: coachMark.arrowOrientation)
        coachViews.bodyView.hintLabel.text = coachMarksMessages[index]
        coachViews.bodyView.nextLabel.text = (index == coachMarksMessages.count - 1) ? "Start" : "Next" // Display start message for last mark

        return (bodyView: coachViews.bodyView, arrowView: coachViews.arrowView)
    }

    // Update map and year display label when slider is dragged
    @IBAction func sliderDragged(_ sender: Any) {
        
        let sliderValueRounded = round(100 * slider.value) / 100

        slider.setValue(sliderValueRounded, animated: true)
        yearLabel.text = "\(sliderValueRounded) million years ago"
        plotPins(year: Double(exactly: slider.value)!)
    }
    
    // Plot all map pins for a given year
    func plotPins(year: Double) {
        
        mapView.clear()
        let lastActiveMarkers = activeMarkers   // Track which markers are currently displayed
        activeMarkers = []                      // Track which markers are being added
        
        for (name, information) in species {
            if speciesDidExist(year: year, information: information) {
                for (latitude, longitude) in information.pins {
                    let marker = GMSMarker()
                    marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                    marker.appearAnimation = lastActiveMarkers.contains(name) ? .none : .pop    // Animate new markers
                    marker.title = name
                    marker.icon = pins[activeMarkers.count]     // Display each species as a different-colored pin
                    marker.map = mapView
                }
                activeMarkers.insert(name)
            }
        }

        speciesCountLabel.text = "\(activeMarkers.count) active species"    // Display count of all active species
    }
    
    // Helper function to determine if species should be plotted for a given year
    func speciesDidExist(year: Double, information: Species) -> Bool {
        
        // If species has same start and end, show it in a range of +/- 0.1 around its estimate
        let widenRange = information.existedFrom == information.existedUntil
        
        let inBottomRange = information.existedUntil - (widenRange ? 0.1 : 0.0) <= year
        let inTopRange = year <= (information.existedFrom + (widenRange ? 0.1 : 0.0))
        return inBottomRange && inTopRange
    }
    
    // Zoom map back to original view if button tapped
    @IBAction func reCenterMapTapped(_ sender: Any) {
        mapView.animate(to: africaEuropeAsiaZoom)
    }
    
    // Display onboarding if button tapped
    @IBAction func helpButtonTapped(_ sender: Any) {
        self.coachMarksController.start(in: .window(over: self))
    }
    
    // Display species card if pin is tapped
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {

        let presenter = Presentr(presentationType: .bottomHalf)
        presenter.backgroundColor = overlayBackgroundColor
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CardTableViewController") as! CardTableViewController
        
        controller.speciesName = marker.title!
        controller.speciesDetails = species[marker.title!]!
        customPresentViewController(presenter, viewController: controller, animated: true, completion: nil)
        return true
    }
}

// Custom add-ons to UIImage
private extension UIImage {
    
    // Resize image
    func scaled(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image.withRenderingMode(self.renderingMode)
    }
}
