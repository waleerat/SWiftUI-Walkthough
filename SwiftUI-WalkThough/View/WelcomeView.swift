//
//  WelcomeView.swift
//  SwiftUI-WalkThough
//
//  Created by Waleerat Gottlieb on 2022-03-17.
//

import SwiftUI

struct WelcomeView: View {
    @AppStorage("isGoToLandingPage") private var isGoToLandingPage: Bool = false
    
    var body: some View {
        ZStack{
            Color(hex: "#192A44")
            
            VStack {
                Text("Welcome")
                    .font(.headline)
                    .foregroundColor(.white)
                
                // Button...
                Button(action: {
                    // changing views...
                    withAnimation(.easeInOut){
                        isGoToLandingPage = false
                    }
                }, label: {
                    Image(systemName: "arrow.clockwise")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(Circle())
                })
                .padding(.bottom,20)
            }
        }
        .ignoresSafeArea(.all)
         
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
