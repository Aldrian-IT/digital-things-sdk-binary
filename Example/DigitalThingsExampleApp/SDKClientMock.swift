import DigitalThings

struct SDKClientMock: DigitalThingsClientProtocol {

	func getGroups() async throws -> [Group] { fatalError() }
	func getGroupPage(pageID: Group.ID) async throws -> [Thing.ID] { fatalError() }
	func getThing(thingID: Thing.ID) async throws -> Thing { fatalError() }
	func getWallet(phoneNumber: String) async throws -> Wallet { fatalError() }

	func signIn(phoneNumber: String) async throws -> AuthChallenge { try signInResult.get() }

	func confirmSignIn(authChallenge: AuthChallenge, code: String) async throws -> AuthChallengeResult { fatalError() }

	func refreshAuthentication(phoneNumber: String) async throws -> Bool { try refreshAuthenticationResult.get() }

	// MARK: Mocking

	var signInResult = Result<AuthChallenge, Error>.success(AuthChallengeDummy())
	var refreshAuthenticationResult = Result<Bool, Error>.success(false)
}
