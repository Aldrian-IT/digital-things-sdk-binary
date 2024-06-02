import DigitalThings
import SwiftUI

struct SignInView: View {

	let sdkClient: DigitalThingsClientProtocol

	@State private(set) var state: SignInState = .signInRequired
	@Binding private(set) var phoneNumber: String
	@State private var authChallengeCode = ""
	@State private var log = ""

	var body: some View {
		VStack {

			switch state {

			case .signInRequired:
				Button("Sign In") {
					Task {
						do {
							log += "Signing in with phone number '\(phoneNumber)' ...\n"
							state = .signingIn
							let authChallenge = try await sdkClient.signIn(phoneNumber: phoneNumber)
							authChallengeCode = ""
							state = .authChallengeRequired(authChallenge)
						} catch {
							log += "Signing in failed with error: \(error)"
						}
					}
				}
				.padding()

			case .signingIn:
				ProgressView()

			case .authChallengeRequired(let authChallenge):
				TextField("Confirmation Code", text: $authChallengeCode)
					.textFieldStyle(.roundedBorder)
				Button("Confirm") {
					Task {
						do {
							log += "Confirming with code '\(authChallengeCode)' ...\n"
							state = .signingIn
							let result = try await sdkClient.confirmSignIn(authChallenge: authChallenge, code: authChallengeCode)
							switch result {
							case .success:
								log += "Successfully logged in"
								state = .signedIn
							case .challengeRequired(let authChallenge):
								authChallengeCode = ""
								state = .authChallengeRequired(authChallenge)
							}
						} catch {
							log += "Confirming code failed with error: \(error)"
						}
					}
				}
				.padding()

			case .respondingToAuthChallenge:
				TextField("Confirmation Code", text: $authChallengeCode)
					.textFieldStyle(.roundedBorder)
					.disabled(true)
				ProgressView()

			case .signedIn:
				EmptyView()
			}

			ScrollView(.vertical) {
				HStack {
					Text(verbatim: log)
						.multilineTextAlignment(.leading)
					Spacer()
				}
			}
		}
		.padding()
	}

	enum SignInState: Equatable {
		case signInRequired
		case signingIn
		case authChallengeRequired(AuthChallenge)
		case respondingToAuthChallenge
		case signedIn
	}
}

#Preview("signInRequired") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.signInResult = .failure(NSError(domain: "preview", code: 1, userInfo: [NSLocalizedDescriptionKey: "failed"]))
	return SignInView(sdkClient: mockSDKClient, phoneNumber: .constant("+1 234 56789"))
}

#Preview("signingIn") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.signInResult = .failure(NSError(domain: "preview", code: 1, userInfo: [NSLocalizedDescriptionKey: "failed"]))
	return SignInView(sdkClient: mockSDKClient, state: .signingIn, phoneNumber: .constant("+1 234 56789"))
}

#Preview("authChallengeRequired") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.signInResult = .failure(NSError(domain: "preview", code: 1, userInfo: [NSLocalizedDescriptionKey: "failed"]))
	return SignInView(sdkClient: mockSDKClient, state: .authChallengeRequired(AuthChallengeDummy()), phoneNumber: .constant("+1 234 56789"))
}

#Preview("authChallengeRequired") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.signInResult = .failure(NSError(domain: "preview", code: 1, userInfo: [NSLocalizedDescriptionKey: "failed"]))
	return SignInView(sdkClient: mockSDKClient, state: .respondingToAuthChallenge, phoneNumber: .constant("+1 234 56789"))
}

#Preview("signedIn") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.signInResult = .failure(NSError(domain: "preview", code: 1, userInfo: [NSLocalizedDescriptionKey: "failed"]))
	return SignInView(sdkClient: mockSDKClient, state: .signedIn, phoneNumber: .constant("+1 234 56789"))
}
