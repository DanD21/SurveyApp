//
//  SubmitResultView.swift
//  SurveyApp
//
//  Created by Dan Danilescu on 06.12.2023.
//

import SwiftUI

struct SubmitResultView: View {
    let result: SubmitResult?
    let retryAction: () -> Void

    var body: some View {
        VStack {
            if let result = result {
                if result == .success {
                    Text("Success!")
                        .foregroundColor(.green)
                        .font(.title)
                } else {
                    HStack {
                        Text("Failure ")
                            .foregroundColor(.red)
                            .font(.title)
                        Button("Retry") {
                            retryAction()
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    }
                }
            }
        }
    }
}
