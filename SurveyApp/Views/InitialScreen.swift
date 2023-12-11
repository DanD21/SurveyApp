//
//  InitialScreen.swift
//  SurveyApp
//
//  Created by Dan Danilescu on 06.12.2023.
//

import SwiftUI

struct InitialScreen: View {
    @StateObject private var surveyViewModel: SurveyViewModel
    
    init(surveyViewModel: SurveyViewModel) {
           self._surveyViewModel = StateObject(wrappedValue: surveyViewModel)
       }

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                NavigationLink(destination: QuestionScreen(viewModel: surveyViewModel)) {
                    Text("Start Survey")
                        .font(.title)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                Spacer()
            }
            .navigationTitle("Survey App")
        }
    }
}
