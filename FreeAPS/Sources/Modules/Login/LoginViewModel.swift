import AuthenticationServices
import SwiftUI

extension Login {
    class ViewModel<Provider>: BaseViewModel<Provider>, ObservableObject where Provider: LoginProvider {
        @Published var credentials: ASAuthorizationAppleIDCredential?

        override func subscribe() {
            credentials = provider.credentials

            $credentials
                .compactMap { $0 }
                .sink { self.provider.authorize(credentials: $0) }
                .store(in: &lifetime)
        }
    }
}
