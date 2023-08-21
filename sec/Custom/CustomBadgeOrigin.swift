import Foundation
import SwiftUI

// MARK: - CustomBadgeOrigin

struct CustomBadgeOrigin: View {
    
    // MARK: - Properties
    
    var badgeOrigin : BadgeOrigin
    var textName:String
    var textURL:String
   
    var title: String {
        switch badgeOrigin {
        case .planet:
            return "Planet"
        }
    }
    var body: some View {
        HStack{
            Image("planet")
                .padding(.all, 20)
                .background(Color("around-planet"))
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 0){
                Text(textName)
                    .foregroundColor(.white)
                    .font(.system(size: 17,weight: .bold))
                Text(title)
                    .foregroundColor(Color("status"))
                    .font(.system(size: 13))
                    .padding(.top, 8)
            }
            .padding(.leading, 8)
            .padding(.vertical, 16)
            Spacer()
        }
        .padding(.horizontal, 8)
    }
}

