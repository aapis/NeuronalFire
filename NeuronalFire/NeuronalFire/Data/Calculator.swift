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

enum DropSets: CaseIterable {
    case d10, d20, d60
    
    var id: Double {
        switch self {
        case .d10: 10
        case .d20: 20
        case .d60: 60
        }
    }
    
    var label: String {
        switch self {
        case .d10: "10 gtts"
        case .d20: "20 gtts"
        case .d60: "60 gtts"
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
        @State private var gttsPerMin: Double = 0
        @State private var gttsPerMinStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var min: Double = 0
        @State private var minStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var gttsPerMl: Double = 0
        @State private var gttsPerMlStr: String = "" // @TODO: make obsolete by implementing a TextField that supports Ints
        @State private var ml: Double = 0
        @State private var mlStr: String = ""
        @State private var resultLeft: Double = 0
        @State private var resultRight: Double = 0
        @State private var dripRate: Double = 0
        @State private var calculationSteps: [Line] = [
            Line(text: "gtts/min * min = gtts/mL * mL")
        ]
        @State private var calculationLeft: [Line] = []
        @State private var calculationRight: [Line] = []
        @State private var selectedDropSet: DropSets = .d10
        @FocusState private var focused: Bool
        private var columns: [GridItem] { return Array(repeating: GridItem(.adaptive(minimum: 200, maximum: 200), spacing: 1), count: 3) }

        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                PageHeader(icon: "function", title: "Drip Rate")
                Screen(left: self.$calculationLeft, right: self.$calculationRight, dripRate: self.$dripRate)
                ScrollView(.vertical) {
                    VStack(spacing: 20) {
                        LazyVGrid(columns: self.columns) {
                            VStack(alignment: .leading) {
                                Text("gtts/min")
                                    .font(.caption)
                                TextField("", text: self.$gttsPerMinStr, prompt: Text("gtts/min").foregroundStyle(.gray))
                                    .onChange(of: self.gttsPerMinStr) {
                                        self.actionRecalculateLeft()
                                    }
                                    .padding()
                                    .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(self.dripRate > 0 ? .yellow : self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                                    .keyboardType(.numberPad)
#endif
                            }
                            Image(systemName: "xmark")
                                .font(.headline)
                            VStack(alignment: .leading) {
                                Text("min")
                                    .font(.caption)
                                TextField("", text: self.$minStr, prompt: Text("min").foregroundStyle(.gray))
                                    .onChange(of: self.minStr) {
                                        self.actionRecalculateLeft()
                                    }
                                    .padding()
                                    .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                                    .keyboardType(.numberPad)
#endif
                            }
                        }
                        HStack {
                            Spacer()
                            Image(systemName: "equal")
                                .font(.title)
                            Spacer()
                        }
                        LazyVGrid(columns: self.columns) {
                            VStack(alignment: .leading) {
                                Text("Drop set")
                                    .font(.caption)
                                HStack {
                                    Picker("Drop Set", selection: self.$selectedDropSet) {
                                        ForEach(DropSets.allCases, id: \.self) { type in
                                            Text(type.label).tag(type.id)
                                        }
                                    }
                                    .multilineTextAlignment(.leading)
                                    .padding([.top, .bottom], 10)
                                    .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .onChange(of: self.selectedDropSet) {
                                        self.actionRecalculate()
                                    }
                                    Spacer()
                                }
                                .tint(self.colourScheme == .dark ? .white : .neuronalGreen)
                            }

                            Image(systemName: "xmark")
                                .font(.headline)
                            VStack(alignment: .leading) {
                                Text("mL")
                                    .font(.caption)
                                TextField("", text: self.$mlStr, prompt: Text("mL").foregroundStyle(.gray))
                                    .onChange(of: self.mlStr) {
                                        self.dripRate = 0
                                        self.actionRecalculateRight()
                                    }
                                    .padding()
                                    .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
#if os(iOS)
                                    .keyboardType(.numberPad)
#endif
                            }
                        }
                        
                        HStack {
                            Button {
                                self.actionRecalculate()
                            } label: {
                                HStack(alignment: .top) {
                                    Spacer()
                                    Text("Calculate")
                                    Spacer()
                                }
                                .padding()
                                .background(self.min > 0 && self.ml > 0 ? .green : .gray)
                                .disabled(self.min > 0 && self.ml > 0)
                                .bold()
                                .foregroundStyle(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 3, y: 3)
                            }
                            
                            Button {
                                self.min = 0
                                self.gttsPerMin = 0
                                self.ml = 0
                                self.gttsPerMinStr = ""
                                self.mlStr = ""
                                self.minStr = ""
                                self.calculationLeft.append(Line(text: "gtts/min * min"))
                                self.calculationRight.append(Line(text: "gtts/mL * mL"))
                            } label: {
                                Image(systemName: "arrow.trianglehead.clockwise")
                                    .padding()
                                    .background(.red)
                                    .bold()
                                    .foregroundStyle(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 3, y: 3)
                            }
                        }
                    }
                    .padding()
                    Spacer()
                }
                .scrollDismissesKeyboard(.immediately)
            }
            .background(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
            .onAppear(perform: self.actionOnAppear)
        }
        
        struct Line: Identifiable {
            var id: UUID = UUID()
            var text: String
        }
        
        struct Screen: View {
            @Environment(\.colorScheme) var colourScheme
            @Binding public var left: [Line]
            @Binding public var right: [Line]
            @Binding public var dripRate: Double

            var body: some View {
                VStack(alignment: .trailing) {
                    HStack {
                        Text("FORMULA")
                            .font(.caption)
                        Spacer()
                        Text(
                            String(
                                format: "%@ = %@",
                                self.left.last?.text ?? "gtts/min * min",
                                self.right.last?.text ?? "gtts/mL * mL"
                            )
                        )
                    }
                    
                    if self.dripRate > 0 {
                        HStack {
                            Text("DRIP RATE")
                                .font(.caption)
                            Spacer()
                            Text(String(format: "%.0f gtts/min", self.dripRate))
                        }
                        .foregroundStyle(.yellow)
                        
                        HStack {
                            Spacer()
                            Text(String(format: "%.1f gtts/15s", self.dripRate / 4))
                        }
                        .foregroundStyle(.yellow)
                        
                        if (self.dripRate / 60) > 1 {
                            HStack {
                                Spacer()
                                Text(String(format: "%.1f gtt/sec", self.dripRate / 60))
                            }
                            .foregroundStyle(.yellow)
                        }
                    }
                }
                .padding()
                .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
                .background(self.colourScheme == .dark ? .neuronalGreen.opacity(0.6) : .neuronalPurple.opacity(0.6))
            }
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

extension Calculator.DripRateView {
    /// Fires on load
    /// - Returns: Void
    private func actionOnAppear() -> Void {
        self.focused = true
    }

    /// Calculates drip rate
    /// - Returns: Void
    private func actionRecalculateLeft() -> Void {
        if let dGttsPerMin = Double(self.gttsPerMinStr) {
            self.gttsPerMin = dGttsPerMin
        }
        
        if let dMin = Double(self.minStr) {
            self.min = dMin
        }
    
        if self.gttsPerMin > 0 && self.min > 0 {
            self.calculationLeft.append(Line(text: String(format: "%.0f * %.0f", self.gttsPerMin, self.min)))
        } else if self.min > 0 {
            self.calculationLeft.append(Line(text: String(format: "gtts/min * %.0f", self.min)))
        }
    }
    
    /// Calculates drip rate
    /// - Returns: Void
    private func actionRecalculateRight() -> Void {
        if let dMl = Double(self.mlStr) {
            self.ml = dMl
        }
        
        if self.ml > 0 {
            self.calculationRight.append(Line(text: String(format: "%.0f * %.0f", self.selectedDropSet.id, self.ml)))
        }
    }
    
    /// Calculates drip rate
    /// - Returns: Void
    private func actionRecalculate() -> Void {
        if self.min > 0 {
            self.resultLeft = self.min
        }
        
        if self.ml > 0 {
            self.resultRight = self.selectedDropSet.id * self.ml
        }
        
        if self.min > 0 && self.ml > 0 {
            self.dripRate = self.resultRight / self.resultLeft
        }
    }
}
