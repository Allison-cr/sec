import Foundation
import SwiftUI

// MARK: - CustomBadgeOrigin

struct CustomBadgeOrigin: View {
    
    // MARK: - Properties
    
    /// The planet  of 'Character'
    var badgeOrigin: BadgeOrigin
    
    /// The name  of 'Character'
    var textName: String
    
    /// The url of 'Character'
    var textURL: String
   
    var title: String {
        switch badgeOrigin {
        case .planet:
            return "Planet"
        }
    }
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Image("planet")
                .padding(.all, 20)
                .background(Color("around-planet"))
                .cornerRadius(10)
            VStack(alignment: .leading, spacing: 0) {
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
