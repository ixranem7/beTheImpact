import SwiftUI

struct ContentView: View {
    @State private var isSplashScreenActive = true // State variable to control the splash screen
    @State private var isMainPageActive = false // State variable to control the main page

    var body: some View {
        Group {
            if isSplashScreenActive {
                SplashView {
                    isSplashScreenActive = false // Transition to onboarding page
                }
            } else if isMainPageActive {
                ViewMainpage() // Show the main page
            } else {
                OnboardingView1 {
                    isMainPageActive = true // Navigate to the main page
                }
            }
        }
    }
}

struct SplashView: View {
    var onFinished: () -> Void

    var body: some View {
        VStack {
            Image("logo") // Replace with your image name
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 450, height: 500)
                .padding(.top, 100)

            Text("Your taste and vision... harmony and inspiration!")
                .font(.system(size: 15, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.bottom, 200)
                .foregroundColor(.pur) // Change color as needed
        }
        .padding()
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            // Navigate to onboarding after a delay
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                onFinished()
            }
        }
    }
}

struct OnboardingView1: View {
    var onComplete: () -> Void // Closure for navigation
    @State private var currentPage = 0
    let totalPages = 2

    var body: some View {
        VStack {
            VStack { // Skip button
                Button(action: {
                    onComplete() // Navigate to the main page
                }) {
                    Text("Skip")
                        .font(.headline)
                        .foregroundColor(.pur) // Change as needed
                }
                .padding(.top,50)
                .padding(.leading,300)
                .accessibilityLabel("Skip") // VoiceOver support
                .accessibilityHint("Skip the onboarding process") // Hint for users
 
            }

            // Progress Bar
            ProgressBar(progress: CGFloat(currentPage + 1) / CGFloat(totalPages))
                .padding(.horizontal)

            PageView(currentPage: $currentPage, totalPages: totalPages)

            HStack {
                Button(action: {
                    if currentPage < totalPages - 1 {
                        currentPage += 1
                    } else {
                        onComplete() // Navigate to the main page
                    }
                }) {
                    Text(currentPage == totalPages - 1 ? "Start Now" : "Next")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: 340, maxHeight: 50)
                        .background(Color.pur) // Change as needed
                        .cornerRadius(10)
                        .padding(.bottom, 80)
                }
                .accessibilityLabel(currentPage == totalPages - 1 ? "Start Now" : "Next") // VoiceOver support
                .accessibilityHint("Proceed to the next page or start the app") // Hint for users

            }
            .padding(.horizontal)
        }
        .padding(.top)
        .background(Color.white)
        .edgesIgnoringSafeArea(.all)
    }

    struct PageView: View {
        @Binding var currentPage: Int
        let totalPages: Int

        var body: some View {
            TabView(selection: $currentPage) {
                ForEach(0..<totalPages) { index in
                    VStack {
                        Image(index == 0 ? "Image" : "image2") // Replace with your images
                            .resizable()
                            .scaledToFit()
                            .frame(height: 210)
                            .accessibilityLabel("Image of \(index == 0 ? "Welcome to Zahi" : "How Zahi works")") // Image description

                        Text(index == 0 ? "Welcome to Zahi!" : "How Zahi works?")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.trailing, 150)
                            .padding(.top, 30)
                        Spacer().frame(height:0)// control between spaceing text

                        Text(index == 0
                            ? "It is an application aimed at making your daily life easier by helping you coordinate your outfits with harmonious colors and innovative visions, reflecting your unique taste and sense."
                            : "Place it in front of the camera to see its details. After you take a picture of the second piece, we will tell you whether they are harmonious or not.")
                            .multilineTextAlignment(.leading)
                            .padding()
                            .accessibilityLabel(index == 0 ? "It is an application aimed at making your daily life easier by helping you coordinate your outfits with harmonious colors and innovative visions, reflecting your unique taste and sense.": "Place it in front of the camera to see its details. After you take a picture of the second piece, we will tell you whether they are harmonious or not.")
                    }
                    .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle())
        }
    }

    struct ProgressBar: View {
        var progress: CGFloat

        var body: some View {
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: geometry.size.width, height: 10)
                        .foregroundColor(Color.gray.opacity(0.3))

                    Rectangle()
                        .frame(width: geometry.size.width * progress, height: 10)
                        .foregroundColor(Color.pur) // Progress color
                        .animation(.easeInOut(duration: 0.3), value: progress)
                }
                .cornerRadius(5)
            }
            .frame(height: 10)
            .padding(.top, 20)
        }
    }
}


// Preview provider for ContentView
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}