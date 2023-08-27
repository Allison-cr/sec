import Foundation
import SwiftUI

// MARK: - CustomBadgeInfo

struct CustomBadgeInfo: View {
    
    // MARK: - Properties
    
    /// The info  of 'Character'
    var badgeInfo: BadgeInfo
    
    /// The text  of 'Character'
    var text: String
    
    var title: String {
        switch badgeInfo {
        case .species:
            return "Species"
        case .type:
            return "Type"
        case .gender:
            return "Gender"
        }
    }
    
    // MARK: - View
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(Color("info"))
            Spacer()
            Text(text)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}
