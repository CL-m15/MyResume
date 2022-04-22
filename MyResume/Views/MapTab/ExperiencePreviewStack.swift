//
//  ExperiencePreviewStack.swift
//  MyResume
//
//  Created by Chen Le on 31/03/2022.
//

import SwiftUI

struct ExperiencePreviewStack: View {
    
    @State private var offset: CGSize = .zero
    
    @EnvironmentObject private var vm: ExperienceViewModel
    let experience: Experience
    
    var body: some View {
        HStack(spacing: 0) {
            Button {
                withAnimation(.spring()) {
                    vm.previousExpButton()
                }
            } label: {
                Image(systemName: "control")
                    .rotationEffect(Angle(degrees: -90))
                    .frame(height: 100)
                    .padding(.leading, 5)
            }
            
            HStack(alignment: .center, spacing: 10) {
                imageSection
                
                VStack {
                    experienceContent
                    
                    HStack {
                        detailsButton
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.trailing)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
            )
            
            Button {
                vm.nextExpButton()
            } label: {
                Image(systemName: "control")
                    .rotationEffect(Angle(degrees: 90))
                    .frame(height: 100)
                    .padding(.trailing, 5)
            }
        }
        .offset(x: offset.width)
        .gesture(
            DragGesture()
                .onChanged({ value in
                    withAnimation(.spring()) {
                        offset = value.translation
                    }
                })
                .onEnded { value in
                    withAnimation(.spring()) {
                        if offset.width < -150 {
                            vm.nextExpButton()
                        } else if offset.width > 150 {
                            vm.previousExpButton()
                        }
                        offset = .zero
                    }
                }
        )
    }
}

struct ExperiencePreviewStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue.opacity(0.5)
            ExperiencePreviewStack(experience: ExperienceDataService.experiences[7])
                .environmentObject(ExperienceViewModel())
        }
        .preferredColorScheme(.dark)
    }
}

extension ExperiencePreviewStack {
    private var imageSection: some View {
        ZStack {
            if let imageName = experience.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
            } else {
                Image(systemName: "questionmark")
                    .font(.title)
                    .foregroundColor(.accentColor)
                    .frame(width: 120, height: 120)
                    .background(.thinMaterial)
                    .cornerRadius(10)
            }
        }
        .padding(3)
    }
    
    private var experienceContent: some View {
        VStack(alignment: .leading) {
            Text(experience.title)
                .font(.title3)
                .fontWeight(.semibold)
                .lineLimit(2)
                .minimumScaleFactor(0.8)
            
            Text(experience.location.name + ", " + experience.location.country)
                .font(.footnote.italic())
                .lineLimit(1)
                .minimumScaleFactor(0.7)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var detailsButton: some View {
        Button {
            vm.detailExperience = experience
        } label: {
            Text("Details")
                .font(.subheadline)
                .frame(width: 70)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextExpButton()
        } label: {
            Text("Next")
                .font(.subheadline)
                .frame(width: 70)
        }
        .buttonStyle(.bordered)
    }
}
