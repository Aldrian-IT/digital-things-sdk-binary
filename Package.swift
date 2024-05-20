// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "digital-things-sdk-binary",
	targets: [
		.binaryTarget(
			name: "DigitalThingsSDKBeta",
			url: "https://github.com/Aldrian-IT/digital-things-sdk-binary/releases/download/0.9.0/DigitalThingsSDKBeta.artifactbundle.zip",
			checksum: "3f361f378c51a0b6ce61b4c96c69426e02fa4dfd70a4c5dcbf6e59ea495113d7"
		),
	]
)
