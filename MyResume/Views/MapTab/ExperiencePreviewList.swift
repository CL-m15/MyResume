//
//  ExperienceList.swift
//  MyResume
//
//  Created by Chen Le on 31/03/2022.
//

import SwiftUI

struct ExperiencePreviewList: View {
    
    @EnvironmentObject private var vm: ExperienceViewModel
    
    var body: some View {
        List {
            ForEach(vm.experiences) { experience in
                Button {
                    vm.showNextExp(experience: experience)
                } label: {
                    expListRow(experience: experience)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .listRowBackground(Color.clear)
                .accessibilityIdentifier("PreviewListButton")
            }
        }
        .listStyle(PlainListStyle())
        .accessibilityIdentifier("PreviewList")
    }
}

#if !TESTING
struct ExperienceList_Previews: PreviewProvider {
    static var previews: some View {
        ExperiencePreviewList()
            .environmentObject(ExperienceViewModel())
    }
}
#endif

extension ExperiencePreviewList {
    private func expListRow(experience: Experience) -> some View {
        VStack(alignment: .leading) {
            Text(experience.title)
                .font(.title3)
                .fontWeight(.semibold)
            
            Text(experience.location.name)
                .font(.subheadline)
        }
    }
}
