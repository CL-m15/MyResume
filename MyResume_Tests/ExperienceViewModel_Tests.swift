//
//  ExperienceViewModel_Tests.swift
//  MyResume_Tests
//
//  Created by Chen Le on 10/04/2022.
//

import XCTest
@testable import MyResume
import Combine

class ExperienceViewModel_Tests: XCTestCase {

    var vm: ExperienceViewModel?
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        vm = ExperienceViewModel()
    }

    override func tearDownWithError() throws {
        vm = nil
    }

    func test_ExperienceViewModel_personal_hasDetails() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        guard let personal = vm.personal else {
            XCTFail()
            return
        }
        
        // Then
        XCTAssertTrue(!personal.fullName.isEmpty)
        XCTAssertTrue(!personal.contactNumber.isEmpty)
        XCTAssertTrue(!personal.email.isEmpty)
    }
    
    func test_ExperienceViewModel_experiences_shouldBeEmpty() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        // Before Debounce time, experiences will remain empty
     
        // Then
        XCTAssertEqual(vm.experiences.count, 0)
    }
    
    func test_ExperienceViewModel_experiences_shouldNotBeEmpty() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        
        // Then
        XCTAssertGreaterThan(vm.experiences.count, 0)
    }
    
    func test_ExperienceViewModel_experiences_shouldFilterAccordingly() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }

        // When
        publishedExperienceList(vm: vm)
        let randomExp = vm.experiences.randomElement()
        vm.searchText = String(randomExp?.title.prefix(3) ?? "resume").lowercased()
        let expectation = XCTestExpectation(description: "Should return filtered Exp list")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        // Then
        for x in 0..<vm.experiences.count {
            let exp = vm.experiences[x]
            XCTAssertTrue(
                exp.title.lowercased().contains(vm.searchText) ||
                exp.location.name.lowercased().contains(vm.searchText) ||
                exp.location.country.lowercased().contains(vm.searchText)
            )
        }
    }
    
    func test_ExperienceViewModel_experiences_shouldSortAll() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }

        // When
        vm.selectedType = .all
        publishedExperienceList(vm: vm)
        let count = vm.experiences.count
        
        // Then
        XCTAssertEqual(vm.experiences.count, count)
    }
    
    func test_ExperienceViewModel_experiences_shouldSortWork() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }

        // When
        vm.selectedType = .work
        publishedExperienceList(vm: vm)
        let count = vm.experiences.count
        
        // Then
        for x in 0..<count {
            XCTAssertEqual(vm.experiences[x].type, vm.selectedType)
        }
    }
    
    func test_ExperienceViewModel_experiences_shouldSortProject() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }

        // When
        vm.selectedType = .project
        publishedExperienceList(vm: vm)
        let count = vm.experiences.count
        
        // Then
        for x in 0..<count {
            XCTAssertEqual(vm.experiences[x].type, vm.selectedType)
        }
    }
    
    func test_ExperienceViewModel_experiences_shouldSortEducation() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }

        // When
        vm.selectedType = .education
        publishedExperienceList(vm: vm)
        let count = vm.experiences.count
        
        // Then
        for x in 0..<count {
            XCTAssertEqual(vm.experiences[x].type, vm.selectedType)
        }
    }
    
    func test_ExperienceViewModel_experiences_shouldSortAccordingly() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }

        // When
        publishedExperienceList(vm: vm)
        let count = vm.experiences.count
        vm.selectedType = ExperienceType.allCases.randomElement() ?? .all
        let expectation = XCTestExpectation(description: "Should return sorted Exp list")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
        
        // Then
        if vm.selectedType == .all {
            XCTAssertEqual(vm.experiences.count, count)
        } else {
            for x in 0..<vm.experiences.count {
                let exp = vm.experiences[x]
                XCTAssertTrue(exp.type == vm.selectedType)
            }
        }
    }
    
    func test_ExperienceViewModel_currentExp_shouldBeFirstExp() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        
        // Then
        XCTAssertEqual(vm.currentExp, vm.experiences.first)
        XCTAssertEqual(vm.currentExp?.location.latitude, vm.mapRegion.center.latitude)
        XCTAssertEqual(vm.currentExp?.location.longitude, vm.mapRegion.center.longitude)
    }
    
    func test_ExperienceViewModel_currentExp_shouldPrintError() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        vm.currentExp = nil
        
        // Then
        XCTAssertEqual(vm.errorMessage, "Cannot find update Map Region since there is no experience available.")
    }
    
    func test_ExperienceViewModel_currentExp_shouldUpdateMapRegion() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        let expCount = vm.experiences.count
        let randomIndex = Int.random(in: 0..<expCount)
        vm.currentExp = vm.experiences[randomIndex]
        
        // Then
        XCTAssertEqual(vm.experiences[randomIndex].location.latitude, vm.mapRegion.center.latitude)
        XCTAssertEqual(vm.experiences[randomIndex].location.longitude, vm.mapRegion.center.longitude)
    }
    
    func test_ExperienceViewModel_func_showNextExp_shouldShowCurrentExpAndDismissList() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        let randomIndex = Int.random(in: 0..<vm.experiences.count)
        let experience = vm.experiences[randomIndex]
        vm.showNextExp(experience: experience)
        
        // Then
        XCTAssertEqual(experience, vm.currentExp)
        XCTAssertFalse(vm.showExperienceList)
    }
    
    func test_ExperienceViewModel_func_nextExpButton_shouldPrintError() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        vm.currentExp = nil
        vm.nextExpButton()
        
        // Then
        XCTAssertEqual(vm.errorMessage, "Could not find current index in Experience Array")
    }
    
    func test_ExperienceViewModel_func_nextExpButton_lastShouldReturnToFirstExp() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        vm.currentExp = vm.experiences.last
        vm.nextExpButton()
        
        // Then
        XCTAssertEqual(vm.currentExp, vm.experiences.first)
    }
    
    func test_ExperienceViewModel_func_nextExpButton_forwardButton_stress() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        let expCount = vm.experiences.count
        let currentIndex = Int.random(in: 0..<expCount)
        vm.currentExp = vm.experiences[currentIndex]
        let pressCount = Int.random(in: 1...20)
        for _ in 0..<pressCount {
            vm.nextExpButton()
        }
        
        let remainder = pressCount % expCount
        var newIndex: Int
        if (currentIndex + remainder) >= expCount {
            newIndex = currentIndex + (remainder - expCount)
        } else {
            newIndex = currentIndex + remainder
        }
        
        // Then
        XCTAssertEqual(vm.currentExp, vm.experiences[newIndex])
    }
    
    func test_ExperienceViewModel_func_previousExpButton_shouldPrintError() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        vm.currentExp = nil
        vm.previousExpButton()
        
        // Then
        XCTAssertEqual(vm.errorMessage, "Could not find current index in Experience Array")
    }
    
    func test_ExperienceViewModel_func_previousExpButton_firstShouldReturnToLastExp() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        vm.currentExp = vm.experiences.first
        vm.previousExpButton()
        
        // Then
        XCTAssertEqual(vm.currentExp, vm.experiences.last)
    }
    
    func test_ExperienceViewModel_func_previousExpButton_backwardButton_stress() {
        // Given
        guard let vm = vm else {
            XCTFail()
            return
        }
        
        // When
        publishedExperienceList(vm: vm)
        let expCount = vm.experiences.count
        let currentIndex = Int.random(in: 0..<expCount)
        vm.currentExp = vm.experiences[currentIndex]
        let pressCount = Int.random(in: 1...20)
        for _ in 0..<pressCount {
            vm.previousExpButton()
        }
        
        let remainder = pressCount % expCount
        var newIndex: Int
        if (currentIndex - remainder) < 0 {
            newIndex = currentIndex - (remainder - expCount)
        } else {
            newIndex = currentIndex - remainder
        }
        
        // Then
        XCTAssertEqual(vm.currentExp, vm.experiences[newIndex])
    }

}

// MARK: - FUNCTION
extension ExperienceViewModel_Tests {
    func publishedExperienceList(vm: ExperienceViewModel) {
        let expectation = XCTestExpectation(description: "Should return experience list")
        vm.$experiences
            .dropFirst()
            .sink { returnedExps in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        wait(for: [expectation], timeout: 5)
    }
}
