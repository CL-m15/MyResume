//
//  ExperienceCardView.swift
//  MyResume
//
//  Created by Chen Le on 31/03/2022.
//

import SwiftUI

struct ExperienceCardView: View {
    
    let experience: Experience
    
    var body: some View {
        HStack(spacing: 15) {
            leftDecoration
            experienceContent
        }
        .padding()
    }
}

#if !TESTING
struct ExperienceCardView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            ExperienceCardView(experience: ExperienceDataService.experiences.first!)

            ExperienceCardView(experience: ExperienceDataService.experiences.first!)
        }
        .preferredColorScheme(.light)
    }
}
#endif

extension ExperienceCardView {
    
    private var leftDecoration: some View {
        VStack {
            Circle()
                .fill(LinearGradient(colors: [.accentColor, Color(.systemBackground)], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(width: 15, height: 15)
                .background(
                    Circle()
                        .stroke(Color.accentColor, lineWidth: 1)
                        .padding(-3)
                )
                .padding(.top, 3)
            
            Rectangle()
                .fill(Color.accentColor)
                .frame(width: 3)
        }
    }
    
    private var experienceContent: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(experience.title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(
                    .linearGradient(
                        colors: [.accentColor, .secondary],
                        startPoint: .top,
                        endPoint: .bottom)
                )
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Text(experience.location.name + ", " + experience.location.country)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.primary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            
            Text(experience.endDate != nil ? experience.startDate + " - " + (experience.endDate ?? "") : experience.startDate)
                .font(.footnote.italic())
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(.systemBackground))
        )
        .clipped()
        .shadow(color: .primary, radius: 3, x: 0, y: 0)
    }
}
