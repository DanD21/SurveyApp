# Survey App

A simple SwiftUI app for surveys using MVVM architecture, Async/Await, and Combine. This app allows users to navigate through survey questions, submit answers, and view submission results.

## Implemented Features

- **MVVM Architecture:** Organized code structure using Model-View-ViewModel architecture.
- **Async/Await and Combine:** Leveraging modern Swift features for asynchronous programming.
- **Unit Tests:** Comprehensive unit tests for ViewModel logic and SurveyService integration.
- **UI Tests:** End-to-end UI tests to ensure a smooth user experience.

## Requirements

The development of this app was guided by the following requirements:

### Code Structure

- Maintain a clean and organized code structure.
- Utilize MVVM architecture for better separation of concerns.

### Asynchronous Programming

- Implement asynchronous programming using Async/Await and Combine.

### Testing

- Include comprehensive unit tests for ViewModel logic and SurveyService integration.
- Implement UI tests to cover the entire survey flow.

### Error Handling

- Handle errors gracefully, especially when interacting with external services.

## Getting Started

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the SurveyApp target.

## Known Issues

- Occasionally, the server intentionally returns a 400 status code, simulating error conditions.

## Unit Tests

- Unit tests cover ViewModel logic, SurveyService interactions, and error handling.
- Some tests may fail due to intentional server responses.

## UI Tests

- UI tests cover the entire survey flow, from starting the survey to submitting answers.

## Contributing

Feel free to contribute by opening issues or submitting pull requests.

## License

This project is licensed under the [MIT License](LICENSE).

