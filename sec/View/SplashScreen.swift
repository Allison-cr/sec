import Foundation
import SwiftUI


import SwiftUI

// MARK: - SplashScreen

struct SplashScreen: View {
    var body: some View {
        ZStack{
            Color("background")
            HStack{
               Stars()
               Spacer()
            }
            HStack{
                Label()
                Spacer()
            }
            .padding(.leading, 118)
        }.ignoresSafeArea()
    }
    
    // MARK: - StarsAdd
    
    private struct StarsAdd: View {
        var body: some View {
            VStack(alignment: .leading,spacing: 0){
                Image("Ellipse 9")
                    .padding(.leading, 47)
                    .padding(.top, 4)
                Image("Ellipse 16")
                    .padding(.leading, 179)
                    .padding(.top, 56)
                Image("Ellipse 13")
                    .padding(.leading, 275)
                    .padding(.top, 24)
                Image("Ellipse 11")
                    .padding(.leading, 28)
                    .padding(.top, 20)
                Image("Ellipse 14")
                    .padding(.leading, 156)
                    .padding(.top, 59)
                Image("Ellipse 17")
                    .padding(.leading, 327)
                    .padding(.top, 29)
            }
        }
    }
    
    // MARK: - Stars
    
    private struct Stars: View {
        var body: some View {
            VStack(alignment: .leading,spacing: 0){
                Image("Ellipse 4")
                    .padding(.leading, 34)
                    .padding(.top, 98)
                Image("Ellipse 6")
                    .padding(.leading, 219)
                    .padding(.top, 4)
                Image("Ellipse 8")
                    .padding(.leading, 346)
                    .padding(.top, 13)
                Image("Ellipse 7")
                    .padding(.leading, 331)
                    .padding(.top, 55)
                Image("Ellipse 5")
                    .padding(.leading, 70)
                    .padding(.top, 44)
                Image("Ellipse 10")
                    .padding(.leading, 16)
                    .padding(.top, 97)
                Image("Ellipse 15")
                    .padding(.leading, 336)
                    .padding(.top, 90)
                Image("Ellipse 18")
                    .padding(.leading, 311)
                    .padding(.top, 83)
                StarsAdd()
                Spacer()
            }
        }
    }
    
    // MARK: - Label
    
    struct Label: View {
        var body: some View {
            VStack{
                Image("Frame-2")
                Image("Frame")
                    .padding(.top,36)
                Spacer()
            }
            .padding(.top, 164)
        }
    }

}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
