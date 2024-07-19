# Getting Started

Learn how to use the TermKit backend.

Knowledge about the Meta project is required.
Find more information [here](https://aparokshaui.github.io/meta/).

## The App

Define your app in the following way:

```swift
import TermKitBackend

@main
struct TestApp: App {

    let id = "io.github.AparokshaUI.TestApp"
    var app: TermKitApp!

    var scene: Scene {
        Window {
            // Views (see list in documentation)
        }
        .menuBar {
            Menu("_File") { // Menus
                Button("_New") { // Buttons
                    print("Hi")
                }
            }
        }
    }

}
```

## Widgets

All the available widgets can be found in the documentation.
Take a look at the [sample app](https://github.com/david-swift/TermKitBackend/blob/main/Sources/TestApp/TestApp.swift) for more help.
