//
//  MapAnnotationView.swift
//  MyResume
//
//  Created by Chen Le on 30/03/2022.
//

import SwiftUI

struct MapAnnotationView: View {
    
    let experience: Experience
    var symbolName: String {
        switch experience.type {
        case .work:
            return "mail.stack.fill"
        case .project:
            return "lightbulb.fill"
        case .education:
            return "graduationcap.fill"
        default:
            return "map.fill"
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: symbolName)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40).padding()
                .background(Circle().stroke(lineWidth: 1))
            
            Image(systemName: "triangle.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .rotationEffect(Angle(degrees: 180))
                .padding(.top, 3)
        }
        .padding(.bottom, 30)
    }
}

#if !TESTING
struct MapAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        MapAnnotationView(experience: ExperienceDataService.experiences.first!)
    }
}
#endif
