//
//  SurveyAppUITests.swift
//  SurveyAppUITests
//
//  Created by Dan Danilescu on 06.12.2023.
//

import XCTest

class SurveyAppUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testSurveyFlow() throws {
        let app = XCUIApplication()
        app.launch()

        // Check if the initial screen is displayed
        XCTAssertTrue(app.staticTexts["Survey App"].exists)

        // Tap the "Start Survey" button
        app.buttons["Start Survey"].tap()

        // Answer the first question
        let answerTextField = app.textFields["Your answer"]
        XCTAssertTrue(answerTextField.exists)
        answerTextField.tap()
        answerTextField.typeText("Test Answer")

        // Submit the answer
        app.buttons["Submit"].tap()

        // Check if the success message is displayed
        XCTAssertTrue(app.staticTexts["Success!"].exists)

        // Go back to the initial screen and restart the survey
        app.buttons["Survey App"].tap()
        XCTAssertTrue(app.staticTexts["Survey App"].exists)
    }
}
