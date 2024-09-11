//
//  PatientAssessmentGuide.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-08-29.
//

import SwiftUI

struct PatientAssessmentGuide: View {
    typealias Coordinates = ScenarioCoordinates
    typealias PAType = ScenarioType
    typealias Requirement = ScenarioRequirement

    @Environment(\.colorScheme) var colourScheme
    private let pa: PatientAssessment = PatientAssessment()
    @State private var current: Coordinates// = Coordinates()
    @State private var type: PAType = .medical

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "stethoscope")
                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple.opacity(0.6) : .neuronalGreen.opacity(0.6))
                Text("PA Guide")
                Spacer()
            }
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding([.leading, .top, .bottom])
            .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)

            HStack(alignment: .center, spacing: 8) {
                ForEach(PAType.allCases, id: \.hashValue) { incidentType in
                    HStack(alignment: .center, spacing: 1) {
                        Spacer()
                        Button {
                            self.type = incidentType
                        } label: {
                            Text(incidentType.label)
                                .padding()
                        }
                        Spacer()
                    }
                    .foregroundStyle(.white)
                    .background(self.type == incidentType ? (colourScheme == .dark ? .neuronalGreen : .neuronalPurple) : (colourScheme == .dark ? .neuronalGreen.opacity(0.3) : .neuronalPurple.opacity(0.3)))
                    .clipShape(RoundedRectangle(cornerRadius: 3))
                }
            }
            .padding()
            Divider()

            VStack(alignment: .leading, spacing: 0) {
                PatientAssessment.Views.SectionList(pa: self.pa, current: $current, type: $type)
                //                    PrimaryAssessment.Views.Progress(pa: self.pa, current: $current)
                //                        .background(type.colour)
            }
        }
        .background(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        .scrollDismissesKeyboard(.immediately)
//        .toolbar()
    }

    init() {
        self.current = Coordinates()
    }
}
