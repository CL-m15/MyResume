//
//  LaunchView.swift
//  MyResume
//
//  Created by Chen Le on 14/04/2022.
//

import SwiftUI
import Combine

struct LaunchView: View {
    
    @Binding var showLaunchView: Bool
    @State private var showName: Bool = false
    let appName: String = "My RESUME"
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var delaySecond: Int = 0

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            HStack {
                Image("applogo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .cornerRadius(3.5)
                
                if showName {
                    Text(appName)
                        .font(.title)
                        .fontWeight(.heavy)
                        .transition(.asymmetric(insertion: .move(edge: .trailing), removal: .opacity))
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(.easeIn(duration: 1)) {
                    showName.toggle()
                }
            }
        }
        .onReceive(timer) { _ in
            withAnimation {
                if delaySecond >= 3 {
                    showLaunchView = false
                } else {
                    delaySecond += 1
                }
            }
        }
    }
}

#if !TESTING
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView(showLaunchView: .constant(true))
    }
}
#endif
