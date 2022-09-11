//
//  CardDropDelegate.swift
//  Cardholder
//
//  Created by Max Shashkov on 10.09.2022.
//

import SwiftUI

final class CardItemProvider: NSItemProvider {
    var onDissapear: (() -> Void)?
    
    deinit {
        onDissapear?()
    }
}

struct CardDropDelegate: DropDelegate {
    @ObservedObject var viewModel: CardViewModel
    @Binding var draggingCard: Card?
    let card: Card
    
    func performDrop(info: DropInfo) -> Bool {
        withAnimation {
            $draggingCard.wrappedValue = nil
        }
        return true
    }
    
    func dropExited(info: DropInfo) {
        print(info.location)
        if info.location.y > UIScreen.main.bounds.height {
            withAnimation {
                $draggingCard.wrappedValue = nil
            }
        }
    }
    
    func dropEntered(info: DropInfo) {
        guard let draggingCard = self.draggingCard else { return }
        guard let from = viewModel.cards.firstIndex(of: draggingCard),
              let to = viewModel.cards.firstIndex(of: card) else { return }
        withAnimation {
            viewModel.cards.move(fromOffsets: IndexSet(integer: from), toOffset: to > from ? to + 1 : to)
        }
        DispatchQueue.main.async {
            viewModel.needReorder = true
        }
    }
    func dropUpdated(info: DropInfo) -> DropProposal? {
        return DropProposal(operation: .move)
    }
}
