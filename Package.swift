// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "digital-things-sdk-binary",
	products: [
		.library(name: "DigitalThingsBeta", targets: ["DigitalThingsSDKBeta"])
	],
	targets: [
		.binaryTarget(
			name: "DigitalThingsSDKBeta",
			url: "https://github.com/Aldrian-IT/digital-things-sdk-binary/releases/download/0.9.1/DigitalThingsSDKBeta.artifactbundle.zip",
			checksum: "bd4f5e5c73c83e4887ff65de40be5dea2e9d71de1ab59f17f88bea13615f70d4"
		),
	]
)
