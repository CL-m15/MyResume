//
//  DynamicRow.swift
//  MyResume
//
//  Created by Chen Le on 08/04/2022.
//

import SwiftUI

struct DynamicRow: View {
    var items: [String]
    @State private var totalHeight = CGFloat.zero

    var body: some View {
        VStack {
            GeometryReader { geo in
                self.generateContent(in: geo)
            }
        }
        .frame(height: totalHeight)
    }
}

#if !TESTING
struct DynamicRow_Previews: PreviewProvider {
    static var previews: some View {
        DynamicRow(items: (1...20).map { "Item \($0)" })
    }
}
#endif

extension DynamicRow {
    // MARK: - Function
    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ZStack(alignment: .topLeading) {
            ForEach(self.items, id: \.self) { item in
                self.item(for: item)
                    .padding(4)
                    .alignmentGuide(.leading) { d in
                        if (abs(width - d.width) > g.size.width) {
                            width = 0
                            height -= d.height
                        }
                        
                        let result = width
                        if item == self.items.last ?? "" {
                            width = 0
                        } else {
                            width -= d.width
                        }
                        return result
                    }
                    .alignmentGuide(.top) { d in
                        let result = height
                        if item == self.items.last ?? "" {
                            height = 0
                        }
                        return result
                    }
            }
        }
        .background(viewHeightReader($totalHeight))
    }
    
    private func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.callout)
            .foregroundColor(Color(.systemBackground))
            .background(Color.accentColor)
            .cornerRadius(5)
    }
    
    private func viewHeightReader(_ binding: Binding<CGFloat>) -> some View {
        return GeometryReader { geo -> Color in
            let rect = geo.frame(in: .local)
            DispatchQueue.main.async {
                binding.wrappedValue = rect.size.height
            }
            return .clear
        }
    }
}

