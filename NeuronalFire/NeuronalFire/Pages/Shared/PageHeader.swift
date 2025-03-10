//
//  PageHeader.swift
//  NeuronalFire
//
//  Created by Ryan Priebe on 2025-03-10.
//

import SwiftUI

struct PageHeader: View {
    @Environment(\.colorScheme) var colourScheme
    public let icon: String
    public let title: String

    var body: some View {
        HStack {
            Image(systemName: self.icon)
                .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple.opacity(0.6) : .neuronalGreen.opacity(0.6))
            Text(self.title)
            Spacer()
        }
        .font(.largeTitle)
        .fontWeight(.bold)
        .padding([.leading, .top, .bottom])
        .foregroundStyle(self.colourScheme == .dark ? .neuronalPurple : .neuronalGreen)
        .background(self.colourScheme == .dark ? .neuronalGreen : .neuronalPurple)
    }
}
