//
//  CardTableViewController.swift
//  Human Evolution Mobile
//
//  Created by Shreyas Agnihotri on 11/20/20.
//  Copyright © 2020 Shreyas Agnihotri. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
    
    // Outlets
    @IBOutlet weak var speciesImageView: UIImageView!
    @IBOutlet weak var speciesNameLabel: UILabel!
    @IBOutlet weak var existedFromLabel: UILabel!
    @IBOutlet weak var existedUntilLabel: UILabel!
    @IBOutlet weak var geographyLabel: UILabel!
    @IBOutlet weak var brainSizeLabel: UILabel!
    @IBOutlet weak var keyFossilsTextView: UITextView!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    // Species information
    var species: Species = Species(scientificName: "", imageName: "", existedFrom: 1.0, existedUntil: 1.0, pins: [], pinImage: UIImage(named: "red-pin")!, geography: "", brainSize: "", moreInfo: "", fossils: [])

    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Fill UI elements with species details
        speciesImageView.image = UIImage(named: species.imageName)
        speciesNameLabel.text = species.scientificName
        existedFromLabel.text = species.scientificName != "Homo sapiens" ? "~\(species.existedFrom)M" : "~0.3M"
        existedUntilLabel.text = species.scientificName != "Homo sapiens" ? "~\(species.existedUntil)M" : "0"
        geographyLabel.text = species.geography
        brainSizeLabel.text = species.brainSize
        
        // Italicize all species names
        speciesNameLabel.font = speciesNameLabel.font.with(traits: .traitItalic)
        let moreInfo = NSMutableAttributedString(string: species.moreInfo, attributes: [.font: UIFont.systemFont(ofSize: 16.0)])
        for species in humanSpecies.values {
            moreInfo.italicize(textToFind: species.scientificName)
        }
        moreInfoLabel.attributedText = moreInfo
                
        // Fill fossils label with species' fossils and links to external sites
        var fossils = ""
        var count = 1
        for fossil in species.fossils {  // Add text for each fossil
            fossils += "\(fossil.name) • \(fossil.type), \(fossil.yearDiscovered)" + (count > 0 && count < species.fossils.count ? "\n" : "")
            count += 1
        }
        let allFossils = NSMutableAttributedString(string: fossils, attributes: [.font: UIFont.systemFont(ofSize: 16.0)])
        for fossil in species.fossils {  // Add links for each fossil
            allFossils.setAsLink(textToFind: fossil.name, linkURL: fossil.link)
        }
        self.keyFossilsTextView.attributedText = allFossils
        self.keyFossilsTextView.isUserInteractionEnabled = true
        self.keyFossilsTextView.isEditable = false
        self.keyFossilsTextView.linkTextAttributes = [         // Set how links should appear: blue and underlined
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 16.0)
        ]
    }
}

// Custom add-ons to NSMutableAttributedString
extension NSMutableAttributedString {

    // Find text and hyperlink to provided URL
    public func setAsLink(textToFind: String, linkURL: URL) {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.setAttributes([.link: linkURL, .font: UIFont.systemFont(ofSize: 16.0)], range: foundRange)
        }
    }
    
    // Find text and hyperlink to provided URL
    public func italicize(textToFind: String) {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.setAttributes([.font: UIFont.systemFont(ofSize: 16.0).with(traits: .traitItalic)], range: foundRange)
        }
    }
}

// Custom add-ons to UIFont
extension UIFont {
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        } // guard
        
        return UIFont(descriptor: descriptor, size: 0)
    }
}
