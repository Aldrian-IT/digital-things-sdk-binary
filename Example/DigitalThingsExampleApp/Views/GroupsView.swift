import DigitalThings
import SwiftUI

struct GroupsView: View {

	let sdkClient: DigitalThingsClientProtocol

	@State private var groups = [DigitalThings.Group]()
	@State private var singleSelection: UUID?

	var body: some View {
		List(selection: $singleSelection) {
			ForEach(groups) { group in
				NavigationLink(group.title) {
					GroupPageView(group: group, sdkClient: sdkClient)
				}
			}
		}
		.navigationTitle("Groups")
		.task {
			do {
				groups = try await sdkClient.getGroups()
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
