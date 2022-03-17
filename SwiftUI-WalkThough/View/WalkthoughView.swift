//
//  WalkthoughView.swift
//  SwiftUI-WalkThough
//
//  Created by Waleerat Gottlieb on 2022-03-17.
//

import SwiftUI

struct WalkthoughView: View {
    @AppStorage("isGoToLandingPage") private var isGoToLandingPage: Bool = false
    @ObservedObject var walkThoughVM = WalkThoughVM()
    
    @State var currentPage = 1
    
    var body: some View {
        ZStack{
            Color.accentColor.opacity(0.4)
                .ignoresSafeArea()
            // Changing Between Views....
            ForEach (walkThoughVM.rows) { row in
                if currentPage == row.order {
                    WalkThoughPageView(currentPage: $currentPage, page: row)
                }
            }
        }
        .onAppear(){
            // Note: - Get All Records
            print("Walk Though ")
            walkThoughVM.getRecords()
            currentPage = 1
            
            print(walkThoughVM.rows)
        }
        .overlay(
            // Button...
            Button(action: {
                // changing views...
                withAnimation(.easeInOut){
                    // checking....
                    if currentPage < walkThoughVM.countRows {
                        print(" Next Ppage \(currentPage)")
                        currentPage += 1
                    } else if currentPage == walkThoughVM.countRows{
                        
                        isGoToLandingPage = true
                    }
                }
            }, label: {
                Image(systemName: currentPage == walkThoughVM.countRows ? "house.fill" : "chevron.right")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .frame(width: 60, height: 60)
                    .background(Color.white)
                    .clipShape(Circle())
                // Circlular Slider...
                    .overlay(
                        ZStack{
                            Circle()
                                .stroke(Color.black.opacity(0.04),lineWidth: 4)
                            Circle()
                                .trim(from: 0, to:  CGFloat(currentPage) / CGFloat(walkThoughVM.countRows))
                                .stroke(Color.white,lineWidth: 4)
                                .rotationEffect(.init(degrees: -90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom,20)

            ,alignment: .bottom
        )
        
    }
}
 

struct WalkthoughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthoughView()
    }
}
