import DigitalThings
import SwiftUI

struct RefreshAuthenticationView: View {

	let sdkClient: DigitalThingsClientProtocol
	@Binding private(set) var phoneNumber: String
	@State private var authenticationResult = "processing ..."

	var body: some View {
		(Text("Result: ") + Text(verbatim: authenticationResult))
			.task {
				do {
					let isSignedIn = try await sdkClient.refreshAuthentication(phoneNumber: phoneNumber)
					authenticationResult = isSignedIn ? "authenticated" : "not authenticated"
				} catch {
					authenticationResult = .init(reflecting: error)
				}
			}
	}
}

#Preview("not authenticated") {
	RefreshAuthenticationView(sdkClient: SDKClientMock(), phoneNumber: .constant("+1 234 56789"))
}

#Preview("authenticated") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.refreshAuthenticationResult = .success(true)
	return RefreshAuthenticationView(sdkClient: mockSDKClient, phoneNumber: .constant("+1 234 56789"))
}

#Preview("authenticated") {
	var mockSDKClient = SDKClientMock()
	mockSDKClient.refreshAuthenticationResult = .failure(NSError(domain: "preview", code: 1, userInfo: [NSLocalizedDescriptionKey: "some error"]))
	return RefreshAuthenticationView(sdkClient: mockSDKClient, phoneNumber: .constant("+1 234 56789"))
}
