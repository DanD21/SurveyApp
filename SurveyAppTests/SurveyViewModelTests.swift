//
//  SurveyViewModelTests.swift
//  SurveyAppTests
//
//  Created by Dan Danilescu on 11.12.2023.
//

import XCTest
import Combine
@testable import SurveyApp

class SurveyViewModelTests: XCTestCase {
    func testFetchQuestions() {
        // Given
        let mockService = MockSurveyService()
        let viewModel = SurveyViewModel(surveyService: mockService)

        // Create an expectation
        let expectation = expectation(description: "Fetch questions expectation")

        // When
        viewModel.fetchQuestions()

        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(viewModel.questions.count, 2, "Expected 2 questions")
            expectation.fulfill()
        }

        // Wait for the expectation
        waitForExpectations(timeout: 3)
    }

    func testSubmitAnswer() {
        // Given
        let mockService = MockSurveyService()
        let viewModel = SurveyViewModel(surveyService: mockService)
        viewModel.currentAnswer = "Test Answer"

        // Create an expectation
        let expectation = expectation(description: "Submit answer expectation")

        // Define retry logic
        var retryCount = 0
        let maxRetries = 3 // Adjust as needed

        func submitAnswerWithRetry() {
            viewModel.submitAnswer()

            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                if viewModel.successfulSubmissionCount == 1 {
                    // Success, fulfill the expectation
                    expectation.fulfill()
                } else if retryCount < maxRetries {
                    // Retry if needed
                    retryCount += 1
                    submitAnswerWithRetry()
                } else {
                    // Exceeded max retries, fail the test
                    XCTFail("Exceeded max retries for submitting answer")
                    expectation.fulfill()
                }
            }
        }

        // When
        submitAnswerWithRetry()

        // Wait for the expectation
        waitForExpectations(timeout: 10)
    }
    
    func testMoveToNextQuestion() {
        // Given
        let viewModel = SurveyViewModel(surveyService: MockSurveyService())

        // When
        viewModel.moveToNextQuestion()

        // Then
        XCTAssertEqual(viewModel.currentQuestionIndex, 1, "Expected to move to the next question")
    }

    func testMoveToPreviousQuestion() {
        // Given
        let viewModel = SurveyViewModel(surveyService: MockSurveyService())
        viewModel.moveToNextQuestion()

        // When
        viewModel.moveToPreviousQuestion()

        // Then
        XCTAssertEqual(viewModel.currentQuestionIndex, 0, "Expected to move to the previous question")
    }
    
    func testUIReset() {
        // Given
        let viewModel = SurveyViewModel(surveyService: MockSurveyService())
        viewModel.moveToNextQuestion()

        // When
        viewModel.reset()

        // Then
        XCTAssertEqual(viewModel.currentQuestionIndex, 0, "Expected to reset to the first question")
        XCTAssertEqual(viewModel.successfulSubmissionCount, 0, "Expected successful submission count to be reset")
        XCTAssertFalse(viewModel.isCurrentQuestionSubmitted, "Expected current question to be marked as not submitted")
    }
    
}
