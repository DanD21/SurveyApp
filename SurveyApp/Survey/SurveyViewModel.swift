//
//  SurveyViewModel.swift
//  SurveyApp
//
//  Created by Dan Danilescu on 06.12.2023.
//

import SwiftUI
import Combine

class SurveyViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var submitResult: SubmitResult?
    @Published var successfulSubmissionCount: Int = 0
    @Published var submissionStatus: [Int: Bool] = [:]
    @Published var answers: [Int: String] = [:]

    var isFirstQuestion: Bool {
        currentQuestionIndex == 0
    }

    var isLastQuestion: Bool {
        currentQuestionIndex == questions.count - 1
    }

    var isSubmitButtonDisabled: Bool {
        currentAnswer.isEmpty || submitResult != nil
    }

    var currentQuestion: Question? {
        questions.indices.contains(currentQuestionIndex) ? questions[currentQuestionIndex] : nil
    }
    
    var isCurrentQuestionSubmitted: Bool {
        guard let currentQuestion = currentQuestion else { return false }
        return submissionStatus[currentQuestion.id] ?? false
    }
    
    var currentAnswer: String {
        get { answers[currentQuestion?.id ?? 0] ?? "" }
        set { answers[currentQuestion?.id ?? 0] = newValue }
    }

    private var cancellables: Set<AnyCancellable> = []
    private let surveyService: SurveyServiceProtocol

    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
        fetchQuestions()
    }

    func fetchQuestions() {
        surveyService.fetchQuestions()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching questions: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] questions in
                self?.questions = questions
                print("Fetched questions: \(questions)")

            }
            .store(in: &cancellables)
    }

    func moveToNextQuestion() {
        if !isLastQuestion {
            currentQuestionIndex += 1
            submitResult = nil
        }
    }

    func moveToPreviousQuestion() {
        if !isFirstQuestion {
            currentQuestionIndex -= 1
            submitResult = nil
        }
    }

    func submitAnswer() {
        guard let currentQuestion = currentQuestion else { return }

        surveyService.submitAnswer(questionId: currentQuestion.id, answer: currentAnswer)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                // Handle completion
            } receiveValue: { [weak self] result in
                guard let self = self else { return }

                if result == .success {
                    self.successfulSubmissionCount += 1
                    self.submissionStatus[currentQuestion.id] = true
                } else {
                    self.submissionStatus[currentQuestion.id] = false
                }
                
                self.submitResult = result
            }
            .store(in: &cancellables)
    }
    
    func retrySubmission() {
        submitAnswer()
    }
    
    func reset() {
        successfulSubmissionCount = 0
        submissionStatus = [:]
        currentQuestionIndex = 0
        answers = [:]
        submitResult = nil
    }
}
