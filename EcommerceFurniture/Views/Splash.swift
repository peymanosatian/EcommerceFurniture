//
//  Splash.swift
//  EcommerceFurniture
//
//  Created by Peyman Osatian on 2024-10-20.
//

import SwiftUI

struct Splash: View {
    @State var isActive = false
    var body: some View {
        VStack {
            if isActive {
                Onboarding()
            }else {
                Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 32))
                    .fontWeight(.bold)
            }
        }
                .onAppear(){
              // move to onboarding page after 3 seconds
                    DispatchQueue.main.asyncAfter(deadline:.now() + 3){
                        withAnimation{
                            isActive = true
                        }
                    }
            }
        }
    }

#Preview {
    Splash()
}
