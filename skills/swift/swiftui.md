# SwiftUI Patterns

## Observable State (iOS 17+)
```swift
@Observable
class UserViewModel {
    var users: [User] = []
    var isLoading = false
    var error: Error?

    func loadUsers() async {
        isLoading = true
        defer { isLoading = false }
        do {
            users = try await userService.fetchAll()
        } catch {
            self.error = error
        }
    }
}
```

## View Composition
```swift
struct UserListView: View {
    @State private var viewModel = UserViewModel()

    var body: some View {
        List(viewModel.users) { user in
            UserRow(user: user)
        }
        .overlay {
            if viewModel.isLoading { ProgressView() }
            if viewModel.users.isEmpty && !viewModel.isLoading {
                ContentUnavailableView("No Users", systemImage: "person.slash")
            }
        }
        .task { await viewModel.loadUsers() }
    }
}

struct UserRow: View {
    let user: User

    var body: some View {
        HStack {
            AsyncImage(url: user.avatarURL) { image in
                image.resizable().scaledToFill()
            } placeholder: {
                Circle().fill(.secondary)
            }
            .frame(width: 40, height: 40)
            .clipShape(Circle())

            VStack(alignment: .leading) {
                Text(user.name).font(.headline)
                Text(user.email).font(.caption).foregroundStyle(.secondary)
            }
        }
    }
}
```

## Navigation
```swift
@Observable
class Router {
    var path = NavigationPath()

    func navigate(to route: AppRoute) {
        path.append(route)
    }

    func popToRoot() {
        path = NavigationPath()
    }
}

struct AppView: View {
    @State private var router = Router()

    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .profile(let id): ProfileView(userId: id)
                    case .settings: SettingsView()
                    case .detail(let id): DetailView(itemId: id)
                    case .home: HomeView()
                    }
                }
        }
        .environment(router)
    }
}
```
