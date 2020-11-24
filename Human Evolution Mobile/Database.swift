//
//  Database.swift
//  Human Evolution Mobile
//
//  Created by Shreyas Agnihotri on 11/5/20.
//  Copyright © 2020 Shreyas Agnihotri. All rights reserved.
//

import Foundation
import GoogleMaps

struct Species {
    var existedFrom: Double
    var existedUntil: Double
    var pins: [(CLLocationDegrees, CLLocationDegrees)]
    var geography: String
    var brainSize: String
    var moreInfo: String
    var fossils: [Fossil]
}

struct Fossil {
    var name: String
    var type: String
    var yearDiscovered: Int
    var link: URL
}

let species: [String: Species] = [
    
    "Sahelanthropus tchadensis": Species(
        existedFrom: 7.0,
        existedUntil: 6.0,
        pins: [(16, 18)],
        geography: "West-Central Africa", // Description of geographic range
        brainSize: "350 cubic centimeters", // Description of brain size
        moreInfo: "One of the earliest human ancestors, this species had achimpanzee-sized brain but walked upright to some extent. Its spinalcord attached to its brain at the bottom of the skull, consistentwith the anatomy of a bipedal ape. It also had relatively smallcanine teeth.", // Short paragraph description
        fossils: [
            Fossil(
                name: "Toumai",
                type: "Skull",
                yearDiscovered: 2001,
                link: URL(string:"https://humanorigins.s.edu/evidence/human-fossils/fossils/tm-266-01-060-1")!
            )
        ]
    ),
    
    "Orrorin tugenensis": Species(
        existedFrom: 6.2,
        existedUntil: 5.8,
        pins: [(-6, 35)],
        geography: "Eastern Africa (central Kenya)", // Description of geographic range
        brainSize: "Unknown", // Description of brain size
        moreInfo: "From a thigh bone discovered in Kenya’s Tugen hills, we know that this human ancestor was also one of the first bipedal apes. It likely spent some time climbing in trees and some time walking upright on the ground.", // Short paragraph description
        fossils: [
            Fossil(
                name: "BAR 1002’00",
                type: "Femur",
                yearDiscovered: 2001,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/bar-100200")!
            )
        ]
        
    ),
    
    "Ardipithecus kadabba": Species(
        existedFrom: 5.8,
        existedUntil: 5.2,
        pins: [(11, 40)],
        geography: "Eastern Africa (modern Ethiopia)", // Description of geographic range
        brainSize: "300-350 cubic centimeters", // Description of brain size
        moreInfo: "The earliest known member of the Ardipithecus genus, this species had a brain and many other features that were quite chimp-like. But its small canine teeth are evidence of its relationship to later hominins, and evidence from one toe bone suggests it walked upright.", // Short paragraph description
        fossils: []
    ),
    
    "Ardipithecus ramidus": Species(
        existedFrom: 4.4,
        existedUntil: 4.4,
        pins: [(10.5, 40.5)],
        geography: "Eastern Africa (modern Ethiopia)", // Description of geographic range
        brainSize: "300-350 cubic centimeters", // Description of brain size
        moreInfo: "From a partial skeleton of its skull, teeth, pelvis, hands and feet, we know that this species was adapted to life in the trees, but was likely bipedal on the ground. It lived in a wooded environment, contradicting the theory that bipedalism developed in an open savanna.", // Short paragraph description
        fossils: [
            Fossil(
                name: "Ardi",
                type: "Partial Skeleton",
                yearDiscovered: 1994,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/ara-vp-6500")!
            )
        ]
    ),
    
    
    "Australopithecus anamensis": Species(
        existedFrom: 4.2,
        existedUntil: 3.8,
        pins: [(3, 36)],
        geography: "Eastern Africa (modern Kenya and Ethiopia)", // Description of geographic range
        brainSize: "~370 cubic centimeters", // Description of brain size
        moreInfo: "Anthropologists conclude that this species represents the first clear evidence of committed bipedality, combined with tree-climbing capability. There is also evidence of smaller canine teeth and bigger molar teeth than its predecessors.", // Short paragraph description
        fossils: [
            Fossil(
                name: "KNM-KP 29285",
                type: "Shin bone",
                yearDiscovered: 1994,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-kp-29285")!
            )
        ]
    ),
    
    "Australopithecus afarensis": Species(
        existedFrom: 3.85,
        existedUntil: 2.95,
        pins: [(0, 37.5)],
        geography: "Eastern Africa (modern Kenya, Ethiopia, and Tanzania)", // Description of geographic range
        brainSize: "365-500 cubic centimeters", // Description of brain size
        moreInfo: "From remains of over 300 individuals, anthropologists have documented that this species was bipedal, survived for more than 900,000 years, had a larger brain than its known predecessors, had small canine teeth, and had a much more rapid development schedule than modern humans. Adaptations for living in the trees and on the ground likely helped this species survive for so long", // Short paragraph description
        fossils: [
            Fossil(
                name: "Lucy",
                type: "Partial skeleton",
                yearDiscovered: 1974,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/al-288-1")!
            ),
            Fossil(
                name: "Dikika Child",
                type: "Partial skeleton",
                yearDiscovered: 2000,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-kp-29285")!
            )
        ]
    ),
    
    "Kenyanthropus Platyops": Species(
        existedFrom: 3.5,
        existedUntil: 3.5,
        pins: [(2.5, 35.5)],
        geography: "Eastern Africa (modern west Kenya)", // Description of geographic range
        brainSize: "350 cubic centimeters", // Description of brain size
        moreInfo: "This is a highly controversial species, as many anthropologists believe it should be considered a variant of Au. afarensis. Inhabiting eastern Africa at the same time as Au. Afarenesis, a reconstructed skull indicates to some researchers that the mix of unusual features, including a flat face, demonstrate that this is a member of an entirely new genus.", // Short paragraph description
        fossils: [
            Fossil(
                name: "KNM-WT 40000",
                type: "Skull fragments",
                yearDiscovered: 1999,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-wt-40000")!
            )
        ]
    ),
    
    "Australopithecus Africanus": Species(
        existedFrom: 3.3,
        existedUntil: 2.1,
        pins: [(-30, 24)],
        geography: "Southern Africa", // Description of geographic range
        brainSize: "~450 cubic centimeters", // Description of brain size
        moreInfo: "While anatomically similar to Au. Afarensis existing at the same time in Eastern Africa, Au. Africanus was likely a better climber, had a rounder skull, and had smaller teeth. It was the first human ancestor discovered in Africa, in 1924, so knowledge of this species framed the way human evolution was understood for much of the early 20th century.", // Short paragraph description
        fossils: [
            Fossil(
                name: "Taung Child",
                type: "Skull",
                yearDiscovered: 1924,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/taung-child")!
            )
        ]
    ),
    
    "Paranthropus aethiopicus": Species(
        existedFrom: 2.7,
        existedUntil: 2.3,
        pins: [(4.5, 36.5)],
        geography: "Eastern Africa (modern northern Kenya, southern Ethiopia)", // Description of geographic range
        brainSize: "~410 cubic centimeters", // Description of brain size
        moreInfo: "This is the earliest known member of the \"robust\" australopithecine group. It has a large and protruding face, big teeth, a strong jaw, and a distinct sagittal crest at the top of the skull that connects to its chewing muscles and makes them more powerful.", // Short paragraph description
        fossils: [
            Fossil(
                name: "KNM-WT 17000",
                type: "Skull",
                yearDiscovered: 1985,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-wt-17000")!
            )
        ]
    ),
    
    "Australopithecus garhi": Species(
        existedFrom: 2.5,
        existedUntil: 2.5,
        pins: [(12, 37.5)],
        geography: "Eastern Africa (modern Ethiopia)", // Description of geographic range
        brainSize: "~450 cubic centimeters", // Description of brain size
        moreInfo: " This species strongly resembles Au. Afarensis, and is found in approximately the same geographic region, but appears close to half a million years after Lucy’s kind went extinct. Two notable aspects are that it had a longer femur than Au. afarensis, suggesting better walking capability, and was discovered near butchered antelope bones, evidence of stone tool use.", // Short paragraph description
        fossils: [
            Fossil(
                name: "BOU-VP-12/a",
                type: "Partisal skull",
                yearDiscovered: 1999,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/bou-vp-121")!
            )
        ]
    ),
    
    "Homo habilis": Species(
        existedFrom: 2.4,
        existedUntil: 1.4,
        pins: [(-4, 33.5), (-30, 24)],
        geography: "Southern and Eastern Africa", // Description of geographic range
        brainSize: "500-800 cubic centimeters", // Description of brain size
        moreInfo: "The first documented member of the genus Homo, H. Habilis has a slightly larger brain, smaller face, and smaller teeth than any Australopithecus or older hominin. It also had the largest geographic range than any predecessor, found both in modern South Africa and in modern East Africa. There is debate over whether H. habilis evolved directly into H. erectus, which then directly evolved into modern humans. H. Habilis is associated with the Oldowan stone tool industry.", // Short paragraph description
        fossils: [
            Fossil(
                name: "KNM-ER 1813",
                type: "Skull",
                yearDiscovered: 1973,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-er-1813")!
            ),
            Fossil(
                name: "OH 8",
                type: "Foot",
                yearDiscovered: 1960,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/oh-8")!
            )
        ]
    ),
    
    "Paranthropus boisei": Species(
        existedFrom: 2.3,
        existedUntil: 1.2,
        pins: [(-2, 35.5)],
        geography: "Eastern Africa", // Description of geographic range
        brainSize: "~450 cubic centimeters", // Description of brain size
        moreInfo: " Consistent with the rest of the genus Paranthropus, P. boisei has a large sagittal crest and is otherwise well-adapted for powerful chewing. It also has teeth that are even larger the P. robustus, wide cheekbones that give it a flat face, and fed primarily in a grassland environment. It existed at the same time as H. habilis in Eastern Africa.", // Short paragraph description
        fossils: [
            Fossil(
                name: "Nutcracker Man (OH 5)",
                type: "Skull",
                yearDiscovered: 1959,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/oh-5")!
            ),
            Fossil(
                name: "KNM-ER 406",
                type: "Skull",
                yearDiscovered: 1969,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-er-406")!
            )
        ]
    ),
    
    "Australopithecus sediba": Species(
        existedFrom: 1.98,
        existedUntil: 1.98,
        pins: [(-32, 23)],
        geography: "Southern Africa", // Description of geographic range
        brainSize: "~420 cubic centimeters", // Description of brain size
        moreInfo: "Generally, Au. sediba demonstrates some features often associated with modern humans and early Homo, and other features associated with earlier members of the Australopithecus genus. It is strongly adapted for climbing trees, and was also capable of upright walking, but not as well as other, earlier members of its genus. Its odd way of walking, distinct from the gait of H. habilis and others, suggest to some researchers that upright walking evolved independently on more than one evolutionary path. Brain size is also quite smaller than the brain of H. habilis, with which it co-existed in southern Africa.", // Short paragraph description
        fossils: [
            Fossil(
                name: "MH1",
                type: "Partial skeleton",
                yearDiscovered: 2008,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/mh1")!
            ),
            Fossil(
                name: "MH2",
                type: "Partial skeleton",
                yearDiscovered: 2008,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/mh2")!
            )
        ]
    ),
    
    "Homo rudolfensis": Species(
        existedFrom: 1.9,
        existedUntil: 1.8,
        pins: [(2, 37)],
        geography: "Eastern Africa", // Description of geographic range
        brainSize: "775 cubic centimeters", // Description of brain size
        moreInfo: "While the fossil evidence is still quite limited, researchers believe Homo rudolfensis was distinct from Homo habilis because it had a far larger brain, a face with a slightly different shape, and larger molar teeth. Some researchers argue that it should still be classified as a variant of H. habilis, and others think it should be a distinct species but that it actually fits better within the Australopithecus genus.", // Short paragraph description
        fossils: [
            Fossil(
                name: "KNM-ER 1470",
                type: "Skull",
                yearDiscovered: 1972,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-er-1470")!
            )
        ]
    ),
    
    "Homo erectus": Species(
        existedFrom: 1.89,
        existedUntil: 0.11,
        pins: [(-28, 24), (4.5, 18), (13.5, 40.5), (43, 43.5), (27, 119), (-7, 107), (36, 119)],
        geography: "Africa, Asia, Indonesia", // Description of geographic range
        brainSize: "600-1200 cubic centimeters", // Description of brain size
        moreInfo: "Homo erectus was the first hominin to possess limb and body proportions similar to humans today. Researchers believe this improved their walking abilities, allowing them to expand their geographic range from Africa to Eurasia. It is unlikely they were capable of climbing and living in tress, and it is likely they were capable of running long distances. During the almost two million years H. Erectus existed, a significant expansion in brain size took place.", // Short paragraph description
        fossils: [
            Fossil(
                name: "Turkana Boy",
                type: "Partial skeleton",
                yearDiscovered: 1984,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/knm-wt-15000")!
            ),
            Fossil(name: "D3444",
                   type: "Skull",
                   yearDiscovered: 2002,
                   link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/d3444")!
            )
        ]
    ),
    
    "Paranthropus robustus": Species(
        existedFrom: 1.8,
        existedUntil: 1.2,
        pins: [(-28, 26)],
        geography: "Southern Africa", // Description of geographic range
        brainSize: "~500 cubic centimeters", // Description of brain size
        moreInfo: "P. Robustus has similar anatomy to other members of the Paranthropus genus: a large face, powerful chewing muscles, a sagittal crest on the top of the skull, and flaring cheekbones. However, while P. boisei in Eastern Africa fed from a grassland environment, P. robustus fed primarily from a forested environment, suggesting that the chewing anatomy specific to this genus was not exclusively used to feed from a particular environment’s food sources.", // Short paragraph description
        fossils: [
            Fossil(
                name: "SK 46",
                type: "Skull",
                yearDiscovered: 1936,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/sk-46")!
            ),
            Fossil(
                name: "SK 48",
                type: "Skull",
                yearDiscovered: 1950,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/sk-48")!
            )
        ]
    ),
    
    "Homo heidelbergensis": Species(
        existedFrom: 0.7,
        existedUntil: 0.2,
        pins: [(43, 12), (-14, 28.5)],
        geography: "Africa, Europe", // Description of geographic range
        brainSize: "~1200 cubic centimeters", // Description of brain size
        moreInfo: "Some consider this species to simply be \"archaic\" Homo sapiens, but it is clear that Homo heidelbergensis developed technologies and sophisticated behaviors that surpassed earlier members of the Homo genus. They controlled fire, used wooden spears, created simple shelters, and likely hunted large animals. Anatomically, they had a large browridge, a large brain, a flat face, and were short and wide to conserve heat, allowing them to live in colder climates.", // Short paragraph description
        fossils: [
            Fossil(
                name: "Ceprano",
                type: "Partial skull",
                yearDiscovered: 1994,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/ceprano")!
            ),
            Fossil(
                name: "Rhodesian Man",
                type: "Skull",
                yearDiscovered: 1921,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/kabwe-1")!
            )
        ]
    ),
    
    "Homo floresiensis": Species(
        existedFrom: 0.1,
        existedUntil: 0.05,
        pins: [(-8.5, 121)],
        geography: "Island of Flores (modern Indonesia)", // Description of geographic range
        brainSize: "~400 cubic centimeters", // Description of brain size
        moreInfo: "This recently discovered member of the Homo genus lived quite recently on the Indonesian island of Flores, and was far smaller than any other member of the Homo or Australopithecus genus. Researchers believe they were about three and a half feet tall, had extremely small brains, even for their size, had no chin, and had large teeth for their size. This may be indicative of island dwarfism, a documented phenomenon in which populations isolated on islands with limited resources shrink in body size.", // Short paragraph description
        fossils: [
            Fossil(
                name: "LB-1",
                type: "Partial skeleton",
                yearDiscovered: 2003,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/lb-1")!
            )
        ]
    ),
    
    "Homo neanderthalensis": Species(
        existedFrom: 0.4,
        existedUntil: 0.04,
        pins: [(45, 1), (34, 39), (49, 87), (50, 12)],
        geography: "Europe, Middle East, central Asia", // Description of geographic range
        brainSize: "~1400 cubic centimeters", // Description of brain size
        moreInfo: "", // Short paragraph description
        fossils: [
            Fossil(
                name: "La Ferrassie",
                type: "Partial skeleton",
                yearDiscovered: 1909,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/la-ferrassie")!
            ),
            Fossil(
                name: "Shanidar 1",
                type: "Partial skeleton",
                yearDiscovered: 1957,
                link: URL(string: "https://humanorigins.si.edu/evidence/human-fossils/fossils/shanidar-1")!
            )
        ]
    ),
    
    "Homo naledi": Species(
        existedFrom: 0.33,
        existedUntil: 0.24,
        pins: [(26, 28)],
        geography: "Southern Africa", // Description of geographic range
        brainSize: "~500 cubic centimeters", // Description of brain size
        moreInfo: "Homo naledi displays an anatomy that is somewhat similar to its other Homo genus contemporaries, but also starkly different features that reflect distant ancestors. As other members of the genus left the trees, H. naledi preserved many features that make it a stronger climber and a correspondingly weaker upright walker. It also preserved a very small brain, even as other hominin species around it continued to demonstrate greater and greater brain size over time. The existence of this species so close to the modern era disrupts the narrative that the evolutionary trends that led to modern humans were competitively advantageous for all of our hominid ancestors: instead, it seems that some maintained a competitive edge through a life in the trees that paralleled more archaic lifestyles.", // Short paragraph description
        fossils: []
    ),
    
    "Homo sapiens": Species(
        existedFrom: 0.2,
        existedUntil: 0.0,
        pins: [(8, 22), (38, 43), (49,13), (42, 80), (41, -100), (-16, -58), (-25, 133)],
        geography: "Everywhere", // Description of geographic range
        brainSize: "~1350 cubic centimeters", // Description of brain size
        moreInfo: "The first evidence of modern humans dates to 200,000 years ago in Africa. The first evidence of Homo sapiens outside of Africa is about 100,000 years ago, and everywhere else about in Europe and Asia by 40,000 years ago.", // Short paragraph description
        fossils: []
    )
]
