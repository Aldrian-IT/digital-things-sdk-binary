import DigitalThings
import SwiftUI

@main
struct DigitalThingsExampleAppApp: App {

	let sdkClient = DigitalThingsClient()

	var body: some Scene {
		WindowGroup {
			ContentView(sdkClient: sdkClient)
		}
	}
}
