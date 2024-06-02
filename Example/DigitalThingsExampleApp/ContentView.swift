import DigitalThings
import SwiftUI

struct ContentView: View {

	@State private(set) var sdkClient: DigitalThingsClientProtocol

	@State private var phoneNumber = "+1 234 567890"
	@AppStorage("phoneNumber") private var storedPhoneNumber = ""

	@State private var listSelection: UUID?
	@State private var isPhoneNumberAlertPresented = false

	var body: some View {
		NavigationView {
			List(selection: $listSelection) {

				Section(header: Text("Public API")) {
					NavigationLink("Groups") {
						GroupsView(sdkClient: sdkClient)
					}
				}

				Section(header: Text("Authentication")) {
					NavigationLink("Refresh Authentication") {
						RefreshAuthenticationView(sdkClient: sdkClient, phoneNumber: $phoneNumber)
					}
					NavigationLink("Sign In") {
						SignInView(sdkClient: sdkClient, phoneNumber: $phoneNumber)
					}
					NavigationLink("Get Wallet") {
						WalletView(sdkClient: sdkClient, phoneNumber: $phoneNumber)
					}
				}

				Section(header: Text("Phone Number")) {
					Text(phoneNumber)
					Button("Change Phone Number") {
						isPhoneNumberAlertPresented.toggle()
					}
					.alert("Log in", isPresented: $isPhoneNumberAlertPresented) {
						TextField("Username", text: $phoneNumber)
							.textInputAutocapitalization(.never)
						Button("OK") {
							storedPhoneNumber = phoneNumber
						}
						Button("Cancel", role: .cancel) {
							if !storedPhoneNumber.isEmpty {
								phoneNumber = storedPhoneNumber
							}
						}
					} message: {
						Text("Please enter your username and password.")
					}
				}
			}
			.navigationTitle("Digital Things SDK")
			.onAppear {
				if !storedPhoneNumber.isEmpty {
					phoneNumber = storedPhoneNumber
				}
			}
		}
	}
}

#Preview {
	ContentView(sdkClient: SDKClientMock())
}
