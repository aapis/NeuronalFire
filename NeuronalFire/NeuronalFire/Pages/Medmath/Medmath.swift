//
//  Medmath.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-04-03.
//

import SwiftUI

struct Medmath: View {
    @Environment(\.colorScheme) var colourScheme
    @State private var desiredDose: Float = 1.0
    @State private var availableDose: Float = 1.0
    @State private var desiredDoseStr: String = ""
    @State private var availableDoseStr: String = ""
    @State private var result: Float = 0.0
    @State private var resultStr: String = "0.0"
    @State private var factor: Float = 1.0
    @State private var factorStr: String = "1.0"

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            PageHeader(icon: "function", title: "Medmath")
            ScrollView {
                VStack(alignment: .leading) {
                    //                Text("Want / Have * Unit")
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
                    HStack(alignment: .center) {
                        Spacer()
                        Text(self.resultStr)
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
            .background(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

extension Medmath {
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
