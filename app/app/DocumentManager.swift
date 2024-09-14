//
//  DocumentManager.swift
//  app
//
//  Created by Siddarth Rudraraju on 9/13/24.
//

import Foundation
class DocumentManager: ObservableObject {
    @Published var documents: [Document] = []

    let userDefaultsKey = "documentsKey"

    init() {
        loadDocuments()
    }

    func saveDocuments() {
        if let encodedDocuments = try? JSONEncoder().encode(documents) {
            UserDefaults.standard.set(encodedDocuments, forKey: userDefaultsKey)
        }
    }

    func loadDocuments() {
        if let savedDocuments = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedDocuments = try? JSONDecoder().decode([Document].self, from: savedDocuments) {
            self.documents = decodedDocuments
        } else {
            self.documents = [
                Document(title: "Assignment 1", timeAgo: "1m ago", type: .yourProject, originalType: .yourProject),
                Document(title: "Lab 3", timeAgo: "40m ago", type: .sharedWithYou, originalType: .sharedWithYou),
                Document(title: "Project Report", timeAgo: "1d ago", type: .yourProject, originalType: .yourProject),
                Document(title: "Shared Assignment", timeAgo: "2d ago", type: .sharedWithYou, originalType: .sharedWithYou)
            ]
        }
    }

    func archiveDocument(_ document: Document) {
        if let index = documents.firstIndex(where: { $0.id == document.id }) {
            documents[index].type = .archived
            saveDocuments()
        }
    }

    func deleteDocument(_ document: Document) {
        if let index = documents.firstIndex(where: { $0.id == document.id }) {
            documents[index].type = .trash
            saveDocuments()
        }
    }

    func restoreDocument(_ document: Document) {
        if let index = documents.firstIndex(where: { $0.id == document.id }) {
            documents[index].type = documents[index].originalType
            saveDocuments()
        }
    }

    func addNewDocument(title: String, type: DocumentType) {
        let newDocument = Document(title: title, timeAgo: "Just now", type: type, originalType: type)
        documents.append(newDocument)
        saveDocuments() 
    }
}
