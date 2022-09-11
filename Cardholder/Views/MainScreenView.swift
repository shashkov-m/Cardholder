//
//  MainScreenView.swift
//  Cardholder
//
//  Created by Max Shashkov on 25.05.2022.
//

import SwiftUI
import UniformTypeIdentifiers
import PartialSheet

struct MainScreenView: View {
    @StateObject var viewModel = CardViewModel()
    private let PSiPhoneStyle = PSIphoneStyle(background: .blur(.ultraThinMaterial), handleBarStyle: .solid(.secondary), cover: .enabled(Color.black.opacity(0.3)), cornerRadius: 12)
    @State private var isCreateNewSheetPresented = false
    @State private var isPartialSheetPresented = false
    @State private var selectedCard: Card?
    @State private var draggingItem: Card?
    private let width = UIScreen.main.bounds.width * 0.95
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                if viewModel.cards.isEmpty {
                    VStack {
                        Spacer()
                        EmptyMainView()
                            .frame(maxWidth: .infinity)
                        Spacer()
                        AddCardButton(binding: $isCreateNewSheetPresented,
                                      width: width * 0.9)
                    }
                } else {
                    ScrollView(showsIndicators: false) {
                        VStack {
                            ForEach(viewModel.cards) { card in
                                CardView(viewModel: viewModel, card: card, width: width)
                                    .padding(.bottom, -25)
                                    .transition(.scale)
                                    .onTapGesture {
                                        selectedCard = card
                                        isPartialSheetPresented.toggle()
                                    }
                                    .opacity(draggingItem?.id == card.id ? 0.01 : 1)
                                    .onDrag {
                                        draggingItem = card
                                        let itemProvider = CardItemProvider(object: card.id.uuidString as NSString)
                                        itemProvider.onDissapear = { draggingItem = nil
                                        }
                                        return itemProvider
                                    } preview: {
                                        CardView(viewModel: viewModel, card: card, width: width)
                                    }
                                    .onDrop(of: [UTType.text], delegate: CardDropDelegate(viewModel: viewModel,
                                                                                          draggingCard: $draggingItem,
                                                                                          card: card))
                            }
                            
                            Rectangle()
                                .frame(width: width, height: 100)
                                .foregroundColor(.clear)
                        }
                    }
                    AddCardButton(binding: $isCreateNewSheetPresented,
                                  width: width * 0.9)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView(viewModel: viewModel)
                    } label: {
                        Image(systemName: "ellipsis")
                    }
                }
            }
            .sheet(isPresented: $isCreateNewSheetPresented) {
                NavigationView {
                    AddNewCardView(viewModel: viewModel, isPresented: $isCreateNewSheetPresented, title:NSLocalizedString("newCard", comment: "new card"))
                }
            }
            
            .partialSheet(isPresented: $isPartialSheetPresented, iPhoneStyle: PSiPhoneStyle) {
                if let card = selectedCard {
                    CardDetails(viewModel: viewModel, isPresented: $isPartialSheetPresented, card: card, width: width)
                }
            }
            .navigationTitle("Cardholder")
            .navigationBarTitleDisplayMode(.large)
        }
        .navigationViewStyle(.stack)
        
    }
}

struct MainScreenView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView(viewModel: CardViewModel())
            .attachPartialSheetToRoot()
            .preferredColorScheme(.dark
            )
    }
}
