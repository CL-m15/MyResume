//
//  ExperienceViewModel.swift
//  MyResume
//
//  Created by Chen Le on 30/03/2022.
//

import Foundation
import MapKit
import SwiftUI
import Combine

class ExperienceViewModel: ObservableObject {
    
    // Personal Details
    @Published var personal: Personal?
    
    // All Loaded Experience
    @Published var experiences: [Experience] = []
    var cancellables = Set<AnyCancellable>()
    @Published var showExperienceList: Bool = false
    
    // Current Experience
    @Published var currentExp: Experience? {
        didSet { updateMapRegion(experience: currentExp ?? nil) }
    }
    
    // Map Properties
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

    // Detail View
    @Published var detailExperience: Experience? = nil
    
    // List View
    @Published var searchText: String = ""
    @Published var selectedType: ExperienceType = .all
    
    // Error Message
    @Published var errorMessage: String = ""
    
    private let experienceDataService = ExperienceDataService()
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        // Update the personal details
        experienceDataService.$details
            .sink { [weak self] returnedDetails in
                self?.personal = returnedDetails
            }
            .store(in: &cancellables)
        
        // Update experiences array with the searchText
        $searchText
            .combineLatest(experienceDataService.$exps, $selectedType)
            .debounce(for: .seconds(0.8), scheduler: DispatchQueue.main)
            .map(filterAndSortExps)
            .sink { [weak self] returnedExps in
                self?.experiences = returnedExps
            }
            .store(in: &cancellables)
        
        // Update CurrentExp to firstExp
        $experiences
            .sink { [weak self] returnedExps in
                self?.currentExp = returnedExps.first
            }
            .store(in: &cancellables)
    }
    
    // MARK: Filtering and Sorting
    private func filterExps(text: String, exps: [Experience]) -> [Experience] {
        guard !text.isEmpty else {
            return exps.sorted()
        }
        
        let lowercasedText = text.lowercased()
        let filteredExps = exps.filter { exp in
            return exp.title.lowercased().contains(lowercasedText) ||
            exp.location.name.lowercased().contains(lowercasedText) ||
            exp.location.country.lowercased().contains(lowercasedText)
        }
        return filteredExps
    }
    
    private func sortExps(type: ExperienceType, exps: [Experience]) -> [Experience] {
        switch type {
        case .all:
            return exps
        default:
            return exps.filter { $0.type == type }
        }
    }
    
    private func filterAndSortExps(text: String, exps: [Experience], type: ExperienceType) -> [Experience] {
        let filteredExps = filterExps(text: text, exps: exps)
        let sortedExps = sortExps(type: type, exps: filteredExps)
        return sortedExps
    }
    
    // MARK: Map Region
    private func updateMapRegion(experience: Experience?) {
        guard let experience = experience else {
            errorMessage = "Cannot find update Map Region since there is no experience available."
            return
        }
        
        mapRegion = MKCoordinateRegion(
            center: experience.location.coordinates,
            span: mapSpan)
    }
    
    func showNextExp(experience: Experience) {
        withAnimation(.easeInOut) {
            currentExp = experience
            showExperienceList = false
        }
    }
    
    // MARK: Preview Stack Button
    func nextExpButton() {
        // Make sure there is the index in the Experiences Array
        guard let currentIndex = experiences.firstIndex(where: { $0 == currentExp }) else {
            errorMessage = "Could not find current index in Experience Array"
            print(errorMessage)
            return
        }
        
        // Check if nextIndex is valid
        let nextIndex = currentIndex + 1
        guard experiences.indices.contains(nextIndex) else {
            // nextIndex is not valid
            // Restart from 0
            if let firstExp = experiences.first {
                showNextExp(experience: firstExp)
            }
            return
        }
        
        // nextIndex is valid
        let nextExp = experiences[nextIndex]
        showNextExp(experience: nextExp)
    }
    
    func previousExpButton() {
        // Make sure there is the index in the Experience Array
        guard let currentIndex = experiences.firstIndex(where: { $0 == currentExp }) else {
            errorMessage = "Could not find current index in Experience Array"
            print(errorMessage)
            return
        }
        
        // Check if previousIndex is valid
        let previousIndex = currentIndex - 1
        guard experiences.indices.contains(previousIndex) else {
            // previousIndex is not valid
            // Start from last
            if let lastExp = experiences.last {
                showNextExp(experience: lastExp)
            }
            return
        }
        
        // previousIndex is valid
        let previousExp = experiences[previousIndex]
        showNextExp(experience: previousExp)
    }
}
