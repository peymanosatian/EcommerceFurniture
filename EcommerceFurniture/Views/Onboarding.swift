import SwiftUI

struct Onboarding: View {
    @State private var dragOffset: CGFloat = 0 // Tracks how far the user has dragged
    @State private var showLogin = false       // Controls navigation to the login page
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background stage image (full screen)
                Image("BackgroundStage") // Replace with your background image (without the chair)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                
                // Chair image, move up with offset to match the desired position
                Image("Chair") // Replace with your chair image
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.8)  // Adjust chair size relative to screen width
                    .offset(y: dragOffset + 40) // Move the chair up; adjust this value to position the chair
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                // Allow the user to drag the chair upward but not down
                                if value.translation.height < 0 {
                                    dragOffset = value.translation.height
                                }
                            }
                            .onEnded { value in
                                // If the user dragged more than 60% (adjustable), navigate to login
                                if value.translation.height < -UIScreen.main.bounds.height * 0.6 {
                                    withAnimation {
                                        showLogin = true
                                    }
                                } else {
                                    // Otherwise, animate the chair back to its original position
                                    withAnimation {
                                        dragOffset = 0
                                    }
                                }
                            }
                    )
                    .animation(.spring()) // Smooth animation for dragging and returning
                
                VStack {
                    // Title and subtitle at the top of the screen
                    VStack(spacing: 4) {
                        Text("FurniQ")
                            .font(.system(size: 48, weight: .bold))
                            .foregroundColor(Color("GreenOnboarding"))

                        Text("Furniture online shop")
                            .font(.system(size: 16))
                            .foregroundColor(Color("GreenOnboarding"))
                    }
                    .padding(.top, 100) // Add padding from the top of the screen
                    Spacer()
                    
                    // Text and chevron below chair image
                    VStack {
                        Image(systemName: "chevron.up")
                            .padding(.bottom, 10)
                            .foregroundStyle(Color("GreenOnboarding"))
                        
                        Text("Get started")
                            .font(.headline)
                            .foregroundColor(Color("GreenOnboarding"))
                    }
                    .padding(.bottom, 50)
                }
            }
            .preferredColorScheme(.dark)
            // Navigation link to your login page
            .navigationDestination(isPresented: $showLogin) {
                LoginView() // Replace with your login page view
            }
        }
    }
}

#Preview {
    Onboarding()
}
