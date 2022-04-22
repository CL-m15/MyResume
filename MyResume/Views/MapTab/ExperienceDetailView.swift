//
//  ExperienceDetailView.swift
//  MyResume
//
//  Created by Chen Le on 31/03/2022.
//

import MapKit
import SwiftUI

struct ExperienceDetailView: View {
    
    @EnvironmentObject private var vm: ExperienceViewModel
    let experience: Experience
    
    var body: some View {
        ScrollView {
            VStack {
                imageSection
                
                VStack(alignment: .leading, spacing: 20) {
                    experienceTitleSection
                    Divider()
                    experienceDescriptionSection
                    Divider()
                    experienceLocationSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
        }
        .background(
            Color(.systemBackground)
                .ignoresSafeArea()
        )
        .overlay(alignment: .topLeading) { dismissButton }
    }
}

#if !TESTING
struct ExperienceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceDetailView(experience: ExperienceDataService.experiences.first!)
            .environmentObject(ExperienceViewModel())
    }
}
#endif

extension ExperienceDetailView {
    
    private var dismissButton: some View {
        Button {
            withAnimation(.easeInOut) {
                vm.detailExperience = nil
            }
        } label: {
            Image(systemName: "xmark")
                .font(.subheadline)
                .foregroundColor(.primary)
                .padding()
                .background(.thickMaterial)
                .cornerRadius(5)
                .shadow(radius: 5)
        }
        .padding()
        .accessibilityIdentifier("DismissDetailButton")
    }
    
    private var imageSection: some View {
        ZStack {
            if !experience.imageNames.isEmpty {
                TabView {
                    ForEach(experience.imageNames, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width)
                            .clipped()
                    }
                }
                .frame(height: 400)
                .tabViewStyle(PageTabViewStyle())
            } else {
                Text("No photo available")
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .background(.thinMaterial)
            }
        }
    }
    
    private var experienceTitleSection: some View {
        VStack(alignment: .leading, spacing: 7) {
            Text(experience.title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.accentColor)
                .accessibilityIdentifier("DetailViewTitle")
            
            Text(experience.location.name + ", " + experience.location.country)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(dateTextPresent(exp: experience))
                .font(.footnote.italic())
                .foregroundStyle(.secondary)
        }
    }
    
    private func dateTextPresent(exp: Experience) -> String {
        if let endDate = exp.endDate {
            return exp.startDate + " - " + endDate
        } else {
            return experience.startDate
        }
    }
    
    private var experienceDescriptionSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(experience.description, id: \.self) { description in
                Text(description)
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color(.systemBackground))
                    )
                    .clipped()
                    .shadow(color: .accentColor, radius: 3, x: 0, y: 0)
            }
            
            if let urlString = experience.link {
                if let url = URL(string: urlString) {
                    Link("More details...", destination: url)
                }
            }
        }
    }
    
    private var experienceLocationSection: some View {
        Map(coordinateRegion: .constant(MKCoordinateRegion(
                center: experience.location.coordinates,
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))),
            annotationItems: [experience]) { experience in
            MapAnnotation(coordinate: experience.location.coordinates) {
                MapAnnotationView(experience: experience)
                    .foregroundColor(.accentColor)
            }
        }
            .allowsHitTesting(false)
            .aspectRatio(1, contentMode: .fit)
            .cornerRadius(10)
    }
}
