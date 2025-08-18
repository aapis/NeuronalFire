//
//  DifferentialExplorer.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-08-16.
//

import SwiftUI

struct DifferentialExplorer: View {
    @Environment(\.colorScheme) var colourScheme
    @State private var bodySystems: Set<BodySystem> = []
    @State private var signs: Set<Sign> = []
    @State private var symptoms: Set<Symptom> = []
    private var columns: [GridItem] { return Array(repeating: GridItem(.flexible(), spacing: 1), count: 2) }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PageHeader(icon: "folder", title: "Differential")
            VStack(alignment: .leading) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading) {
                        GroupLabel(label: "Signs")
                        LazyVGrid(columns: self.columns, alignment: .leading) {
                            ForEach(Sign.allCases.sorted(by: {$0.label < $1.label}), id: \.self) { sys in
                                SignFilter(sign: sys, selected: self.$signs)
                            }
                        }
                        .padding(.bottom, 8)
                        GroupLabel(label: "Symptoms")
                        LazyVGrid(columns: self.columns, alignment: .leading) {
                            ForEach(Symptom.allCases.sorted(by: {$0.label < $1.label}), id: \.self) { sys in
                                SymptomFilter(symptom: sys, selected: self.$symptoms)
                            }
                        }
                        .padding(.bottom, 8)
                        GroupLabel(label: "Body systems")
                        LazyVGrid(columns: self.columns, alignment: .leading) {
                            ForEach(BodySystem.allCases.sorted(by: {$0.label < $1.label}), id: \.self) { sys in
                                BodySystemFilter(bodySystem: sys, selected: self.$bodySystems)
                            }
                        }
                    }
                    .padding(8)
                }
                GroupLabel(label: "Matches")
                    .padding([.leading, .trailing], 8)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 1) {
                        ForEach(DifferentialConditions.sorted(by: {$0.name < $1.name}).filter({
                            // @TODO: this could probably be refactored
                            var results: [Bool] = []
                            // Check if bodySystem is a match
                            results.append(self.bodySystems.contains($0.bodySystem))
                            // Check if symptoms match
                            for symptom in self.symptoms {
                                results.append($0.symptoms.contains(symptom))
                            }
                            // Check if signs match
                            for sign in self.signs {
                                results.append($0.signs.contains(sign))
                            }
                            // We only care about TRUE values
                            return results.filter({$0 == true}).count > 0
                        })) { condition in
                            ConditionItem(condition: condition)
                        }
                    }
                }
            }
        }
        .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
    }
}

struct GroupLabel: View {
    var label: String
    
    var body: some View {
        Text(self.label.uppercased())
            .font(.caption)
    }
}

struct BodySystemFilter: View {
    var bodySystem: BodySystem
    @Binding public var selected: Set<BodySystem>

    var body: some View {
        Button {
            if self.selected.contains(self.bodySystem) {
                self.selected.remove(self.bodySystem)
            } else {
                self.selected.insert(self.bodySystem)
            }
        } label: {
            HStack(alignment: .top) {
                Image(systemName: self.selected.contains(self.bodySystem) ? "checkmark.square" : "square")
                Text(self.bodySystem.label)
            }
            .foregroundStyle(self.selected.contains(self.bodySystem) ? .white : .white.opacity(0.5))
        }
        .buttonStyle(.plain)
    }
}

struct SignFilter: View {
    var sign: Sign
    @Binding public var selected: Set<Sign>

    var body: some View {
        Button {
            if self.selected.contains(self.sign) {
                self.selected.remove(self.sign)
            } else {
                self.selected.insert(self.sign)
            }
        } label: {
            HStack(alignment: .top) {
                Image(systemName: self.selected.contains(self.sign) ? "checkmark.square" : "square")
                Text(self.sign.label)
            }
            .foregroundStyle(self.selected.contains(self.sign) ? .white : .white.opacity(0.5))
        }
        .buttonStyle(.plain)
    }
}

struct SignItem: View {
    var sign: Sign

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "arrowtriangle.forward.square.fill")
                .symbolRenderingMode(.hierarchical)
            Text(self.sign.label)
            Spacer()
        }
    }
}

struct SymptomFilter: View {
    var symptom: Symptom
    @Binding public var selected: Set<Symptom>

    var body: some View {
        Button {
            if self.selected.contains(self.symptom) {
                self.selected.remove(self.symptom)
            } else {
                self.selected.insert(self.symptom)
            }
        } label: {
            HStack(alignment: .top) {
                Image(systemName: self.selected.contains(self.symptom) ? "checkmark.square" : "square")
                Text(self.symptom.label)
            }
            .foregroundStyle(self.selected.contains(self.symptom) ? .white : .white.opacity(0.5))
        }
        .buttonStyle(.plain)
    }
}

struct SymptomItem: View {
    var symptom: Symptom

    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "arrowtriangle.forward.square.fill")
                .symbolRenderingMode(.hierarchical)
            Text(self.symptom.label)
            Spacer()
        }
    }
}

struct ConditionItem: View {
    @Environment(\.colorScheme) var colourScheme
    var condition: Condition

    var body: some View {
        NavigationLink {
            ConditionView(condition: self.condition)
        } label: {
            HStack {
                Text(self.condition.name)
                    .foregroundStyle(.neuronalPurple)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundStyle(.gray.opacity(0.5))
                    .bold()
                    .font(.subheadline)
            }
            .padding(10)
            .background(.white)
        }
        .buttonStyle(.plain)
    }
}

struct ConditionView: View {
    @Environment(\.colorScheme) var colourScheme
    var condition: Condition
    private var columns: [GridItem] { return Array(repeating: GridItem(.flexible(), spacing: 1), count: 2) }

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text(self.condition.name)
                        .font(.title)
                    Text(self.condition.notes)
                        .font(.headline)
                        .italic()
                    Divider()
                        .padding(.bottom, 8)
                    GroupLabel(label: "Signs")
                    LazyVGrid(columns: self.columns, alignment: .leading) {
                        ForEach(self.condition.signs, id: \.self) { sign in
                            SignItem(sign: sign)
                        }
                    }
                    .padding([.bottom, .leading], 8)
                    GroupLabel(label: "Symptoms")
                    LazyVGrid(columns: self.columns, alignment: .leading) {
                        ForEach(self.condition.symptoms, id: \.self) { symptom in
                            SymptomItem(symptom: symptom)
                        }
                    }
                    .padding([.bottom, .leading], 8)
                    GroupLabel(label: "Primary body system")
                        .padding(.bottom, 2)
                    HStack {
                        self.condition.bodySystem.icon
                        Text(self.condition.bodySystem.label)
                        Spacer()
                    }
                    .padding([.bottom, .leading], 8)
                }
                .padding()
            }
            Spacer()
            if let url = self.condition.url {
                HStack {
                    Spacer()
                    Link("Open Medical Dictionary", destination: url)
                        .padding()
                        .bold()
                    Spacer()
                }
                .foregroundStyle(.neuronalPurple)
                .background(self.colourScheme == .dark ? .neuronalGreen : .white)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .shadow(radius: 2)
                .padding()
            }
        }
        .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
    }
}
