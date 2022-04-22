//
//  PersonalDetailsView.swift
//  MyResume
//
//  Created by Chen Le on 08/04/2022.
//

import SwiftUI

struct PersonalDetailsView: View {
    
    @EnvironmentObject private var vm: ExperienceViewModel
    @State var dateString: String = ""
    
    init() {
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            
            List {
                imageDisplaySection
                
                personalDetailsSection
                
                execSummarySection
                
                educationSection
                
                languageSection
                
                skillsSection
                
                certificateSection
            }
        }
    }
}

#if !TESTING
struct PersonalDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalDetailsView()
            .environmentObject(ExperienceViewModel())
    }
}
#endif

extension PersonalDetailsView {
    
    @ViewBuilder private var imageDisplaySection: some View {
        if let image = vm.personal?.personalImage {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 125, height: 125)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.primary, lineWidth: 0.8)
                        .padding(-4)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .listRowBackground(Color(.systemGroupedBackground))
                .accessibilityIdentifier("personalImage")
        }
    }
    
    private var personalDetailsSection: some View {
        Section {
            if let personal = vm.personal {
                detailsRow(text: "First Name", value: personal.firstName)
                detailsRow(text: "Last Name", value: personal.lastName)
                detailsRow(text: "Contact", value: personal.contactNumber)
                detailsRow(text: "Email", value: personal.email)
            }
        } header: {
            Text("Personal Details")
        }
    }
    
    private var execSummarySection: some View {
        Section {
            Text(vm.personal?.executiveSummary ?? "")
                .font(.subheadline)
        } header: {
            Text("Executive Summary")
        }
    }
    
    private var educationSection: some View {
        Section {
            VStack(alignment: .leading, spacing: 3) {
                if let education = vm.personal?.education {
                    Text(education.title)
                        .font(.headline)
                    Text(education.location.name)
                        .font(.callout)
                    Text(education.startDate + " - " + (education.endDate ?? ""))
                        .font(.footnote.italic())
                        .foregroundStyle(.secondary)
                }
            }
        } header: {
            Text("Education")
        }
    }
    
    private var languageSection: some View {
        Section {
            ForEach(vm.personal?.language ?? [], id: \.self) { language in
                languageRow(language: language)
            }
        } header: {
            Text("Language")
        }
    }
    
    private var skillsSection: some View {
        Section {
            DynamicRow(items: vm.personal?.skills ?? [])
        } header: {
            Text("Skills")
        }
    }
    
    @ViewBuilder private var certificateSection: some View {
        if let certificates = vm.personal?.certificates {
            Section {
                DynamicRow(items: certificates)
            } header: {
                Text("Certificates")
            }
        }
    }
    
    private func detailsRow(text: String, value: String) -> some View {
        HStack {
            Text(text)
                .font(.callout)
                .foregroundStyle(.secondary)
            Spacer()
            Text(value)
                .font(.headline)
                .frame(maxWidth: UIScreen.main.bounds.width/2, alignment: .trailing)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
        }
    }
    
    private func languageRow(language: Language) -> some View {
        HStack {
            Text(language.name)
                .font(.headline)
            Spacer()
            IndicatorBar(value: language.value)
        }
    }
}
