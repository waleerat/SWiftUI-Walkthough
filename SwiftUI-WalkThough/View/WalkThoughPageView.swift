//
//  WalkThoughPageView.swift
//  SwiftUI-WalkThough
//
//  Created by Waleerat Gottlieb on 2022-03-17.
//

import SwiftUI
import Kingfisher

struct WalkThoughPageView: View {
    @AppStorage("isGoToLandingPage") private var isGoToLandingPage: Bool = false
    
    @Binding var currentPage: Int
    @State var page: WalkThoughModel

    var body: some View {
        VStack(spacing: 20){
            
            WalkthoughTopBar(currentPage: $currentPage)
            
            if (page.imageURL != "") {
                KFImage(URL(string: page.imageURL)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            
            
            VStack(alignment: .leading, spacing: 10){
                
                Text(page.title)
                    .font(.title)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    
                Text(page.description)
                    .font(.body)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9)
            .padding(.horizontal)
            
            // Minimum Spacing When Phone is reducing...

            Spacer(minLength: 120)
        }
        .foregroundColor(Color(hex: page.foregroundColorHex))
        .background(Color(hex: page.bgColorHex).cornerRadius(10).ignoresSafeArea())
    }
}


struct WalkthoughTopBar: View {
    @AppStorage("isGoToLandingPage") private var isGoToLandingPage: Bool = false

    @Binding var currentPage: Int
    
    var body: some View {
        
        HStack{
            // Showing it only for first Page...
            if currentPage == 1{
                Text("Swasdee ka!!")
                    .font(.title)
                    .fontWeight(.semibold)
                    // Letter Spacing...
                    .kerning(1.4)
            }
            else{
                // Back Button...
                Button(action: {
                    withAnimation(.easeInOut){
                        currentPage -= 1
                    }
                }, label: {
                    HStack {
                        Image(systemName: "chevron.left")
                            .padding(.vertical,10)
                            .cornerRadius(10)
                        Text("Back")
                            .fontWeight(.semibold)
                            .kerning(1.2)
                    }
                    
                })
            }

            Spacer()

            Button(action: {
                withAnimation(.easeInOut){
                    isGoToLandingPage = true
                }
            }, label: {
                Text("Skip")
                    .fontWeight(.semibold)
                    .kerning(1.2)
            })
        }.padding(.horizontal, 20)
        
        
        
    }
}
