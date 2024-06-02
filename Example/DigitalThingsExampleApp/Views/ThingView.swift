import DigitalThings
import SwiftUI

struct ThingView: View {

	let thingID: Thing.ID
	let sdkClient: DigitalThingsClientProtocol

	@State private var thing: Thing?
	@State private var singleSelection: UUID?

	var body: some View {
		VStack {
			Text(thing.map { "\($0.id)" } ?? "")
		}
		.navigationTitle(thing?.title ?? "")
		.task {
			do {
				thing = try await sdkClient.getThing(thingID: thingID)
			} catch {
				print(error)
			}
		}
	}

	enum GetWalletState: Equatable {
		case idle
		case loading
	}
}
