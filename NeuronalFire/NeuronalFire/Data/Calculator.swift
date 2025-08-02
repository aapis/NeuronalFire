//
//  Calculator.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-07-31.
//

import SwiftUI

enum Units: CaseIterable {
    case ml, mcg, g
    
    var id: Int {
        switch self {
        case .ml: 0
        case .mcg: 1
        case .g: 2
        }
    }
    
    var label: String {
        switch self {
        case .ml: "ml"
        case .mcg: "mcg"
        case .g: "g"
        }
    }
}

public struct Calculator: Identifiable {
    public var id: UUID = UUID()
    var label: String
    var icon: String = "function"
    var view: AnyView?
    
    struct MedicationDoseView: View {
        @Environment(\.colorScheme) var colourScheme
        @State private var desiredDose: Float = 1.0
        @State private var availableDose: Float = 1.0
        @State private var desiredDoseStr: String = ""
        @State private var availableDoseStr: String = ""
        @State private var result: Float = 0.0
        @State private var resultStr: String = "0.0"
        @State private var factor: Float = 1.0
        @State private var factorStr: String = "1.0"
        @State private var selectedUnit: Units = .ml
        @FocusState private var focused: Bool

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                PageHeader(icon: "function", title: "Medication Dose")
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
                    TextField("", text: $desiredDoseStr, prompt: Text("Want").foregroundStyle(.gray))
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
                        .focused(self.$focused)
                    TextField("", text: $availableDoseStr, prompt: Text("Have").foregroundStyle(.gray))
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
                        TextField("", text: $factorStr, prompt: Text("Volume").foregroundStyle(.gray))
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
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .onAppear(perform: self.actionOnAppear)
        }
    }
    
    struct DripRateView: View {
        @Environment(\.colorScheme) var colourScheme

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                PageHeader(icon: "function", title: "Drip Rate")
                Spacer()
            }
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        }
    }
    
    struct ShockIndexView: View {
        @Environment(\.colorScheme) var colourScheme
        @State private var heartRate: Double = 0
        @State private var heartRateStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var systolicBp: Double = 0
        @State private var systolicBpStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var diastolicBp: Double = 0
        @State private var diastolicBpStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var result: Double = 0.0
        @State private var map: Double = 0
        @FocusState private var focused: Bool
        private var columns: [GridItem] { return Array(repeating: GridItem(.flexible(), spacing: 1), count: 2) }

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                PageHeader(icon: "function", title: "Shock Index")
                ScrollView(.vertical) {
                    VStack {
                        ZStack(alignment: .trailing) {
                            TextField("", text: self.$heartRateStr, prompt: Text("HR").foregroundStyle(.gray))
                                .onChange(of: self.heartRateStr) {
                                    self.actionRecalculate()
                                }
                                .padding()
                                .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                                .focused(self.$focused)
#if os(iOS)
                                .keyboardType(.numberPad)
#endif
                            if self.heartRate > 0 {
                                Button {
                                    self.heartRate = 0
                                    self.heartRateStr = ""
                                    self.map = 0
                                } label: {
                                    Image(systemName: "xmark.app.fill")
                                        .foregroundStyle(.white)
                                        .padding(.trailing)
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        
                        HStack {
                            ZStack(alignment: .trailing) {
                                TextField("", text: self.$systolicBpStr, prompt: Text("Systolic").foregroundStyle(.gray))
                                    .onChange(of: self.systolicBpStr) {
                                        self.actionRecalculate()
                                    }
                                    .padding()
                                    .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                                    .keyboardType(.numberPad)
#endif
                                if self.systolicBp > 0 {
                                    Button {
                                        self.systolicBp = 0
                                        self.systolicBpStr = ""
                                        self.map = 0
                                    } label: {
                                        Image(systemName: "xmark.app.fill")
                                            .foregroundStyle(.white)
                                            .padding(.trailing)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            
                            ZStack(alignment: .trailing) {
                                TextField("", text: self.$diastolicBpStr, prompt: Text("Diastolic").foregroundStyle(.gray))
                                    .onChange(of: self.diastolicBpStr) {
                                        self.actionRecalculate()
                                    }
                                    .padding()
                                    .background(colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                                    .keyboardType(.numberPad)
#endif
                                if self.diastolicBp > 0 {
                                    Button {
                                        self.diastolicBp = 0
                                        self.diastolicBpStr = ""
                                        self.map = 0
                                    } label: {
                                        Image(systemName: "xmark.app.fill")
                                            .foregroundStyle(.white)
                                            .padding(.trailing)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        
                        VStack {
                            LazyVGrid(columns: self.columns, alignment: .leading) {
                                Text("Shock Index")
                                Text("MAP")
                            }
                            LazyVGrid(columns: self.columns, alignment: .leading) {
                                Text(String(format: "%.2f", self.result))
                                    .foregroundStyle(self.result == 0.0 ? .gray : self.result > 0.7 ? .yellow : .green)
                                Text(String(format: "%.0f", self.map))
                                    .foregroundStyle(.gray)
                            }
                        }
                        .padding()
                        .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                        .background(self.colourScheme == .dark ? .neuronalGreen.opacity(0.6) : .neuronalPurple.opacity(0.6))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    .padding()
                    Spacer()
                }
            }
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .onAppear(perform: self.actionOnAppear)
            .scrollDismissesKeyboard(.immediately)
        }
    }
    
    struct PoundToKilosView: View {
        @Environment(\.colorScheme) var colourScheme
        @State private var weight: Int = 0
        @State private var weightStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var pounds: Double = 0
        @State private var kilograms: Double = 0
        @FocusState private var focused: Bool

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                PageHeader(icon: "function", title: "LBS to KG")
                VStack {
                    TextField("", text: self.$weightStr, prompt: Text("Weight").foregroundStyle(.gray))
                        .onChange(of: self.weightStr) {
                            self.actionRecalculate()
                        }
                        .padding()
                        .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                        .keyboardType(.numberPad)
#endif
                        .focused(self.$focused)
                    VStack {
                        HStack {
                            Text("Pounds")
                            Spacer()
                            Text(String(format: "%.1f", self.pounds))
                                .foregroundStyle(.yellow)
                        }
                        HStack {
                            Text("Kilograms")
                            Spacer()
                            Text(String(format: "%.1f", self.kilograms))
                                .foregroundStyle(.yellow)
                        }
                    }
                    .padding()
                    .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                    .background(self.colourScheme == .dark ? .neuronalGreen.opacity(0.6) : .neuronalPurple.opacity(0.6))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .padding()
                Spacer()
            }
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .onAppear(perform: self.actionOnAppear)
        }
    }
}

extension Calculator.ShockIndexView {
    /// Fires on load
    /// - Returns: Void
    private func actionOnAppear() -> Void {
        self.focused = true
    }
    
    /// Calculates the shock index value
    /// - Returns: Void
    private func actionRecalculate() -> Void {
        if let fHr = Double(self.heartRateStr) {
            self.heartRate = fHr
            if let fBp = Double(self.systolicBpStr) {
                self.systolicBp = fBp
                self.result = self.heartRate / self.systolicBp
                
                if let fDiastolic = Double(self.diastolicBpStr) {
                    self.diastolicBp = fDiastolic
                    let pulsePressure = self.systolicBp - self.diastolicBp
                    self.map = self.diastolicBp + Double(pulsePressure / 3)
                }
            }
        }
    }
}

extension Calculator.MedicationDoseView {
    /// Fires on load
    /// - Returns: Void
    private func actionOnAppear() -> Void {
        self.focused = true
    }

    /// Calculates medication dose
    /// - Returns: Void
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

extension Calculator.PoundToKilosView {
    /// Fires on load
    /// - Returns: Void
    private func actionOnAppear() -> Void {
        self.focused = true
    }

    /// Calculates lbs->kg or vice-versa
    /// - Returns: Void
    private func actionRecalculate() -> Void {
        self.kilograms = 0
        self.pounds = 0

        if let dWeight = Double(self.weightStr) {
            let half = dWeight / 2
            let pct = half * 0.1
            self.kilograms = half - pct
            self.pounds = dWeight
        }
    }
}
