Sure, here is a Readme.md for your Swift package:

# SwiftUtil

This package provides a generic `SheetState` type that can be used to manage the presentation of sheets and full-screen covers in SwiftUI. It also provides view modifiers for presenting sheets and full-screen covers based on the state of a `SheetState` binding.

## Usage

To use the `SheetState` type, simply create a binding to it and then use the `sheet()` or `fullScreenCover()` view modifier to present a sheet or full-screen cover based on the state of the binding.

```swift
@State var sheetState: SheetState<String> = .init()

struct ContentView: View {
  var body: some View {
    Button("Present Sheet") {
      sheetState.toggle(with: "Hello!")
    }
    .sheet(isPresented: $sheetState) { data in
      Text(data)
    }
  }
}
```

## SheetState

The `SheetState` type is a generic type that represents a boolean value that can also hold associated data of type `T`. The `value` property holds the boolean value, and the `toggle()` method toggles the boolean value and sets the associated data.

## SheetModifier

The `SheetModifier` view modifier presents a sheet based on the state of a `SheetState<T>` binding. The `data` property binds to a `SheetState<T>` value, and the `sheetContent` closure provides the content of the sheet based on associated data of type `T`.

## FullScreenCover

The `FullScreenCover` view modifier presents a full-screen cover based on the state of a `SheetState<T>` binding. The `data` property binds to a `SheetState<T>` value, and the `sheetContent` closure provides the content of the full-screen cover based on associated data of type `T`.

## View Extensions

The `View` extension provides two methods for presenting sheets and full-screen covers: `sheet()` and `fullScreenCover()`. These methods are aliases for the `sheet()` and `fullScreenCover()` view modifiers, respectively.

## Installation

To install the SwiftUtil package, add the following line to your Package.swift file:

```swift
    .package(url: "https://github.com/cse-ariful/SwiftUtil.git", from: "0.0.1")
```

Then, add the following line to your app's targets:

```swift
.dependencies(
    .package(name: "SwiftUtil", .product(name: "SwiftUtil"))
)
```

## Contributing

Please feel free to contribute to the SwiftUtil package by submitting pull requests or reporting issues.

I hope this Readme.md is helpful. Please let me know if you have any questions.
