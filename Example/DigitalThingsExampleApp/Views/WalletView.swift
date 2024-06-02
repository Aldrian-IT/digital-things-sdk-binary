import DigitalThings
import SwiftUI

struct WalletView: View {

	let sdkClient: DigitalThingsClientProtocol
	@Binding private(set) var phoneNumber: String
	@State private var state = GetWalletState.idle
	@State private var log = ""

	var body: some View {
		VStack {
			Button("Load") {
				Task {
					do {
						log += "Loading wallet with phone number '\(phoneNumber)' ...\n"
						state = .loading
						defer { state = .idle }
						let wallet = try await sdkClient.getWallet(phoneNumber: phoneNumber)
						log += "Successfully loaded wallet: \(wallet)"
					} catch {
						log += "Signing in failed with error: \(error)"
					}
				}
			}
			.disabled(state == .loading)
			.padding()

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

	enum GetWalletState: Equatable {
		case idle
		case loading
	}
}
