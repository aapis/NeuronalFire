//
//  Home.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-08-29.
//

import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) var colourScheme
    private var references: [Page] = [
        Page(
            label: "Acronyms",
            icon: "textformat.superscript",
            view: AnyView(Terms())
        ),
        Page(
            label: "Differential Explorer",
            icon: "folder",
            view: AnyView(DifferentialExplorer())
        ),
        Page(
            label: "Formulary Explorer",
            icon: "folder"
        ),
        Page(
            label: "Patient Assessment Guide",
            icon: "stethoscope",
            view: AnyView(PatientAssessmentGuide())
        )
    ]
    private var calculators: [Page] = [
        Page(
            label: "GCS",
            view: AnyView(GCSCalculator())
        ),
        Page(
            label: "LAMS",
            view: AnyView(LAMSCalculator())
        ),
        Page(
            label: "Medication Dose",
            view: AnyView(Page.MedicationDoseView())
        ),
        Page(
            label: "Drip Rate",
            view: AnyView(Page.DripRateView())
        ),
        Page(
            label: "Shock Index",
            view: AnyView(Page.ShockIndexView())
        ),
        Page(
            label: "Weight-based Doses",
            view: AnyView(Page.PoundToKilosView())
        )
    ]

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "staroflife.fill")
                        .foregroundStyle(colourScheme == .dark ? .neuronalPurple.opacity(0.6) : .neuronalGreen.opacity(0.6))
                    Text("NeuronalFire")
                    Spacer()
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding([.leading, .top, .bottom])
                .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)

                List {
                    Section("Reference") {
                        ForEach(self.references) { ref in
                            NavigationLink {
                                ref.view
                            } label: {
                                HStack(alignment: .center) {
                                    Image(systemName: ref.icon)
                                        .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                    Text(ref.label)
                                }
                            }
                            .listRowBackground(self.colourScheme == .dark ? Color.neuronalGreen : Color.white)
                        }
                    }
                    Section("Calculators") {
                        ForEach(self.calculators) { calc in
                            NavigationLink {
                                calc.view
                            } label: {
                                HStack(alignment: .center) {
                                    Image(systemName: calc.icon)
                                        .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                    Text(calc.label)
                                }
                            }
                            .listRowBackground(self.colourScheme == .dark ? Color.neuronalGreen : Color.white)
                        }
                    }
                }
                .background(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                .scrollContentBackground(.hidden)
            }
        }
//        .toolbarBackground(.visible, for: .navigationBar)
    }
}
