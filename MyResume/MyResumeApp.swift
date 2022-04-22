//
//  MyResumeApp.swift
//  MyResume
//
//  Created by Chen Le on 30/03/2022.
//

import SwiftUI

@main
struct MyResumeApp: App {
    
    @StateObject private var vm = ExperienceViewModel()
    @State private var showLaunchView: Bool = true
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                MainView()
                    .environmentObject(vm)
                
                ZStack {
                    if showLaunchView {
                        LaunchView(showLaunchView: $showLaunchView)
                    }
                }
                .zIndex(2)
            }
        }
    }
}
