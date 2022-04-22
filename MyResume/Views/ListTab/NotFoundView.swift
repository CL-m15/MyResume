//
//  TestingView.swift
//  MyResume
//
//  Created by Chen Le on 16/04/2022.
//

import SwiftUI

struct NotFoundView: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Experience Not Found")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.accentColor)
                .accessibilityIdentifier("NotFoundText")
            Text("Try to search according to Title, Location Name or Country")
                .foregroundStyle(.secondary)
            Text("Eg. Solution / Nottingham / Malaysia")
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 10)
        .padding(.horizontal)
        .multilineTextAlignment(.center)
    }
}

#if !TESTING
struct NotFoundView_Previews: PreviewProvider {
    static var previews: some View {
        NotFoundView()
    }
}
#endif
