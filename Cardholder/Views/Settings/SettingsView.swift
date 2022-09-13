//
//  SettingsView.swift
//  Cardholder
//
//  Created by Max Shashkov on 17.08.2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var isDeleteAlertPresented = false
    @ObservedObject var viewModel: CardViewModel
    var body: some View {
        List {
            Button("about") {
                
            }
            Link("privacyPolicyButton", destination: URL(string: "https://bit.ly/3QudC3X")!)
            Button {
                isDeleteAlertPresented.toggle()
            } label: {
                Text(.deleteAll)
            }
            .foregroundColor(!viewModel.cards.isEmpty ? .red : .init(uiColor: .systemGray4))
            .disabled(viewModel.cards.isEmpty ? true : false)
        }
        .listStyle(.insetGrouped)
        .alert("deleteAlert", isPresented: $isDeleteAlertPresented) {
            Button("delete", role: .destructive) { viewModel.clear() }
                .foregroundColor(.red)
            Button("cancel", role: .cancel) { }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: CardViewModel())
    }
}
