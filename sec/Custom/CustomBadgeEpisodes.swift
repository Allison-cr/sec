import Foundation
import SwiftUI

// MARK: - CustomBadgeEpisodes

struct CustomBadgeEpisodes: View {
    
    // MARK: - Properties

    /// The name  of 'Eppisodes'
    var textName:String
    
    /// The number series/season  of 'Eppisodes'
    var textEpisode:String
    
    /// The air date  of 'Eppisodes'
    var textData:String
    
    // MARK: - View 

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 0) {
                    Text(textName)
                        .padding(.top, 16)
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.white)
                    if let convertedEpisode = convertEpisodeCode(textEpisode) {
                        Text(convertedEpisode)
                            .padding(.top, 16)
                            .font(.system(size: 13))
                            .foregroundColor(Color("status"))
                    } else {
                        Text("Invalid Episode Code")
                    }
                }
                .padding(.leading, 15.25)
                .padding(.bottom, 14)
            Spacer()
            VStack {
                Text(textData)
                    .padding(.top, 54)
                    .padding(.bottom, 16)
                    .foregroundColor(Color("calendar"))
                    .font(.system(size: 12))
            }
            .padding(.trailing, 15.6)
        }
        .background(Color("back-info"))
    }
    
    // MARK: - Private
    
  private  func convertEpisodeCode(_ code: String) -> String? {
        let parts = code.split(separator: "E")
        if parts.count == 2, let season = Int(parts[0].dropFirst()), let episode = Int(parts[1]) {
            let seasonString = String(format: "Season: %02d", season)
            let episodeString = String(format: "Episode: %02d", episode)
            return "\(episodeString), \(seasonString)"
        }
        return nil
    }
}

// MARK: - Previews

struct CustomBadgeEpisodes_Previews: PreviewProvider {
    static var previews: some View {
        CustomBadgeEpisodes(
            textName: "Episode Name",
            textEpisode: "Episode URL",
            textData: "december"
        )
    }
}

