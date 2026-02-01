# Swift Patterns Reference

## Result Type
```swift
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingFailed(Error)
    case serverError(statusCode: Int)
}

func fetch<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
    guard let url = endpoint.url else { throw NetworkError.invalidURL }
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let http = response as? HTTPURLResponse, 200..<300 ~= http.statusCode else {
        throw NetworkError.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
    }
    return try JSONDecoder().decode(T.self, from: data)
}
```

## Protocol-Oriented Design
```swift
protocol DataStore {
    associatedtype Item: Identifiable
    func fetch(id: Item.ID) async throws -> Item
    func save(_ item: Item) async throws
    func delete(id: Item.ID) async throws
}

struct UserStore: DataStore {
    typealias Item = User
    // implementations...
}
```

## Dependency Injection via Environment
```swift
private struct DataStoreKey: EnvironmentKey {
    static let defaultValue: any DataStore<User> = UserStore()
}

extension EnvironmentValues {
    var userStore: any DataStore<User> {
        get { self[DataStoreKey.self] }
        set { self[DataStoreKey.self] = newValue }
    }
}
```

## Exhaustive Enums
```swift
enum AppRoute: Hashable {
    case home
    case profile(userId: String)
    case settings
    case detail(itemId: String)
}
```
