//
//  LocationView.swift
//  MyResume
//
//  Created by Chen Le on 30/03/2022.
//

import MapKit
import SwiftUI

struct LocationView: View {
    
    @EnvironmentObject private var vm: ExperienceViewModel
    
    var body: some View {
        ZStack {
            mapLayer
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                typeSelectionSection
                headerSection
                Spacer()
                experiencePreview
            }
        }
    }
}

#if !TESTING
struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
            .environmentObject(ExperienceViewModel())
    }
}
#endif

extension LocationView {
    private var mapLayer: some View {
        Map(coordinateRegion: $vm.mapRegion, annotationItems: vm.experiences) { experience in
            MapAnnotation(coordinate: experience.location.coordinates) {
                MapAnnotationView(experience: experience)
                    .foregroundColor(vm.currentExp == experience ? .accentColor : .secondary)
                    .scaleEffect(vm.currentExp == experience ? 1.0 : 0.6)
                    .opacity(vm.currentExp == experience ? 1.0 : 0.6)
                    .onTapGesture {
                        vm.showNextExp(experience: experience)
                    }
            }
        }
    }
    
    private var typeSelectionSection: some View {
        HStack {
            ForEach(ExperienceType.allCases, id: \.self) { type in
                Text(type.displayName.lowercased())
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    .padding(.vertical, 2)
                    .background(
                        RoundedRectangle(cornerRadius: 3)
                            .fill(type == vm.selectedType ? Color.accentColor : .gray)
                    )
                    .accessibilityIdentifier("TypeSelection")
                    .onTapGesture {
                        withAnimation {
                            vm.selectedType = type
                        }
                    }
                    
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    private var headerSection: some View {
        VStack {
            Button {
                withAnimation(.easeInOut) {
                    vm.showExperienceList.toggle()
                }
            } label: {
                Text(vm.currentExp?.title ?? "")
                    .font(.title3)
                    .fontWeight(.black)
                    .foregroundColor(.primary)
                    .frame(width: UIScreen.main.bounds.width/1.3, height: 60)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .overlay(
                        Image(systemName: "arrow.down")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                            .rotationEffect(Angle(degrees: vm.showExperienceList ? 180 : 0))
                            .offset(x: 10)
                        , alignment: .trailing
                    )
            }
            .accessibilityIdentifier("LocationHeaderButton")
            
            if vm.showExperienceList {
                ExperiencePreviewList()
            }
        }
        .background(.thinMaterial)
        .padding([.horizontal, .bottom])
        .padding(.top, 8)
    }
    
    private var experiencePreview: some View {
        ZStack {
            if !vm.experiences.isEmpty {
                if let currentExp = vm.currentExp {
                    PreviewStack(experience: currentExp)
                }
            }
        }
        .offset(y: -20)
    }
}
