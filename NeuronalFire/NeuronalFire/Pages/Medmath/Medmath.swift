//
//  Medmath.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-04-03.
//

// @TODO: This entire file can be deleted
import SwiftUI

public enum MedMathTab {
    case calculator, formulas
}

struct Medmath: View {
    @Environment(\.colorScheme) var colourScheme
    private var calculators: [Page] = [
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
            label: "LBS to KG",
            view: AnyView(Page.PoundToKilosView())
        )
    ]

    var body: some View {
        VStack {
            PageHeader(icon: "function", title: "Medmath")
            List {
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
        .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        .scrollContentBackground(.hidden)
    }
}

struct Medmath2: View {
    @Environment(\.colorScheme) var colourScheme
    @State private var desiredDose: Float = 1.0
    @State private var availableDose: Float = 1.0
    @State private var desiredDoseStr: String = ""
    @State private var availableDoseStr: String = ""
    @State private var result: Float = 0.0
    @State private var resultStr: String = "0.0"
    @State private var factor: Float = 1.0
    @State private var factorStr: String = "1.0"
    @State private var selectedTab: MedMathTab = .calculator
    @State private var selectedUnit: Units = .ml

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PageHeader(icon: "function", title: "Medmath")
            HStack(alignment: .center) {
                Button {
                    self.selectedTab = .calculator
                } label: {
                    HStack {
                        Spacer()
                        Text("Calculators")
                        Spacer()
                    }
                    .padding([.top, .bottom])
                }
                .buttonStyle(.plain)
                
                Button {
                    self.selectedTab = .formulas
                } label: {
                    HStack {
                        Spacer()
                        Text("Formulas")
                        Spacer()
                    }
                    .padding([.top, .bottom])
                }
                .buttonStyle(.plain)
            }
            .background(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            
            if self.selectedTab == .calculator {
                ScrollView {
                    CalculatorList()
                    VStack(alignment: .leading) {
                        HStack {
                            Spacer()
                            Button {
                                self.result = 0.0
                                self.desiredDose = 1.0
                                self.availableDose = 1.0
                                self.desiredDoseStr = ""
                                self.availableDoseStr = ""
                                self.resultStr = "0.0"
                                self.factor = 1.0
                                self.factorStr = "1.0"
                            } label: {
                                Image(systemName: "xmark")
                                    .padding(10)
                                    .background(.red)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .buttonStyle(.plain)
                        }
                        TextField("Desired dose", text: $desiredDoseStr)
                            .onChange(of: self.desiredDoseStr) {
                                self.actionRecalculateResult()
                            }
                            .padding()
                            .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                            .keyboardType(.decimalPad)
#endif
                        TextField("Available dose", text: $availableDoseStr)
                            .onChange(of: self.availableDoseStr) {
                                self.actionRecalculateResult()
                            }
                            .padding()
                            .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                            .keyboardType(.decimalPad)
#endif
                        HStack {
                            TextField("Factor", text: $factorStr)
                                .onChange(of: self.factorStr) {
                                    self.actionRecalculateResult()
                                }
                                .padding()
                                .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                                .keyboardType(.decimalPad)
#endif
                            Spacer()
                            Picker("Units", selection: self.$selectedUnit) {
                                ForEach(Units.allCases, id: \.self) { type in
                                    Text(type.label).tag(type.id)
                                }
                            }
                        }
                        HStack(alignment: .center) {
                            Spacer()
                            Text(self.resultStr + " \(self.selectedUnit.label)")
                                .bold()
                                .font(.title3)
                            Spacer()
                        }
                        .padding()
                        .background(self.result == 0.0 ? .gray : .green)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                    Spacer()
                }
            } else if self.selectedTab == .formulas {
                ScrollView {
                    Text("MED_DOSES Want / Have * Volume")
                    Text("DRIP_RATE gtts/min * min = gtts/ml * ml")
                    Text("HR/systolic = SHOCK_INDEX")
                    Text("lbs to kg")
                }
            }
        }
        .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        .scrollDismissesKeyboard(.immediately)
    }
    
    struct CalculatorList: View {
        @Environment(\.colorScheme) var colourScheme
        private var calculators: [Page] = [
            Page(label: "Medication Dose"),
            Page(label: "Drip Rate"),
            Page(label: "Shock Index"),
            Page(label: "LBS to KG")
        ]
        
        var body: some View {
            ScrollView(.vertical) {
                VStack(alignment: .leading, spacing: 1) {
                    ForEach(self.calculators) { calc in
                        Button {
                            
                        } label: {
                            HStack {
                                Text(calc.label)
                                Spacer()
                                Image(systemName: "plus")
                            }
                            .padding(8)
                            .background(self.colourScheme == .dark ? .neuronalGreen.opacity(0.3) : .neuronalPurple.opacity(0.3))
                        }
                    }
                }
            }
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .foregroundStyle(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
            .padding()
        }
    }
}

extension Medmath2 {
    private func actionRecalculateResult() -> Void {
        if let fDose = Float(self.desiredDoseStr) {
            if let fADose = Float(self.availableDoseStr) {
                self.desiredDose = fDose
                self.availableDose = fADose
                if let fFactor = Float(self.factorStr) {
                    self.factor = fFactor
                    if self.desiredDose > 0.0 && self.availableDose > 0.0 {
                        self.result = (self.desiredDose/self.availableDose) * self.factor
                        self.resultStr = String(format: "%.2f", self.result)
                    } else {
                        self.resultStr = "0.0"
                    }
                }
            }
        }
    }
}
