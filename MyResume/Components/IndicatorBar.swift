//
//  IndicatorBar.swift
//  MyResume
//
//  Created by Chen Le on 08/04/2022.
//

import SwiftUI

struct IndicatorBar: View {
    
    // Components
    let height: CGFloat = 20
    let cornerRadius: CGFloat = 8
    
    // Properties
    let maxValue: CGFloat = 10
    var value: Int
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 5)
                .frame(width: getWidth(ratio: 3), height: height)
                .foregroundColor(.secondary)
            
            RoundedRectangle(cornerRadius: cornerRadius)
                .frame(width: CGFloat(value) * getWidth(ratio: 3) / maxValue, height: height)
                .foregroundColor(.accentColor)
        }
    }
}

#if !TESTING
struct IndicatorBar_Previews: PreviewProvider {
    static var previews: some View {
        IndicatorBar(value: 8)
    }
}
#endif

extension IndicatorBar {
    
    private func getWidth(ratio: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width / ratio
    }
    
}
