//
//  CardTableViewController.swift
//  Human Evolution Mobile
//
//  Created by Shreyas Agnihotri on 11/20/20.
//  Copyright © 2020 Shreyas Agnihotri. All rights reserved.
//

import UIKit

class CardTableViewController: UITableViewController {
    
    @IBOutlet weak var speciesImageView: UIImageView!
    @IBOutlet weak var speciesNameLabel: UILabel!
    @IBOutlet weak var existedFromLabel: UILabel!
    @IBOutlet weak var existedUntilLabel: UILabel!
    @IBOutlet weak var geographyLabel: UILabel!
    @IBOutlet weak var brainSizeLabel: UILabel!
    @IBOutlet weak var keyFossilsTextView: UITextView!
    @IBOutlet weak var moreInfoLabel: UILabel!
    
    var speciesName: String = "name"
    var speciesDetails: Species = Species(existedFrom: 1.0, existedUntil: 1.0, pins: [], geography: "", brainSize: "", moreInfo: "", fossils: [])

    override func viewDidLoad() {
        super.viewDidLoad()
        
        speciesNameLabel.text = speciesName
        existedFromLabel.text = "\(speciesDetails.existedFrom)M"
        existedUntilLabel.text = "\(speciesDetails.existedUntil)M"
        geographyLabel.text = speciesDetails.geography
        brainSizeLabel.text = speciesDetails.brainSize
        moreInfoLabel.text = speciesDetails.moreInfo
        
        var fossils = ""
        var count = 1
        let keyFossils = speciesDetails.fossils
        for fossil in keyFossils {
            fossils += "\(fossil.name) • \(fossil.type), \(fossil.yearDiscovered)" + (count > 0 && count < keyFossils.count ? "\n" : "")
            count += 1
        }
        let allFossils = NSMutableAttributedString(string: fossils, attributes: [.font: UIFont.systemFont(ofSize: 16.0)])
        for fossil in keyFossils {
            allFossils.setAsLink(textToFind: fossil.name, linkURL: fossil.link)
        }
        self.keyFossilsTextView.attributedText = allFossils
        self.keyFossilsTextView.isUserInteractionEnabled = true
        self.keyFossilsTextView.isEditable = false
        
        // Set how links should appear: blue and underlined
        self.keyFossilsTextView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .font: UIFont.systemFont(ofSize: 16.0)
        ]
    }
}

extension NSMutableAttributedString {

    public func setAsLink(textToFind: String, linkURL: URL) {

        let foundRange = self.mutableString.range(of: textToFind)
        if foundRange.location != NSNotFound {
            self.setAttributes([.link: linkURL, .font: UIFont.systemFont(ofSize: 16.0)], range: foundRange)
        }
    }
}
