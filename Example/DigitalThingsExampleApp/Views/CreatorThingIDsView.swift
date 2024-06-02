import DigitalThings
import SwiftUI

struct GroupPageView: View {

	let group: DigitalThings.Group
	let sdkClient: DigitalThingsClientProtocol

	@State private var thingIDs = [Thing.ID]()
	@State private var singleSelection: UUID?

	var body: some View {
		List(selection: $singleSelection) {
			ForEach(thingIDs) { thingID in
				NavigationLink("\(thingID)") {
					ThingView(thingID: thingID, sdkClient: sdkClient)
				}
			}
		}
		.navigationTitle("Group Page")
		.task {
			do {
				thingIDs = try await sdkClient.getGroupPage(pageID: group.id)
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
