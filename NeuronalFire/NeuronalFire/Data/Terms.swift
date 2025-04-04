//
//  Terms.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-03-10.
//

import SwiftUI

struct Acronym: Identifiable, Comparable {
    var id: UUID = UUID()
    var short: String
    var long: String
    var definition: String?
    var variants: [Acronym] = []
    
    /// Less than
    /// - Parameters:
    ///   - lhs: First item
    ///   - rhs: Second item
    /// - Returns: Bool
    static func < (lhs: Acronym, rhs: Acronym) -> Bool {
        return lhs.short < rhs.short
    }
}

struct Terms: View {
    @Environment(\.colorScheme) var colourScheme
    @State private var showSearch: Bool = true
    private let terms: [Acronym] = [
        Acronym(short: "OPQRSTA", long: "Onset, Provocation, Quality, Region/Radiates, Severity, Time, Alleviates"),
        Acronym(
            short: "ABC",
            long: "Airway, Breathing, Circulation",
            variants: [
                Acronym(short: "CABC", long: "Circulation, Airway, Breathing, Circulation")
            ]
        ),
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 0) {
                PageHeader(icon: "textformat.superscript", title: "Acronyms")
                Button {
                    self.showSearch.toggle()
                } label: {
                    Image(systemName: "magnifyingglass")
                        .padding(8)
                }
                .foregroundStyle(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                .mask(Circle())
            }
            .padding(.trailing)
            .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)

            if self.showSearch {
                Filter()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(self.terms.sorted()) { term in
                        VStack(alignment: .leading) {
                            Text(term.short)
                                .bold()
                                .font(.title3)
                            Text(term.long)

                            if !term.variants.isEmpty {
                                ForEach(term.variants.sorted()) { term in
                                    VStack(alignment: .leading) {
                                        Text(term.short)
                                            .bold()
                                            .font(.title3)
                                        Text(term.long)
                                    }
                                }
                                .padding([.leading, .trailing])
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding()
        }
        .background(.neuronalGreen)
    }
}

extension Terms {
    struct Filter: View {
        @Environment(\.colorScheme) var colourScheme
        @State private var filterTerm: String = ""

        var body: some View {
            HStack(alignment: .top) {
                TextField("Filter terms...", text: self.$filterTerm)
            }
            .padding()
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .foregroundStyle(self.colourScheme == .dark ? .white : .neuronalPurple)
            Divider()
                .foregroundStyle(.neuronalPurple)
        }
    }
}
