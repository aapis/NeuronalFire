//
//  LAMSCalculator.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-04-06.
//

import SwiftUI

struct LAMSCalculator: View {
    @Environment(\.colorScheme) var colourScheme
    @State private var score: Int = 0

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                HStack {
                    Image(systemName: "function")
                        .foregroundStyle(.white.opacity(0.6))
                    Text("LAMS")
                    Spacer()
                    Image(systemName: "\(self.score).circle")
                        .font(.title)
                }
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
                .foregroundStyle(.neuronalPurple)
                .background(self.score == 0 ? .green : self.score >= 4 ? .red : .orange)
            }

            ScrollView {
                VStack(alignment: .leading) {
                    Rulesboard(score: $score)
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Los Angeles Motor Scale (LAMS)")
                                .font(.title3)
                                .bold()
                            Spacer()
                        }
                        Text("LAMS is a simple and validated assessment of stroke severity.")
                    }
                    .padding()
                    .background(.gray.opacity(0.3))
                    .foregroundStyle(.neuronalPurple)
                }
                .padding()
                Spacer()
            }
            .background(colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        }
        .scrollDismissesKeyboard(.immediately)
    }
}

extension LAMSCalculator {
    struct LAMSRule: Identifiable {
        var id: UUID = UUID()
        var name: String
        var description: String
        var step: Int = 1
        var scale: [LAMSRuleScaleMember] = []
    }

    struct LAMSRuleScaleMember: Identifiable {
        var id: UUID = UUID()
        var name: String
        var value: Int = 0
        var step: Int = 1
    }

    struct LAMSSelectedMember {
        var key: UUID
        var value: Int
        var score: Int
    }

    struct Rulesboard: View {
        @Binding public var score: Int
        @State private var selected: [LAMSSelectedMember] = []
        private let behaviours: [LAMSRule] = [
            LAMSRule(
                name: "Facial droop",
                description: "Does one side of the face droop or is it numb? Ask the person to smile. Is it uneven?",
                step: 1,
                scale: [
                    LAMSRuleScaleMember(name: "Absent"),
                    LAMSRuleScaleMember(name: "Present", value: 1)
                ]
            ),
            LAMSRule(
                name: "Arm drift",
                description: "Is one arm weak or numb? Ask the person to raise both arms. Does one arm drift downward?",
                step: 2,
                scale: [
                    LAMSRuleScaleMember(name: "Absent", step: 2),
                    LAMSRuleScaleMember(name: "Drifts down", value: 1, step: 2),
                    LAMSRuleScaleMember(name: "Falls rapidly", value: 2, step: 2)
                ]
            ),
            LAMSRule(
                name: "Grip strength",
                description: "Is one hand weaker than the other? Use your index and middle fingers to assess grip strength.",
                step: 3,
                scale: [
                    LAMSRuleScaleMember(name: "Normal", step: 3),
                    LAMSRuleScaleMember(name: "Weak grip", value: 1, step: 3),
                    LAMSRuleScaleMember(name: "No grip", value: 2, step: 3)
                ]
            )
        ]

        var body: some View {
            ForEach(self.behaviours) { behaviour in
                VStack(alignment: .leading, spacing: 1) {
                    HStack {
                        Text(behaviour.name)
                            .font(.headline)
                        Spacer()
                    }
                    .foregroundStyle(.neuronalPurple)
                    Divider().background(.clear).frame(height: 8)

                    ForEach(behaviour.scale) { resp in
                        Button {
                            if self.selected.contains(where: {$0.value == resp.step}) {
                                self.selected.removeAll(where: {$0.value == resp.step})
                            }
                            self.selected.append(LAMSSelectedMember(key: resp.id, value: resp.step, score: resp.value))
                            self.calculateScore()
                        } label: {
                            HStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text(resp.name)
                                    Spacer()
                                    Text(String(resp.value))
                                }
                                .padding(8)
                                .foregroundStyle(self.isSelected(resp) ? .white : .gray)
                                .background(self.isSelected(resp) ? .blue : .white)
                            }
                        }
                    }
                    Divider().background(.clear).frame(height: 8)
                }
            }
        }
    }
}

extension LAMSCalculator.Rulesboard {
    /// Calculate the score by counting up the selected items' score values
    /// - Returns: Void
    private func calculateScore() -> Void {
        self.score = 0
        for chosen in self.selected {
            self.score += chosen.score
        }
    }

    /// Determines which response is selected in each group
    /// - Parameter resp: LAMSCalculator.LAMSRuleScaleMember
    /// - Returns: Bool
    private func isSelected(_ resp: LAMSCalculator.LAMSRuleScaleMember) -> Bool {
        return self.selected.contains(where: {$0.score == resp.value && $0.value == resp.step})
    }
}
