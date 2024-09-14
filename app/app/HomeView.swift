//
//  HomeView.swift
//  app
//
//  Created by Siddarth Rudraraju on 9/13/24.
//

import Foundation
import SwiftUI

struct HomeView: View {
    @State private var isMenuVisible = false
    @State private var isSearchVisible = false
    @State private var isAddDocumentVisible = false
    @State private var selectedPage = "All Projects"
    @State private var selectedSortIcon = 1
    @State private var searchText = ""
    @State private var showingActionSheet = false
    @State private var selectedDocument: Document?
    
    @State private var newDocumentTitle = ""
    @State private var newDocumentType: DocumentType = .yourProject
    
    @ObservedObject var documentManager = DocumentManager()
    
    var filteredDocuments: [Document] {
        let filteredBySearch = searchText.isEmpty ? documentManager.documents : documentManager.documents.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        
        switch selectedPage {
        case "Your Projects":
            return filteredBySearch.filter { $0.type == .yourProject }
        case "Shared with You":
            return filteredBySearch.filter { $0.type == .sharedWithYou }
        case "Archived":
            return filteredBySearch.filter { $0.type == .archived }
        case "Trash":
            return filteredBySearch.filter { $0.type == .trash }
        default:
            return filteredBySearch.filter { $0.type != .archived && $0.type != .trash }
        }
    }
    
    func archiveDocument(_ document: Document) {
        documentManager.archiveDocument(document)
    }

    func deleteDocument(_ document: Document) {
        documentManager.deleteDocument(document)
    }

    func restoreDocument(_ document: Document) {
        documentManager.restoreDocument(document)
    }
    
    func addNewDocument() {
        documentManager.addNewDocument(title: newDocumentTitle, type: newDocumentType)
        newDocumentTitle = ""
        isAddDocumentVisible = false
    }

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    VStack {
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isMenuVisible.toggle()
                                }
                            }) {
                                Image("options")
                                    .resizable()
                                    .frame(width: 24, height: 20)
                                    .padding(.leading, 30)
                            }
                            Spacer()
                            Image("Aro Logo")
                                .resizable()
                                .frame(width: 130, height: 45)
                            Spacer()
                            Button(action: {
                                isSearchVisible.toggle()
                            }) {
                                Image("searchicon")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .padding(.trailing, 30)
                            }
                        }
                        .frame(height: 60)
                        .background(Color(.sRGB, red: 0.93, green: 0.93, blue: 0.93, opacity: 1.0))
                    }
                    
                    VStack {
                        HStack {
                            Text(selectedPage)
                                .font(.custom("Manrope-Bold", size: 23))
                                .padding(.leading, 45)
                                .foregroundColor(Color.black)
                            
                            Spacer()
                            
                            HStack(spacing: 4) {
                                Button(action: {
                                    selectedSortIcon = 1
                                }) {
                                    Image("gridview")
                                        .resizable()
                                        .frame(width: 24, height: 24)
                                        .padding(8)
                                        .background(selectedSortIcon == 1 ? Color(.sRGB, red: 0.92, green: 0.92, blue: 0.92) : Color.clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }

                                Button(action: {
                                    selectedSortIcon = 2
                                }) {
                                    Image("listview")
                                        .resizable()
                                        .frame(width: 17, height: 17)
                                        .padding(8)
                                        .background(selectedSortIcon == 2 ? Color(.sRGB, red: 0.92, green: 0.92, blue: 0.92) : Color.clear)
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                }
                            }
                            .padding(.trailing, 35)
                        }
                        .padding(.vertical)
                        .background(Color.white)
                        
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 16) {
                                ForEach(filteredDocuments, id: \.id) { document in
                                    DocumentRow(document: document, isListView: selectedSortIcon == 2)
                                        .onTapGesture {
                                            selectedDocument = document
                                            showingActionSheet = true
                                        }
                                }
                            }
                            .padding(.horizontal)
                        }
                        .background(Color.white)
                    }
                }
                
                if isMenuVisible {
                    SlideMenu(isMenuVisible: $isMenuVisible, selectedPage: $selectedPage)
                        .transition(.move(edge: .leading))
                        .zIndex(1)
                }

                if isSearchVisible {
                    VStack {
                        HStack {
                            TextField("Search", text: $searchText, onCommit: {
                                isSearchVisible = false
                            })
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .shadow(radius: 3)

                            Button(action: {
                                isSearchVisible = false
                            }) {
                                Text("Cancel")
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .padding(.horizontal, 20)
                        Spacer()
                    }
                    .transition(.move(edge: .top))
                    .animation(.easeInOut)
                }

                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            isAddDocumentVisible.toggle()
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color(red: 52/255, green: 52/255, blue: 123/255))
                                    .frame(width: 60, height: 60)

                                Image("addicon")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isAddDocumentVisible) {
                VStack {
                    Text("Add New Document")
                        .font(.headline)
                        .padding()

                    TextField("Document Title", text: $newDocumentTitle)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding()

                    Picker("Document Type", selection: $newDocumentType) {
                        Text("Your Project").tag(DocumentType.yourProject)
                        Text("Shared with You").tag(DocumentType.sharedWithYou)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    Button(action: {
                        addNewDocument()
                    }) {
                        Text("Add Document")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    }

                    Button(action: {
                        isAddDocumentVisible = false
                    }) {
                        Text("Cancel")
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding()
            }
            .actionSheet(isPresented: $showingActionSheet) {
                ActionSheet(
                    title: Text(selectedDocument?.title ?? ""),
                    message: Text("Choose an action"),
                    buttons: actionSheetButtons(for: selectedDocument)
                )
            }
        }
    }
    
    func actionSheetButtons(for document: Document?) -> [ActionSheet.Button] {
        guard let document = document else {
            return [.cancel()]
        }

        var buttons: [ActionSheet.Button] = []
        
        if document.type != .archived {
            buttons.append(.default(Text("Archive"), action: { archiveDocument(document) }))
        }
        
        if document.type != .trash {
            buttons.append(.destructive(Text("Delete"), action: { deleteDocument(document) }))
        }
        
        if document.type == .archived || document.type == .trash {
            buttons.append(.default(Text("Restore"), action: { restoreDocument(document) }))
        }
        
        buttons.append(.cancel())
        
        return buttons
    }
}
