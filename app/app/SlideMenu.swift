//
//  SlideMenu.swift
//  app
//
//  Created by Siddarth Rudraraju on 9/13/24.
//

import Foundation
import SwiftUI

struct SlideMenu: View {
    @Binding var isMenuVisible: Bool
    @Binding var selectedPage: String

    let menuItems = [
        ("All Projects", "home"),
        ("Your Projects", "yourprojects"),
        ("Shared with You", "sharedwithyou"),
        ("Archived", "archived"),
        ("Trash", "trash")
    ]

    var body: some View {
        ZStack(alignment: .leading) {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    withAnimation {
                        isMenuVisible = false
                    }
                }

            VStack(alignment: .leading) {
                HStack {
                    Image("Aro Logo")
                        .resizable()
                        .frame(width: 130, height: 45)
                        .padding(.leading, 10)
                }
                .padding(.top, 0)

                // Menu items
                ForEach(menuItems, id: \.0) { item in
                    Button(action: {
                        withAnimation {
                            selectedPage = item.0
                        }
                    }) {
                        HStack {
                            Image(item.1)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .padding(.leading, 20)
                            
                            Text(item.0)
                                .font(.custom("Manrope-Bold", size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(selectedPage == item.0 ? Color(red: 52/255, green: 52/255, blue: 123/255) : Color(red: 80/255, green: 80/255, blue: 100/255)) 
                                .lineSpacing(24.59)
                                .padding(.leading, 10)
                            
                            Spacer()
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(selectedPage == item.0 ? Color(red: 193/255, green: 193/255, blue: 208/255, opacity: 0.55) : Color.clear) 
                        .cornerRadius(8)
                    }
                }

                Spacer()
            }
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.75)
            .frame(maxHeight: .infinity)
            .background(Color(.sRGB, red: 0.93, green: 0.93, blue: 0.93, opacity: 1.0))
        }
    }
}
