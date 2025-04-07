//
//  Home.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-08-29.
//

import SwiftUI

struct Home: View {
    @Environment(\.colorScheme) var colourScheme

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
                        NavigationLink {
                            GCSCalculator()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "function")
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                Text("GCS")
                            }
                        }
                        .listRowBackground(colourScheme == .dark ? Color.neuronalGreen : Color.white)

                        NavigationLink {
                            LAMSCalculator()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "function")
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                Text("LAMS")
                            }
                        }
                        .listRowBackground(colourScheme == .dark ? Color.neuronalGreen : Color.white)

                        NavigationLink {
                            Medmath()
                        } label: {
                            HStack(alignment: .center) {
                                Image(systemName: "function")
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                Text("Medmath")
                            }
                        }
                        .listRowBackground(colourScheme == .dark ? Color.neuronalGreen : Color.white)
                    }
                }
                .background(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                .scrollContentBackground(.hidden)
            }
        }


//        .toolbarBackground(.visible, for: .navigationBar)

    }
}
