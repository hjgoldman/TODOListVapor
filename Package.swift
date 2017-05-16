import PackageDescription

let package = Package(
    name: "TODOListVapor",
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 1, minor: 5),
        .Package(url: "https://github.com/vapor/sqlite-provider.git", majorVersion: 1, minor: 1),
        .Package(url: "https://github.com/vapor/postgresql-provider.git", majorVersion: 1)
    ],
    exclude: [
        "Config",
        "Database",
        "Localization",
        "Public",
        "Resources",
    ]
)

