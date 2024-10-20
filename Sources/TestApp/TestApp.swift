//
//  TestApp.swift
//  TermKitBackend
//
//  Created by david-swift on 01.07.2024.
//

import Meta
import TermKitBackend

@main
struct TestApp: App {

    @State private var about: Signal = .init()

    let id = "io.github.AparokshaUI.TestApp"
    var app: TermKitApp!

    var scene: Scene {
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
        .menuBar {
            fileMenu
            Menu("_Actions") {
                Button("_Hello, world!") { }
            }
        }
    }

    @ViewBuilder
    var fileMenu: Body {
        Menu("File") {
            Button("_About TermKitBackend") {
                about.signal()
            }
            Button("_Quit") {
                app.quit()
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

struct ControlsModel: Model {

    var isOn = false
    var fraction = 0
    var text = "Controls"

    var model: ModelData?

    func increaseFraction() {
        Task { @MainActor in
            setModel { $0.fraction += 1 }
        }
    }

}

struct Controls: View {

    @State private var model = ControlsModel()

    var view: Body {
        Frame(model.text) {
            HStack {
                Button("Button (progress)") {
                    if model.fraction == 10 {
                        model.fraction = 0
                    } else {
                        model.increaseFraction()
                    }
                }
                Button("Button (text)") {
                    model.text = "Hello"
                }
            }
            .frame(height: 1)
            Checkbox(model.isOn ? "On" : "Off", isOn: $model.isOn)
            TextField(text: $model.text)
                .secret(model.isOn)
            ProgressBar(value: .init(model.fraction), max: 10)
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
