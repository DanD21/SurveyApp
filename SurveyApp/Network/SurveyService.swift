//
//  SurveyService.swift
//  SurveyApp
//
//  Created by Dan Danilescu on 06.12.2023.
//

import Combine
import Foundation

protocol SurveyServiceProtocol {
    func fetchQuestions() -> AnyPublisher<[Question], Error>
    func submitAnswer(questionId: Int, answer: String) -> AnyPublisher<SubmitResult, Error>
}

enum SubmitResult {
    case success
    case failure
}

class SurveyService: SurveyServiceProtocol {
    private let baseURL = URL(string: "https://xm-assignment.web.app")!

    func fetchQuestions() -> AnyPublisher<[Question], Error> {
        let url = baseURL.appendingPathComponent("/questions")
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Question].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func submitAnswer(questionId: Int, answer: String) -> AnyPublisher<SubmitResult, Error> {
        let url = baseURL.appendingPathComponent("/question/submit")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["id": questionId, "answer": answer] as [String : Any]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }

                print("Submit Answer Response: \(httpResponse.statusCode)")
                if let responseString = String(data: data, encoding: .utf8) {
                    print("Submit Answer Response Data: \(responseString)")
                }
                
                if httpResponse.statusCode == 200 {
                    return .success
                } else {
                    return .failure
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
