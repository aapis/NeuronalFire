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

    @Environment(\.colorScheme) var colorScheme
    private let pa: PatientAssessment = PatientAssessment()
    @State private var current: Coordinates// = Coordinates()
    @State private var type: PAType = .medical

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image(systemName: "stethoscope")
                    .foregroundStyle(.gray)
                Text("PA Guide")
                Spacer()
            }
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding([.leading, .top, .bottom])

            HStack(alignment: .center, spacing: 0) {
                ForEach(PAType.allCases, id: \.hashValue) { incidentType in
                    HStack {
                        Spacer()
                        Button {
                            self.type = incidentType
                        } label: {
                            Text(incidentType.label)
                                .padding()
                        }
                        Spacer()
                    }
                    .background(self.type == incidentType ? incidentType.colour : .black.opacity(0.4))
                }
            }

            VStack(alignment: .leading, spacing: 0) {
                PatientAssessment.Views.SectionList(pa: self.pa, current: $current, type: $type)
//                    PrimaryAssessment.Views.Progress(pa: self.pa, current: $current)
//                        .background(type.colour)
            }
        }
        .foregroundStyle(colorScheme == .dark ? .white : .black)
        .scrollDismissesKeyboard(.immediately)
//        .toolbar()
    }

    init() {
        self.current = Coordinates()
    }
}
