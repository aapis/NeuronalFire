//
//  PatientAssessmentViews.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-09-11.
//

import SwiftUI

extension PatientAssessment {
    struct Views {
        struct Progress: View {
            typealias Coordinates = ScenarioCoordinates

            @State public var pa: PatientAssessment
            @Binding public var current: Coordinates

            var body: some View {
                VStack(alignment: .center, spacing: 0) {
                    HStack(alignment: .center, spacing: 0) {
                        Button {
                            self.actionOnNext()
                        } label: {
                            Text("Next")
                                .padding()
                        }
                        Spacer()
                    }
                }
            }
        }

        struct SectionList: View {
            typealias Coordinates = ScenarioCoordinates

            @State public var pa: PatientAssessment
            @Binding public var current: Coordinates
            @Binding public var type: ScenarioType
            @State public var selectedRequirements: Set<ScenarioRequirement> = []

            var body: some View {
                ScrollView(showsIndicators: false) {
                    ForEach(self.pa.scenarios, id: \.id) { scenario in
                        if scenario.type == self.type {
                            ForEach(scenario.sections, id: \.id) { section in
                                if !section.subSections.isEmpty {
                                    DecisionPoint(section: section, current: $current, type: $type, selectedRequirements: $selectedRequirements)
                                } else {
                                    SingleSection(section: section, current: $current, type: $type, selectedRequirements: $selectedRequirements, open: false)
                                }
                            }
                        }
                    }
                }
                .padding()
            }
        }

        struct DecisionPoint: View {
            typealias Coordinates = ScenarioCoordinates

            @Environment(\.colorScheme) var colourScheme
            @State public var section: ScenarioSection
            @Binding public var current: Coordinates
            @Binding public var type: ScenarioType
            @Binding public var selectedRequirements: Set<ScenarioRequirement>

            var body: some View {
                VStack(alignment: .leading, spacing: 0) {
                    if let name = section.name {
                        HStack(alignment: .center) {
                            Image(systemName: "stethoscope")
                                .foregroundStyle(.gray)
                            Text(name)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .font(.title2)
                        .bold()
                        .padding()
                        .background(.white.opacity(0.6))
                    }

                    ForEach(section.requirements) { req in
                        SingleRequirement(requirement: req, current: $current, selectedRequirements: $selectedRequirements)
                    }

                    if section.decisionPointRapidOrFocusedChoices != nil {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(section.decisionPointRapidOrFocusedChoices!, id: \.self) { iType in
                                Button {
                                    current.decisionPointRapidOrFocused = iType
                                } label: {
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Spacer()
                                            Text(iType.label)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .background(iType == current.decisionPointRapidOrFocused ? type.colour : (colourScheme == .dark ? Color.neuronalGreen : Color.neuronalPurple))
                                }
                            }
                        }
                        .background(.gray)
                        .border(width: 5, edges: [.bottom], color: type.colour)

                        if current.decisionPointRapidOrFocused != nil {
                            ForEach(section.subSections, id: \.id) { subSection in
                                if current.decisionPointRapidOrFocused == subSection.decisionPointRapidOrFocused {
                                    SingleSection(
                                        section: subSection,
                                        current: $current,
                                        type: $type,
                                        selectedRequirements: $selectedRequirements,
                                        open: current.decisionPointRapidOrFocused == subSection.decisionPointRapidOrFocused
                                    )
                                }
                            }
                        }

                    } else if section.decisionPointOngoingOrSecondaryChoices != nil {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(section.decisionPointOngoingOrSecondaryChoices!, id: \.self) { iType in
                                Button {
                                    current.decisionPointOngoingOrSecondary = iType
                                } label: {
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Spacer()
                                            Text(iType.label)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .background(iType == current.decisionPointOngoingOrSecondary ? type.colour : (colourScheme == .dark ? Color.neuronalGreen : Color.neuronalPurple))
                                }
                            }
                        }
                        .background(.gray)
                        .border(width: 5, edges: [.bottom], color: type.colour)

                        if current.decisionPointOngoingOrSecondary != nil {
                            ForEach(section.subSections, id: \.id) { subSection in
                                if current.decisionPointOngoingOrSecondary == subSection.decisionPointOngoingOrSecondary {
                                    SingleSection(
                                        section: subSection,
                                        current: $current,
                                        type: $type,
                                        selectedRequirements: $selectedRequirements,
                                        open: current.decisionPointOngoingOrSecondary == subSection.decisionPointOngoingOrSecondary
                                    )
                                }
                            }
                        }
                    } else if section.decisionPointPhysicalOrReassessChoices != nil {
                        HStack(alignment: .center, spacing: 0) {
                            ForEach(section.decisionPointPhysicalOrReassessChoices!, id: \.self) { iType in
                                Button {
                                    current.decisionPointPhysicalOrReassess = iType
                                } label: {
                                    HStack(alignment: .center, spacing: 0) {
                                        HStack {
                                            Spacer()
                                            Text(iType.icon).font(.title2)
                                                .padding()
                                            Spacer()
                                        }
                                    }
                                    .background(iType == current.decisionPointPhysicalOrReassess ? type.colour : (colourScheme == .dark ? Color.neuronalGreen : Color.neuronalPurple))
                                }
                            }
                        }
                        .background(.gray)
                        .border(width: 5, edges: [.bottom], color: type.colour)

                        if current.decisionPointPhysicalOrReassess != nil {
                            ForEach(section.subSections, id: \.id) { subSection in
                                if current.decisionPointPhysicalOrReassess == subSection.decisionPointPhysicalOrReassess {
                                    SingleSection(
                                        section: subSection,
                                        current: $current,
                                        type: $type,
                                        selectedRequirements: $selectedRequirements,
                                        open: current.decisionPointPhysicalOrReassess == subSection.decisionPointPhysicalOrReassess
                                    )
                                }
                            }
                        }
                    }
                }
            }
        }

        struct SingleRequirement: View {
            typealias Coordinates = ScenarioCoordinates

            @Environment(\.colorScheme) var colourScheme
            @State public var requirement: ScenarioRequirement
            @Binding public var current: Coordinates
            @Binding public var selectedRequirements: Set<ScenarioRequirement>
            @State private var completed: Bool = false

            var body: some View {
                VStack(alignment: .leading, spacing: 0) {
                    Button {
                        self.completed.toggle()
                        self.requirement.completed.toggle()

                        if self.selectedRequirements.contains(self.requirement) {
                            self.selectedRequirements.remove(self.requirement)
                        } else {
                            self.selectedRequirements.insert(self.requirement)
                        }
                    } label: {
                        HStack(alignment: .center, spacing: 0) {
                            HStack(alignment: .center, spacing: 0) {
                                Text(requirement.description)
                                    .multilineTextAlignment(.leading)
                            }
                            Spacer()
                            HStack(alignment: .center, spacing: 0) {
                                Image(systemName: self.completed ? "checkmark.square.fill" : "checkmark.square")
                                    .font(.title2)
                                    .opacity(0.4)
                            }

                        }
                        .padding(8)
                        .foregroundStyle(self.completed ? .gray : .neuronalPurple)
                        .background(self.completed ? .green : self.requirement.importance == .critical ? .yellow : .white.opacity(0.4))
                    }

                    if self.requirement.notes != nil && !self.completed {
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "note.text")
                            Text(self.requirement.notes!)
                            Spacer()
                        }
                        .padding(8)
                        .font(.caption)
                        .foregroundStyle(.neuronalPurple)
                        .background(current.requirement == self.requirement.id ? .blue : self.requirement.importance == .critical ? .yellow : .white.opacity(0.3))
                    }
                }
            }
        }

        struct SingleSection: View {
            typealias Coordinates = ScenarioCoordinates

            @Environment(\.colorScheme) var colourScheme
            public var section: ScenarioSection
            @Binding public var current: Coordinates
            @Binding public var type: ScenarioType
            @Binding public var selectedRequirements: Set<ScenarioRequirement>
            @State public var open: Bool
            @State private var completed: Bool = false
            @State private var totalRequirementCount: Int = 0
            @State private var selectedRequirementCount: Int = 0

            var body: some View {
                VStack(alignment: .leading, spacing: 1) {
                    if let name = section.name {
                        Button {
                            self.completed.toggle()

                            // @TODO: check all sub-items
                        } label: {
                            HStack(alignment: .center, spacing: 0) {
                                HStack(alignment: .center, spacing: 0) {
                                    Text(name)
                                        .multilineTextAlignment(.leading)
                                            .bold()
                                    Spacer()
                                    
                                    if section.requirements.count > 0 {
                                        Text("\(self.selectedRequirementCount)/\(self.totalRequirementCount)")
                                            .font(.system(.callout, design: .monospaced))
                                            .opacity(0.4)
                                    }
                                }
                                Spacer()
                                HStack(alignment: .center, spacing: 0) {
                                    Image(systemName: self.completed ? "checkmark.square.fill" : "checkmark.square")
                                        .opacity(0.4)
                                }
                            }
                            .font(.title2)
                            .padding(8)
                            .foregroundStyle(self.completed ? .gray : colourScheme == .dark ? .white : .black)
                            //                        .foregroundStyle(current.section == section.id ? .white : .gray)
                            .background(self.completed ? .green : current.section == section.id ? .blue : .gray.opacity(0.6))
                        }
                    }

                    if !self.completed {
                        ForEach(section.requirements) { req in
                            SingleRequirement(requirement: req, current: $current, selectedRequirements: $selectedRequirements)
                        }

                        ForEach(section.subSections, id: \.id) { subSection in
                            HStack(alignment: .center, spacing: 1) {
                                Rectangle()
                                    .foregroundStyle(type.colour)
                                    .frame(width: 5)
                                SingleSection(
                                    section: subSection,
                                    current: $current,
                                    type: $type,
                                    selectedRequirements: $selectedRequirements,
                                    open: open
                                )
                            }
                        }
                    }
                }
                .onAppear(perform: self.actionOnAppear)
                .onChange(of: self.selectedRequirements) {
                    self.actionOnAppear()
                }
            }
        }
    }
}

extension PatientAssessment.Views.SingleSection {
    /// Onload handler
    /// - Returns: Void
    private func actionOnAppear() -> Void {
        self.selectedRequirementCount = self.section.requirements.count(where: {$0.completed == true})
        self.totalRequirementCount = self.section.requirements.count
    }
}

extension PatientAssessment.Views.Progress {
    private func actionOnNext() -> Void {
//        if let typeIndex = self.pa.sections.firstIndex(where: {$0.id == current.section}) {
//        if let currentIndex = self.pa.sections.firstIndex(where: {$0.id == current.section}) {
//            let nextIndex = self.pa.sections.index(after: currentIndex)
//            if let nextSection = self.pa.sections.enumerated().filter({$0.offset == nextIndex}).first {
//                if let currentSection = self.pa.sections.enumerated().filter({$0.offset == currentIndex}).first {
//                    let lastRequirementInSection = currentSection.element.requirements.last
//                    let currentRequirementIndex = currentSection.element.requirements.firstIndex(where: {$0.id == current.requirement}) ?? 0
//                    let currentRequirement = currentSection.element.requirements.enumerated().filter({$0.offset == currentRequirementIndex}).first
//                    let nextRequirementIndex = currentSection.element.requirements.index(after: currentRequirementIndex)
//                    let nextRequirement = currentSection.element.requirements.enumerated().filter({$0.offset == nextRequirementIndex}).first
//                    let nextSectionFirstRequirement = nextSection.element.requirements.first
//
//                    if let nReq = nextRequirement?.element {
//                        if nReq.id == lastRequirementInSection?.id {
//                            current.section = nextSection.element.id
//                            current.requirement = nextSectionFirstRequirement?.id
//                            print("DERPO changed sections to \(current.section!)")
//                            print("DERPO changed requirement to \(current.requirement!)")
//                        } else {
//                            current.requirement = nextRequirement?.element.id
//                            print("DERPO changed requirement to \(current.requirement!)")
//                        }
//                    }
//                }
//            }
//        }
    }
}
