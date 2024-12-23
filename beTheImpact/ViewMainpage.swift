import SwiftUI
struct ViewMainpage: View {
@State private var showAlert = false
    
    var body: some View {
        ZStack{
            VStack {
                Text("Welcome to your digital wardrobe! ")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.3, green: 0.2, blue: 0.5, opacity: 1.0))
                    .multilineTextAlignment(.leading)
                    .padding(.top , -30)
                    .padding(.trailing , 90)
                
                Text(" Use the camera to know the outfit:")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color.pur)
                    .multilineTextAlignment(.leading)
                    .padding(.top , -10)
                    .padding(.trailing , 40)
                
                Button(action: {
                    showAlert = true
                }) {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()          .frame(width: 100, height: 100)
                    .font(.title)
                        .padding()
                        .frame(width: 350, height: 400)
                        .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.pur.opacity(0.7), Color.pur]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                        
                        .foregroundColor(.white)
                        .cornerRadius(20)
                        .padding(.top , 50)

                }.shadow(radius: 10)

            }.blur(radius: showAlert ? 5 : 0)
                
            .alert("Camera Instructions ", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                }message: {
                Text("Make sure you are slightly away from the camera so the piece appears clearly")
                }
                
            
        }
        .padding()
    }
}

#Preview {
    ViewMainpage()
}
