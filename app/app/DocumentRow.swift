//
//  DocumentRow.swift
//  app
//
//  Created by Siddarth Rudraraju on 9/13/24.
//

import Foundation
import SwiftUI

enum DocumentType: String, Codable {
    case yourProject
    case sharedWithYou
    case archived
    case trash
}

struct Document: Identifiable, Codable {
    let id = UUID()
    let title: String
    let timeAgo: String
    var type: DocumentType
    let originalType: DocumentType
}

struct DocumentRow: View {
    var document: Document
    var isListView: Bool

    let customCardWidth: CGFloat = UIScreen.main.bounds.width * 0.78
    let customCardHeight: CGFloat = 280

    var body: some View {
        HStack {
            Spacer()
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.sRGB, red: 0.97, green: 0.97, blue: 0.97))
                        .frame(width: customCardWidth, height: isListView ? 100 : customCardHeight)
                        .shadow(radius: 1)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.sRGB, red: 0.79, green: 0.79, blue: 0.79), lineWidth: 1)
                        )

                    VStack {
                        if !isListView {
                            RoundedRectangle(cornerRadius: 5)
                                .fill(Color.gray.opacity(0.3))
                                .frame(width: customCardWidth - 45, height: customCardHeight * 0.65)
                                .overlay(
                                    Image("fileicon") // Replace with your custom file icon
                                        .resizable()
                                        .frame(width: 50, height: 70)
                                        .foregroundColor(Color.black)
                                )
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text(document.title)
                                .font(.custom("Manrope-Bold", size: 18))
                                .foregroundColor(Color.black)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text(document.timeAgo)
                                .font(.custom("Manrope-Regular", size: 16))
                                .foregroundColor(Color.black.opacity(0.7))
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding([.leading], isListView ? 45 : 45)
                        .padding([.trailing], 45)
                        .padding(.top, 8)
                    }
                }
            }
            Spacer()
        }
        .padding(.bottom, 10)
    }
}
