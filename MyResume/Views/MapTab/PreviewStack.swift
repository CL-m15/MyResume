//
//  PreviewStack2.swift
//  MyResume
//
//  Created by Chen Le on 04/04/2022.
//

import SwiftUI

enum Direction: String {
    case forward, backward
}

struct PreviewStack: View {
    
    @State private var offset: CGSize = .zero
    
    @EnvironmentObject private var vm: ExperienceViewModel
    let experience: Experience

    var body: some View {
        HStack(spacing: 0) {
            switchButton(type: .backward) { vm.previousExpButton() }
                .accessibilityIdentifier("BackwardButton")
            
            HStack(alignment: .bottom, spacing: 10) {
                VStack {
                    imageSection
                    detailsButton
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    titleSection
                    locationSection
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .offset(y: 65)
            )
            .cornerRadius(10)
            
            switchButton(type: .forward) { vm.nextExpButton() }
            .accessibilityIdentifier("ForwardButton")
        }
        .offset(x: offset.width)
        .gesture( switchingGesture() )
    }
}

#if !TESTING
struct PreviewStack_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.orange.ignoresSafeArea()
            PreviewStack(experience: ExperienceDataService.experiences[2])
        }
    }
}
#endif

extension PreviewStack {
    private var imageSection: some View {
        ZStack {
            if let imageName = experience.imageNames.first {
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .cornerRadius(10)
                    .accessibilityIdentifier("PreviewStackImage")
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
        .background(.white)
        .cornerRadius(10)
    }
    
    private var titleSection: some View {
        Text(experience.title)
            .font(.title3)
            .fontWeight(.bold)
            .lineLimit(2)
            .minimumScaleFactor(0.8)
            .accessibilityIdentifier("PreviewStackTitle")
    }
    
    private var locationSection: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(experience.location.name)
                .font(.subheadline)
                .italic()
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.7)
            
            Text(experience.location.country)
                .font(.callout)
                .italic()
        }
    }
    
    private var detailsButton: some View {
        Button {
            withAnimation(.easeInOut) {
                vm.detailExperience = experience
            }
        } label: {
            Label {
                Text("Details")
                    .italic()
            } icon: {
                Image(systemName: "arrow.right")
            }
            .font(.callout)
        }
        .buttonStyle(.bordered)
        .accessibilityIdentifier("DetailButton")
    }
    
    private func switchButton(type: Direction, buttonPressed: @escaping () -> ()) -> some View {
        Button {
            withAnimation(.spring()) {
                buttonPressed()
            }
        } label: {
            Image(systemName: "chevron.\(type.rawValue)")
                .padding(10)
                .padding(.vertical, 60)
                .offset(y: 25)
        }
    }
    
    private func switchingGesture() -> some Gesture {
        DragGesture()
            .onChanged({ value in
                withAnimation(.spring()) {
                }
                offset = value.translation
            })
            .onEnded { value in
                withAnimation(.spring()) {
                }
                if offset.width < -150 {
                    vm.nextExpButton()
                } else if offset.width > 150 {
                    vm.previousExpButton()
                }
                offset = .zero
            }
    }
}
