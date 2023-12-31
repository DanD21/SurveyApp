//
//  SurveyAppApp.swift
//  SurveyApp
//
//  Created by Dan Danilescu on 06.12.2023.
//

import SwiftUI

@main
struct SurveyAppApp: App {
    var body: some Scene {
        #if DEBUG
        let surveyViewModel = SurveyViewModel(surveyService: MockSurveyService())
        #else
        let surveyViewModel = SurveyViewModel(surveyService: SurveyService())
        #endif

        return WindowGroup {
            InitialScreen(surveyViewModel: surveyViewModel)
        }
    }
}
