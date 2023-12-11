//
//  QuestionScreen.swift
//  SurveyApp
//
//  Created by Dan Danilescu on 06.12.2023.
//

import SwiftUI

struct QuestionScreen: View {
    @ObservedObject var viewModel: SurveyViewModel

    var body: some View {
        VStack {
            Spacer()
            
            Text("Questions Submitted: \(viewModel.successfulSubmissionCount)")
                .foregroundColor(.green)
                .font(.title2)
                .padding(.bottom)
            
            Spacer()
            
            if let currentQuestion = viewModel.currentQuestion {
                Text("Question \(currentQuestion.id) of \(viewModel.questions.count)")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.bottom, 8)
                
                Text(currentQuestion.question)
                    .font(.title2)

                TextField("Your answer", text: $viewModel.currentAnswer)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                HStack {
                    Button("Previous") {
                        viewModel.moveToPreviousQuestion()
                    }
                    .disabled(viewModel.isFirstQuestion)

                    Spacer()

                    Button {
                        viewModel.submitAnswer()
                    } label: {
                        if viewModel.isCurrentQuestionSubmitted {
                            Text("Already submitted")
                                .padding()
                                .foregroundColor(.gray)
                                .font(.body)
                        } else {
                            Text("Submit")
                                .padding()
                        }
                    }
                    .disabled(viewModel.isSubmitButtonDisabled || viewModel.isCurrentQuestionSubmitted)

                    Spacer()

                    Button("Next") {
                        viewModel.moveToNextQuestion()
                    }
                    .disabled(viewModel.isLastQuestion)
                }
                
                // Show SubmitResultView for the current question
                if let submitResult = viewModel.submitResult {
                    withAnimation {
                        SubmitResultView(
                            result: submitResult,
                            retryAction: viewModel.retrySubmission
                        )
                        .padding()
                    }
                }
                
                Spacer()
            }
        }
        .padding()
        .navigationTitle("Survey Questions")
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear() {
            viewModel.reset()
        }
    }
}
