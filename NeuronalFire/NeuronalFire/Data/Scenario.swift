//
//  Scenario.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-09-09.
//

import SwiftUI

struct Scenario: Identifiable, Equatable {
    var id: UUID = UUID()
    var type: ScenarioType
    var sections: [ScenarioSection]

    static func == (lhs: Scenario, rhs: Scenario) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ScenarioSection: Identifiable {
    var id: UUID = UUID()
    var name: String?
    var requirements: [ScenarioRequirement] = []
    var decisionPointRapidOrFocusedChoices: [ITLSAssessmentType]?
    var decisionPointRapidOrFocused: ITLSAssessmentType?
    var decisionPointOngoingOrSecondaryChoices: [ITLSSecondarySurveyType]?
    var decisionPointOngoingOrSecondary: ITLSSecondarySurveyType?
    var decisionPointPhysicalOrReassessChoices: [MedicalReassessmentType]?
    var decisionPointPhysicalOrReassess: MedicalReassessmentType?
    var action: AnyView?
    var subSections: [ScenarioSection] = []
    // @TODO: some kind of boolean selection method (i.e. Unconscious? tap here, Conscious? tap here)
}

struct ScenarioRequirement: Identifiable, Equatable, Hashable {
    var id: UUID = UUID()
    var description: String
    var importance: Importance
    var notes: String?
    var completed: Bool = false

    enum Importance {
        case normal, critical
    }
}

struct ScenarioCoordinates {
    var section: UUID?
    var requirement: UUID?
    var type: ScenarioType?
    var decisionPointRapidOrFocused: ITLSAssessmentType?
    var decisionPointOngoingOrSecondary: ITLSSecondarySurveyType?
    var decisionPointPhysicalOrReassess: MedicalReassessmentType?
}

enum ScenarioType: CaseIterable {
    case medical, trauma

    var label: String {
        switch self {
        case .medical: "Medical"
        case .trauma: "ITLS Trauma"
        }
    }

    var colour: Color {
        switch self {
        case .medical: .blue
        case .trauma: .red
        }
    }
}

enum ITLSAssessmentType: CaseIterable {
    case rapid, focused

    var label: String {
        switch self {
        case .rapid: "Rapid"
        case .focused: "Focused"
        }
    }
}

enum ITLSSecondarySurveyType: CaseIterable {
    case ongoing, secondary

    var label: String {
        switch self {
        case .ongoing: "Ongoing"
        case .secondary: "Secondary"
        }
    }
}

enum MedicalReassessmentType: CaseIterable {
    case physical, reassess, transport

    var label: String {
        switch self {
        case .physical: "Primary head-to-toe"
        case .reassess: "Secondary head-to-toe"
        case .transport: "Ambulance"
        }
    }

    var icon: Image {
        switch self {
        case .physical: Image(systemName: "1.circle")
        case .reassess: Image(systemName: "2.circle")
        case .transport: Image(systemName: "repeat.circle")
        }
    }
}
