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
    
    // UI
    let font = UIFont.systemFont(ofSize: 16.0)

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
        let moreInfo = NSMutableAttributedString(string: species.moreInfo, attributes: [.font: font])
        for species in humanSpecies.values {
            moreInfo.italicize(textToFind: species.scientificName.components(separatedBy: " ").first!)
            moreInfo.italicize(textToFind: species.scientificName)
        }
        
        moreInfoLabel.attributedText = moreInfo
                
        // Fill fossils label with species' fossils and links to external sites
        let fossils = NSMutableAttributedString(string: "", attributes: [.font: font])
        var count = 1
        for fossil in species.fossils {  // Add text for each fossil
            let fossilDescription = "\(fossil.name) • \(fossil.type), \(fossil.yearDiscovered)" + (count > 0 && count < species.fossils.count ? "\n" : "")
            fossils.append(NSMutableAttributedString(string: fossilDescription, attributes: [.font: font]))
            fossils.setAsLink(textToFind: fossil.name, linkURL: fossil.link)
            count += 1
        }
        
        // Set how links should function: blue, underlined, and tappable
        self.keyFossilsTextView.attributedText = fossils
        self.keyFossilsTextView.isUserInteractionEnabled = true
        self.keyFossilsTextView.isEditable = false
        self.keyFossilsTextView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: font
        ]
    }
}

// Custom add-ons to String
extension String {
    
    // Return all ranges where substring is found
    func ranges(of substring: String, options: CompareOptions = [], locale: Locale? = nil) -> [Range<Index>] {
        var ranges: [Range<Index>] = []
        while let range = range(of: substring, options: options, range: (ranges.last?.upperBound ?? self.startIndex)..<self.endIndex, locale: locale) {
            ranges.append(range)
        }
        return ranges
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
    
    // Find text and italicize
    public func italicize(textToFind: String) {

        let ranges = self.string.ranges(of: textToFind)
        for foundRange in ranges {
            if !foundRange.isEmpty {
                self.setAttributes([.font: UIFont.systemFont(ofSize: 16.0).with(traits: .traitItalic)], range: NSRange(foundRange, in: self.string))
            }
        }
    }
}

// Custom add-ons to UIFont
extension UIFont {
    
    // Return font with traits applied
    func with(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
        guard let descriptor = self.fontDescriptor.withSymbolicTraits(traits) else {
            return self
        }
        
        return UIFont(descriptor: descriptor, size: 0)
    }
}
