//
//  Differential.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-08-16.
//

import SwiftUI

public enum Sign: CaseIterable {
    /// This is going to be a long list
    case wheezes, ronchi, rales, vomiting, cough, fever,
    weightLoss, barrelChest, swollenFeet, swollenAnkles, swollenLegs, tripodPosition,
    chills, runnyNose, thickSputum, sputum, redSputum, stridor,
    cyanosis, increasedWorkOfBreathing, tachycardia, bradycardia, tachypnea, bradypnea,
    barkingCough, grayishMembraneUpperThroat, slurredSpeech, sneeze, coldSweat, bleedingMouth,
    bleedingEyes, hematemesis, diaphoresis

    var label: String {
        switch self {
        case .wheezes: "Wheezes"
        case .ronchi: "Ronchi/crackles"
        case .rales: "Rales"
        case .vomiting: "Emesis"
        case .cough: "Cough (normal)"
        case .barkingCough: "Cough (barking)"
        case .fever: "Fever"
        case .weightLoss: "Weight loss"
        case .barrelChest: "Barrel chest"
        case .swollenFeet: "Swelling (feet)"
        case .swollenLegs: "Swelling (legs)"
        case .swollenAnkles: "Swelling (ankles)"
        case .tripodPosition: "Tripoding"
        case .chills: "Chills"
        case .runnyNose: "Runny nose"
        case .thickSputum: "Sputum (thick)"
        case .sputum: "Sputum (green/yellow)"
        case .redSputum: "Sputum (red)"
        case .stridor: "Stridor"
        case .cyanosis: "Cyanosis"
        case .increasedWorkOfBreathing: "Increased WOB"
        case .tachycardia: "HR > 100"
        case .bradycardia: "HR < 60"
        case .tachypnea: "RR > 20"
        case .bradypnea: "RR < 12"
        case .grayishMembraneUpperThroat: "Gray membrane (throat)"
        case .slurredSpeech: "Slurred speech"
        case .sneeze: "Sneezing"
        case .coldSweat: "Sweat (cold)"
        case .bleedingMouth: "Bleeding (mouth)"
        case .bleedingEyes: "Bleeding (eyes)"
        case .hematemesis: "Emesis (blood)"
        case .diaphoresis: "Sweat (excessive)"
        default: "Sign"
        }
    }
}

public enum Symptom: CaseIterable {
    case nausea, shortnessOfBreath, difficultySleeping, morningHeadaches, chronicFatigue, anxiety,
    chestPain, coldFluLike, difficultySwallowing, anorexia

    var label: String {
        switch self {
        case .nausea: "Nausea"
        case .shortnessOfBreath: "SOB"
        case .difficultySleeping: "Difficulty (sleeping)"
        case .morningHeadaches: "Headache (morning)"
        case .chronicFatigue: "Chronic fatigue"
        case .anxiety: "Anxiety"
        case .chestPain: "Pain (chest)"
        case .coldFluLike: "Cold/flu"
        case .difficultySwallowing: "Difficulty (swallowing)"
        case .anorexia: "Anorexia"
        default: "Symptom"
        }
    }
}

public enum BodySystem: CaseIterable {
    case respiratory, cardiovascular, neurologic, gastrointestinal, urologic, endocrine, hematologic, immunologic, toxicologic, psychiatric, gynecologic, multiple

    var label: String {
        switch self {
        case .respiratory: "Respiratory"
        case .cardiovascular: "Cardiovascular"
        case .neurologic: "Neurologic"
        case .gastrointestinal: "Gastrointestinal"
        case .urologic: "Urologic"
        case .endocrine: "Endocrine"
        case .hematologic: "Hematologic"
        case .immunologic: "Immunologic"
        case .toxicologic: "Toxicologic"
        case .psychiatric: "Psychiatric"
        case .gynecologic: "Gynecologic"
        default: "Multiple"
        }
    }
    
    var icon: Image {
        switch self {
        case .respiratory: Image(systemName: "lungs.fill").symbolRenderingMode(.hierarchical)
        case .cardiovascular: Image(systemName: "waveform.path.ecg.rectangle.fill").symbolRenderingMode(.hierarchical)
        case .neurologic: Image(systemName: "brain.fill").symbolRenderingMode(.hierarchical)
        case .hematologic: Image(systemName: "drop.fill").symbolRenderingMode(.hierarchical)
        case .immunologic: Image(systemName: "allergens.fill").symbolRenderingMode(.hierarchical)
        case .toxicologic: Image(systemName: "pill.fill").symbolRenderingMode(.hierarchical)
        case .psychiatric: Image(systemName: "brain.fill").symbolRenderingMode(.hierarchical)
        case .gynecologic: Image(systemName: "figure.stand.dress").symbolRenderingMode(.hierarchical)
        default: Image(systemName: "cross.fill").symbolRenderingMode(.hierarchical)
        }
    }
}

public struct Condition: Identifiable {
    public var id: UUID = UUID()
    var name: String
    var notes: String = ""
    var signs: [Sign]
    var symptoms: [Symptom]
    var bodySystem: BodySystem
    var url: URL? = nil
    
    public init(name: String, notes: String = "", signs: [Sign], symptoms: [Symptom], bodySystem: BodySystem, url: URL? = nil) {
        self.id = UUID()
        self.name = name
        self.notes = notes
        self.signs = signs
        self.symptoms = symptoms
        self.bodySystem = bodySystem
        
        if url != nil {
            self.url = url
        } else {
            if let encodedName = name.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) {
                self.url = URL(string: "https://medical-dictionary.thefreedictionary.com/\(encodedName)")
            }
        }
    }
}

public var DifferentialConditions: [Condition] = [
    Condition(
        name: "Asthma",
        notes: "Chronic inflammatory disease of the airways. Inflammation makes airways hyper-responsive to stimuli such as cold air/exercise/allergens/viral infections.",
        signs: [.cough, .wheezes, .tripodPosition, .increasedWorkOfBreathing],
        symptoms: [.shortnessOfBreath],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Pertussis",
        notes: "Acute infectious inflammation of the lower airway. Whooping sound caused by laryngeal spasm.",
        signs: [.cough, .stridor],
        symptoms: [],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Pneumonia",
        notes: "Infection of the lung from bacteria/amoebae/virus/fungi/parasite.",
        signs: [.fever, .cough, .rales, .ronchi, .redSputum, .sputum, .increasedWorkOfBreathing],
        symptoms: [.shortnessOfBreath, .chestPain],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Bronchiolitis",
        notes: "Acute viral infection of bronchioles. Most common in children 2-24 months.",
        signs: [.tachycardia, .increasedWorkOfBreathing, .ronchi, .cough],
        symptoms: [.shortnessOfBreath, .coldFluLike],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Croup",
        notes: "Viral infection of the larynx, upper respiratory issues. Harsh, barking cough is common.",
        signs: [.barkingCough, .stridor, .fever, .runnyNose],
        symptoms: [.coldFluLike],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Diptheria",
        notes: "Upper respiratory disease which can lead to cardiovascular and CNS symptoms if untreated.",
        signs: [.grayishMembraneUpperThroat, .slurredSpeech],
        symptoms: [],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Tuberculosis",
        notes: "Bacterial infection, mainly of the lungs.",
        signs: [.cough, .sneeze, .sputum, .redSputum, .fever, .coldSweat, .weightLoss],
        symptoms: [.chestPain, .anorexia, .shortnessOfBreath],
        bodySystem: .respiratory
    ),
    Condition(
        name: "COPD",
        notes: "A blanket term for several diseases (emphysema, chronic bronchitis, etc).",
        signs: [.cough, .thickSputum, .weightLoss, .barrelChest, .swollenFeet, .swollenLegs, .swollenAnkles, .tripodPosition, .increasedWorkOfBreathing, .cyanosis],
        symptoms: [.shortnessOfBreath, .difficultySleeping, .morningHeadaches, .chronicFatigue],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Esophageal varices",
        notes: "Presence of varices under the esophageal mucosa, which when ruptured can cause the patient to bleed out.",
        signs: [.bleedingMouth, .hematemesis],
        symptoms: [],
        bodySystem: .respiratory
    ),
    Condition(
        name: "Myocardial infarction",
        notes: "Death of cells of the heart due to oxygen deprivation as a result of coronary occlusion.",
        signs: [.tachycardia, .tachypnea, .diaphoresis],
        symptoms: [.nausea, .shortnessOfBreath, .chestPain],
        bodySystem: .cardiovascular
    ),
    Condition(
        name: "Congestive heart failure (CHF)",
        signs: [.swollenAnkles],
        symptoms: [],
        bodySystem: .cardiovascular
    ),
    Condition(
        name: "Angina pectoris",
        signs: [],
        symptoms: [],
        bodySystem: .cardiovascular
    ),
    Condition(
        name: "Cerebral edema",
        signs: [],
        symptoms: [],
        bodySystem: .cardiovascular
    ),
    Condition(
        name: "Seizure",
        signs: [],
        symptoms: [],
        bodySystem: .neurologic
    ),
    Condition(
        name: "Stroke",
        signs: [],
        symptoms: [],
        bodySystem: .neurologic
    ),
    Condition(
        name: "Syncope",
        signs: [],
        symptoms: [],
        bodySystem: .neurologic
    ),
    Condition(
        name: "Transient ischemic attack (TIA)",
        signs: [],
        symptoms: [],
        bodySystem: .neurologic
    ),
    Condition(
        name: "Appendicitis",
        signs: [.vomiting],
        symptoms: [.nausea],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Diverticulitis",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Pancreatitis",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Esophagitis",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Gastroesophageal reflux disease (GERD)",
        signs: [],
        symptoms: [.nausea],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Peptic ulcer disease",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Gastritis",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "GI hemorrhage",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Mallory-Weiss tear",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Boerhaave syndrome",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Hemorrhoids",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Gallstones",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Gastroenteritis",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Ulcerative colitis",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Irritable bowel syndrome (IBS)",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Crohn's disease",
        signs: [],
        symptoms: [],
        bodySystem: .gastrointestinal
    ),
    Condition(
        name: "Urinary tract infection (UTI)",
        signs: [],
        symptoms: [],
        bodySystem: .urologic
    ),
    Condition(
        name: "Pyelonephritis",
        signs: [],
        symptoms: [],
        bodySystem: .urologic
    ),
    Condition(
        name: "Kidney stones",
        signs: [],
        symptoms: [],
        bodySystem: .urologic
    ),
    Condition(
        name: "Acute kidney injury (AKI)",
        signs: [],
        symptoms: [],
        bodySystem: .urologic
    ),
    Condition(
        name: "Oliguria",
        signs: [],
        symptoms: [],
        bodySystem: .urologic
    ),
    Condition(
        name: "End-stage renal disease (ESRD)",
        signs: [],
        symptoms: [],
        bodySystem: .urologic
    ),
    Condition(
        name: "Diabetes mellitus",
        signs: [],
        symptoms: [],
        bodySystem: .endocrine
    ),
    Condition(
        name: "Sickle cell disease",
        signs: [],
        symptoms: [],
        bodySystem: .hematologic
    ),
    Condition(
        name: "Hemophillia",
        signs: [],
        symptoms: [],
        bodySystem: .hematologic
    ),
    Condition(
        name: "Anaphylaxis",
        signs: [],
        symptoms: [],
        bodySystem: .immunologic
    ),
    Condition(
        name: "Substance abuse",
        signs: [],
        symptoms: [],
        bodySystem: .toxicologic
    ),
    Condition(
        name: "Food poisoning",
        signs: [],
        symptoms: [],
        bodySystem: .toxicologic
    ),
    Condition(
        name: "Plant poisoning",
        signs: [],
        symptoms: [],
        bodySystem: .toxicologic
    ),
    Condition(
        name: "Chemical poisoning",
        signs: [],
        symptoms: [],
        bodySystem: .toxicologic
    ),
    Condition(
        name: "Alzheimer disease",
        signs: [],
        symptoms: [],
        bodySystem: .psychiatric
    ),
    Condition(
        name: "Schizophrenia",
        signs: [],
        symptoms: [],
        bodySystem: .psychiatric
    ),
    Condition(
        name: "Depression",
        signs: [],
        symptoms: [],
        bodySystem: .psychiatric
    ),
    Condition(
        name: "Vaginal bleeding",
        signs: [],
        symptoms: [],
        bodySystem: .gynecologic
    ),
    Condition(
        name: "Sexually transmitted infection (STI)",
        signs: [],
        symptoms: [],
        bodySystem: .gynecologic
    ),
    Condition(
        name: "Pelvic inflammatory disease (PID)",
        signs: [],
        symptoms: [],
        bodySystem: .gynecologic
    ),
    Condition(
        name: "Ectopic pregnancy",
        signs: [],
        symptoms: [],
        bodySystem: .gynecologic
    ),
    Condition(
        name: "Pre-eclampsia",
        signs: [],
        symptoms: [],
        bodySystem: .gynecologic
    ),
    Condition(
        name: "Eclampsia",
        signs: [],
        symptoms: [],
        bodySystem: .gynecologic
    ),
]
