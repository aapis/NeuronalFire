//
//  Home.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-08-29.
//

import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) var colourScheme
    private var calculators: [Calculator] = [
        Calculator(
            label: "GCS",
            view: AnyView(GCSCalculator())
        ),
        Calculator(
            label: "LAMS",
            view: AnyView(LAMSCalculator())
        ),
        Calculator(
            label: "Medication Dose",
            view: AnyView(Calculator.MedicationDoseView())
        ),
        Calculator(
            label: "Drip Rate",
            view: AnyView(Calculator.DripRateView())
        ),
        Calculator(
            label: "Shock Index",
            view: AnyView(Calculator.ShockIndexView())
        ),
        Calculator(
            label: "LBS to KG",
            view: AnyView(Calculator.PoundToKilosView())
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
                        NavigationLink {
                            Terms()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "textformat.superscript")
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                Text("Acronyms")
                            }
                        }
                        .listRowBackground(colourScheme == .dark ? Color.neuronalGreen : Color.white)

                        NavigationLink {
                            PatientAssessmentGuide()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "stethoscope")
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                Text("Patient Assessment Guide")
                            }
                        }
                        .listRowBackground(colourScheme == .dark ? Color.neuronalGreen : Color.white)
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
