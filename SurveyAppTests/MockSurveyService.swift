//
//  MockSurveyService.swift
//  SurveyAppTests
//
//  Created by Dan Danilescu on 11.12.2023.
//

import Combine
import Foundation
@testable import SurveyApp

class MockSurveyService: SurveyServiceProtocol {
    func fetchQuestions() -> AnyPublisher<[Question], Error> {
        let questions = [
            Question(id: 1, question: "Mock Question 1"),
            Question(id: 2, question: "Mock Question 2")
        ]
        return Just(questions)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func submitAnswer(questionId: Int, answer: String) -> AnyPublisher<SubmitResult, Error> {
        return Just(.success)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
