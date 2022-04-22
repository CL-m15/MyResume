//
//  SearchBarView.swift
//  MyResume
//
//  Created by Chen Le on 10/04/2022.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundColor(.secondary)
            
            TextField("Title/Location/Country", text: $searchText)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing
                )
                .accessibilityIdentifier("SearchTextField")
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(
            Capsule()
                .stroke(Color.accentColor, lineWidth: 1)
        )
        .padding(.horizontal)
    }
}

#if !TESTING
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant("12"))
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.sizeThatFits)
    }
}
#endif
