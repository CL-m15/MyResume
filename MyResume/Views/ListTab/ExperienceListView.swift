//
//  ExperienceListView2.swift
//  MyResume
//
//  Created by Chen Le on 31/03/2022.
//

import SwiftUI

struct ExperienceListView: View {
    
    @EnvironmentObject private var vm: ExperienceViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                pickerSection
                
                SearchBarView(searchText: $vm.searchText)
                
                expScrollList(type: vm.selectedType)
            }
            .navigationTitle(vm.personal?.fullName ?? "Experiences")
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#if !TESTING
struct ExperienceListView_Previews: PreviewProvider {
    static var previews: some View {
        ExperienceListView()
            .environmentObject(ExperienceViewModel())
    }
}
#endif

extension ExperienceListView {
    
    private var pickerSection: some View {
        Picker("Selected Type", selection: $vm.selectedType) {
            ForEach(ExperienceType.allCases, id: \.self) { type in
                Text(type.displayName)
                    .tag(type)
                    .accessibilityIdentifier("ListTypeSelection")
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private func expScrollList(type: ExperienceType) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            if let experiences = vm.experiences {
                if experiences.isEmpty {
                    NotFoundView()
                } else {
                    ForEach(experiences) { experience in
                        ExperienceCardView(experience: experience)
                            .onTapGesture {
                                selectDetailExp(exp: experience)
                            }
                    }
                }
            }
        }
        .padding(.trailing, 5)
        .accessibilityIdentifier("ExperienceCardList")
    }
    
    private func selectDetailExp(exp: Experience) {
        withAnimation(.easeInOut) {
            vm.detailExperience = exp
            UIApplication.shared.endEditing()
        }
    }
}
