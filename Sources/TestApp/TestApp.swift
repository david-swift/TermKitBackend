//
//  TestApp.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import TermKitBackend

@main
struct TestApp: App {

    @State private var about: Signal = .init()
    @State private var state = false

    let id = "io.github.AparokshaUI.TestApp"
    var app: TermKitApp!

    var scene: Scene {
        menuBar
        Window {
            VStack {
                Demos()
                    .hcenter()
                Controls()
                    .hcenter()
            }
            .frame(height: 14)
            .vcenter()
            .infoBox("About TermKitBackend", message: aboutInfo, signal: about)
        }
    }

    var menuBar: MenuBar {
        .init {
            Menu("File") {
                Button("_About TermKitBackend") {
                    about.signal()
                }
                Button("_Quit") {
                    app.quit()
                }
            }
            Menu("_Actions") {
                Button("_Hello, world!") { }
            }
        }
    }

    var aboutInfo: String {
        """
        This is a sample backend for the Meta package of the Aparoksha project.
        It is based on TermKit, the terminal UI toolkit for Swift.
        """
    }

}

struct Demos: View {

    @State private var state = false
    @State private var dialog: Signal = .init()
    @State private var error: Signal = .init()
    let demos = Demo.allCases

    var view: Body {
        Frame("Demos (state \(state ? 2 : 1))") {
            ListView(demos) { $0.action(state: $state, dialog: $dialog, error: $error) }
        }
        .frame(width: 40, height: 7)
        .queryBox("Dialog Demo", message: "Choose wisely", signal: dialog) {
            Button("Yes") {
                state.toggle()
            }
            Button("No") { }
        }
        .errorBox("Error Demo", message: "This is an error message", signal: error) {
            Button("Close") { }
        }
    }

}

struct Controls: View {

    @State private var isOn = false
    @State private var fraction = 0
    @State private var text = "Controls"

    var view: Body {
        Frame(text) {
            HStack {
                Button("Button (progress)") {
                    if fraction == 10 {
                        fraction = 0
                    } else {
                        fraction += 1
                    }
                }
                Button("Button (text)") {
                    text = "Hello"
                }
            }
            .frame(height: 1)
            Checkbox(isOn ? "On" : "Off", isOn: $isOn)
            TextField(text: $text)
                .secret(isOn)
            ProgressBar(value: .init(fraction), max: 10)
        }
        .frame(width: 40, height: 7)
    }

}

enum Demo: String, CaseIterable, CustomStringConvertible {

    case state
    case dialog
    case error

    var description: String {
        switch self {
        case .state:
            "Toggle State"
        default:
            rawValue.capitalized
        }
    }

    func action(state: Binding<Bool>, dialog: Binding<Signal>, error: Binding<Signal>) {
        switch self {
        case .state:
            state.wrappedValue.toggle()
        case .dialog:
            dialog.wrappedValue.signal()
        case .error:
            error.wrappedValue.signal()
        }
    }

}
