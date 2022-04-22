//
//  MyResume_UITests.swift
//  MyResume_UITests
//
//  Created by Chen Le on 22/04/2022.
//

import XCTest

class MyResume_UITests: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDownWithError() throws { }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(iOS 15.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func test_MyResume_tabBarButton_shouldExist() {
        // Given
        let tabBar = app.tabBars["Tab Bar"]
        let expectation = expectation(
               for: NSPredicate(format: "exists == true"),
               evaluatedWith: tabBar,
               handler: .none)
        
        // When
        let result = XCTWaiter.wait(for: [expectation], timeout: 10)
        
        // Then
        XCTAssertEqual(result, .completed)
    }
    
    func test_MyResume_tabBarButton_mapTabExist() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let mapTab = tabBar.buttons["Map"]
        mapTab.tap()
        let locationHeaderButton = app.buttons["LocationHeaderButton"]
        
        // Then
        XCTAssertTrue(locationHeaderButton.exists)
    }
    
    func test_MyResume_tabBarButton_listTabExist() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()
        let navTitle = app.navigationBars["Chen Le, YONG"]
        
        // Then
        XCTAssertTrue(navTitle.exists)
    }
    
    func test_MyResume_tabBarButton_personalTabExist() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let personalTab = tabBar.buttons["Personal"]
        personalTab.tap()
        let personalImage = app.tables.images["personalImage"]
        
        // Then
        XCTAssertTrue(personalImage.exists)
    }
    
    func test_MyResume_detailsButton_shouldShowDetailView() {
        // Given
        waitForLaunchView()
        
        // When
        let previewStackTitle = app.staticTexts["PreviewStackTitle"]
        let detailButton = app.buttons["DetailButton"]
        detailButton.tap()
        let detailViewTitle = app.scrollViews.staticTexts["DetailViewTitle"]
        
        // Then
        XCTAssertTrue(detailViewTitle.exists)
        XCTAssertEqual(previewStackTitle.label, detailViewTitle.label)
    }
    
    func test_MyResume_detailsButton_shouldShowDetailViewAndClose() {
        // Given
        waitForLaunchView()
        
        // When
        let previewStackTitle = app.staticTexts["PreviewStackTitle"]
        let detailButton = app.buttons["DetailButton"]
        detailButton.tap()
        let dismissButton = app.buttons["DismissDetailButton"]
        dismissButton.tap()
        
        // Then
        XCTAssertTrue(previewStackTitle.exists)
    }
    
    func test_MyResume_forwardButton_shouldForwardPreviewStack() {
        // Given
        waitForLaunchView()
        
        // When
        let stackTitle1 = app.staticTexts["PreviewStackTitle"]
        let forwardButton = app.buttons["ForwardButton"]
        forwardButton.tap()
        let stackTitle2 = app.staticTexts["PreviewStackTitle"]
        let locationHeaderText = app.buttons["LocationHeaderButton"].label
        
        // Then
        XCTAssertNotEqual(stackTitle1, stackTitle2)
        XCTAssertEqual(stackTitle2.label, locationHeaderText)
    }
    
    func test_MyResume_backwardButton_shouldBackwardPreviewStack() {
        // Given
        waitForLaunchView()
        
        // When
        let stackTitle1 = app.staticTexts["PreviewStackTitle"]
        let backwardButton = app.buttons["BackwardButton"]
        backwardButton.tap()
        let stackTitle2 = app.staticTexts["PreviewStackTitle"]
        let locationHeaderText = app.buttons["LocationHeaderButton"].label
        
        // Then
        XCTAssertNotEqual(stackTitle1, stackTitle2)
        XCTAssertEqual(stackTitle2.label, locationHeaderText)
    }
    
    func test_MyResume_previewListButton_shouldShowPreviewList() {
        // Given
        waitForLaunchView()
        
        // When
        let locationheaderButton = app.buttons["LocationHeaderButton"]
        locationheaderButton.tap()
                
        
        let locationHeaderText = app.buttons["LocationHeaderButton"].label
        let stackTitle = app.staticTexts["PreviewStackTitle"]
        
        // Then
        XCTAssertTrue(stackTitle.exists)
        XCTAssertEqual(locationHeaderText, stackTitle.label)
    }
    
    func test_MyResume_previewListButton_shouldShowPreviewListAndNavigateToSelectedExp() {
        // Given
        waitForLaunchView()

        // When
        let locationHeaderButton = app.buttons["LocationHeaderButton"]
        locationHeaderButton.tap()
    
        let previewListTable = app.tables["PreviewList"].cells
        let randomInt = Int.random(in: 0..<previewListTable.count)
        
        let randomElement = previewListTable.element(boundBy: randomInt)
        let selectedButton = previewListTable[randomElement.label].buttons["PreviewListButton"]
        
        while !selectedButton.isHittable {
            app.swipeUp()
        }
        
        selectedButton.tap()
        
        let newLocationHeaderText = app.buttons["LocationHeaderButton"].label
        let stackTitle = app.staticTexts["PreviewStackTitle"].label

        // Then
        XCTAssertEqual(newLocationHeaderText, stackTitle)
    }
    
    func test_MyResume_previewListButton_shouldSortShowPreviewListAndNavigateToSelectedExp() {
        // Given
        waitForLaunchView()

        // When
        let typeSelections = app.staticTexts.matching(identifier: "TypeSelection")
        let randomTypeInt = Int.random(in: 0..<typeSelections.count)
        let selectedType = typeSelections.element(boundBy: randomTypeInt)
        selectedType.tap()
        delayForSeconds(delay: 2)

        let locationHeaderButton = app.buttons["LocationHeaderButton"]
        locationHeaderButton.tap()

        let previewListTable = app.tables["PreviewList"].cells
        let randomInt = Int.random(in: 0..<previewListTable.count)

        let randomElement = previewListTable.element(boundBy: randomInt)
        let selectedButton = previewListTable[randomElement.label].buttons["PreviewListButton"]

        while !selectedButton.isHittable {
            app.swipeUp()
        }

        selectedButton.tap()

        let newLocationHeaderText = app.buttons["LocationHeaderButton"].label
        let stackTitle = app.staticTexts["PreviewStackTitle"].label

        // Then
        XCTAssertEqual(newLocationHeaderText, stackTitle)
    }
    
    func test_MyResume_swipeLeftGesture_shouldChangePreviewStackBackward() {
        // Given
        waitForLaunchView()
        
        // When
        let previewStackTitle = app.staticTexts["PreviewStackTitle"]
        let previewStackText = previewStackTitle.label
        swipeGesture(element: previewStackTitle, direction: .backward)
        let newPreviewStackTitle = app.staticTexts["PreviewStackTitle"]
       
        // Then
        XCTAssertNotEqual(previewStackText, newPreviewStackTitle.label)
    }
    
    func test_MyResume_swipeRightGesture_shouldChangePreviewStackForward() {
        // Given
        waitForLaunchView()
        
        // When
        let previewStackTitle = app.staticTexts["PreviewStackTitle"]
        let previewStackText = previewStackTitle.label
        swipeGesture(element: previewStackTitle, direction: .forward)
        let newPreviewStackTitle = app.staticTexts["PreviewStackTitle"]
       
        // Then
        XCTAssertNotEqual(previewStackText, newPreviewStackTitle.label)
    }
    
    func test_MyResume_AnnotationMarker_shouldNavigationByTappingMarker() {
        // Given
        waitForLaunchView()
        
        // When
        let backwardButton = app.buttons["BackwardButton"]
        backwardButton.tap()
                
        let stackTitle1 = app.staticTexts["PreviewStackTitle"].label
        delayForSeconds(delay: 1)
        app.swipeUp()
        let projectMarker = app.otherElements["Map pin"].images["Lightbulb"]
        projectMarker.tap()
                
        let stackTitle2 = app.staticTexts["PreviewStackTitle"].label
        
        // Then
        XCTAssertNotEqual(stackTitle1, stackTitle2)
    }
    
    func test_MyResume_ScrollViewList_listTabShouldScroll() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()
       
        let scrollViewQuery = app.scrollViews["ExperienceCardList"].descendants(matching: .staticText)
        let lastIndex = scrollViewQuery.count - 1
        let randomExperienceCard = scrollViewQuery.element(boundBy: lastIndex)
        while !randomExperienceCard.isHittable {
            app.swipeUp()
        }
        randomExperienceCard.tap()
        
        let detailViewTitle = app.staticTexts["DetailViewTitle"]
        
        // Then
        XCTAssert(detailViewTitle.exists, "Detail View is not shown")
    }
    
    func test_MyResume_searchBar_shouldFilterList() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()
        
        let navTitle = app.navigationBars["Chen Le, YONG"]
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        app.keys["H"].tap()
        app.keys["o"].tap()
        app.keys["n"].tap()
        app.buttons["Return"].tap()
       
        let scrollViewQuery = app.scrollViews["ExperienceCardList"].descendants(matching: .staticText)
        let randomInt = Int.random(in: 0..<scrollViewQuery.count)
        let randomExperienceCard = scrollViewQuery.element(boundBy: randomInt)
        while !randomExperienceCard.isHittable {
            app.swipeUp()
        }
        randomExperienceCard.tap()
        let dismissButton = app.buttons["DismissDetailButton"]
        dismissButton.tap()
        
        // Then
        XCTAssertTrue(navTitle.exists)
    }
    
    func test_MyResume_searchBar_shouldNotFilterAndShowNotFound() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()
        
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        app.keys["Q"].tap()
        app.keys["q"].tap()
        app.keys["q"].tap()
        app.buttons["Return"].tap()
        
        delayForSeconds(delay: 1)
        let notFoundText = app.scrollViews["ExperienceCardList"].otherElements.staticTexts["NotFoundText"]
        
        // Then
        XCTAssertTrue(notFoundText.exists)
    }
    
    func test_MyResume_pickerSelection_shouldSortAccordingToPickerType() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()
        
        let typeSelections = app.buttons.matching(identifier: "ListTypeSelection")
        let randomTypeInt = Int.random(in: 1..<typeSelections.count)
        let selectedType = typeSelections.element(boundBy: randomTypeInt)
        selectedType.tap()
        
        // Then
        XCTAssertFalse(typeSelections.element(boundBy: 0).isSelected)
        XCTAssertTrue(selectedType.isSelected)
    }
    
    func test_MyResume_searchBar_shouldClearSearchText() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()

        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        app.keys["H"].tap()
        app.keys["o"].tap()
        app.keys["n"].tap()
        let clearXMark = app.images["SearchTextField"]
        clearXMark.tap()
        delayForSeconds(delay: 1)
        
        // Then
        XCTAssert(app.keyboards.count == 0, "The keyboard is shown")
    }
    
    func test_MyResume_experienceCard_shouldDismissKeyboardAfterPressed() {
        // Given
        waitForLaunchView()
        
        // When
        let tabBar = app.tabBars["Tab Bar"]
        let listTab = tabBar.buttons["List"]
        listTab.tap()
        
        let searchTextField = app.textFields["SearchTextField"]
        searchTextField.tap()
        app.keys["H"].tap()
        app.keys["o"].tap()
        app.keys["n"].tap()
        delayForSeconds(delay: 1)
        
        let scrollViewQuery = app.scrollViews["ExperienceCardList"]
        let firstCard = scrollViewQuery.descendants(matching: .staticText).firstMatch
        firstCard.tap()
        delayForSeconds(delay: 1)
        
        // Then
        XCTAssert(app.keyboards.count == 0, "The keyboard is shown")
    }
}

// MARK: - Function
extension MyResume_UITests {
    func waitForLaunchView() {
        let mapLocationElement = app.maps.containing(.other, identifier:"Tai Po Kau Nature Reserve").element
        let expectation = expectation(
               for: NSPredicate(format: "exists == true"),
               evaluatedWith: mapLocationElement,
               handler: .none)
        let result = XCTWaiter.wait(for: [expectation], timeout: 6)
        if result == .completed {
            XCTAssertEqual(result, .completed)
        } else {
            let locationHeaderButton = app.buttons["LocationHeaderButton"]
            XCTAssert(locationHeaderButton.waitForExistence(timeout: 5))
        }
    }
    
    func delayForSeconds(delay: TimeInterval) {
        let delayExpectation = XCTestExpectation()
        delayExpectation.isInverted = true
        wait(for: [delayExpectation], timeout: delay)
    }
    
    enum SwipeDirection {
        case forward, backward
    }
    
    func swipeGesture(element: XCUIElement, direction: SwipeDirection) {
        let startPoint = element.coordinate(withNormalizedOffset: CGVector(dx: direction == .forward ? 0.5 : -0.5, dy: 0))
        let endPoint = element.coordinate(withNormalizedOffset: CGVector(dx: direction == .forward ? -0.5 : 0.5, dy: 0))
        startPoint.press(forDuration: 0, thenDragTo: endPoint)
    }
}
