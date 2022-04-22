//
//  MainView.swift
//  MyResume
//
//  Created by Chen Le on 31/03/2022.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject private var vm: ExperienceViewModel
    
    init() {
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
    }
    
    var body: some View {
        ZStack {
            VStack {
                TabView {
                    LocationView()
                        .tabItem {
                            Label("Map", systemImage: "globe.asia.australia")
                        }
                        .tag("MapTab")
                    
                    ExperienceListView()
                        .tabItem {
                            Label("List", systemImage: "list.dash")
                        }
                        .tag("ListTab")
                    
                    PersonalDetailsView()
                        .tabItem {
                            Label("Personal", systemImage: "person.fill")
                        }
                        .tag("PersonalTab")
                }
                .sheet(item: $vm.detailExperience, onDismiss: nil) { experience in
                    ExperienceDetailView(experience: experience)
                }
            }
        }
    }
}

