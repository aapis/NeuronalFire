//
//  Home.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2024-08-29.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Image(systemName: "staroflife.fill")
                        .foregroundStyle(.gray)
                    Text("NeuronalFire")
                    Spacer()
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding([.leading, .top, .bottom])

                List {
                    NavigationLink {
                        GCSCalculator()
                    } label: {
                        Text("GCS Calculator")
                    }
                    NavigationLink {
                        PatientAssessmentGuide()
                    } label: {
                        Text("Patient Assessment Guide")
                    }
                }
            }
        }
    }
}
