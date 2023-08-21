import Foundation
import SwiftUI

// MARK: - CharacterDetailView

struct CharacterDetailView: View {
    let character: Character
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView{
            ZStack {
                Color("background")
                    .ignoresSafeArea()
                ScrollView {
                    VStack(spacing: 0) {
                        StartInfo(characterImage: character.image, characterName: character.name, characterStatus: character.status)
                        VStack(alignment: .leading, spacing: 0) {
                            FirstInfo(characterSpecies: character.species, characterType: character.type, characterGender: character.gender)
                            SecondInfo(characterOriginName: character.origin.name, characterOriginURL: character.origin.url)
                            ThirdInfo(character: character)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    var backButton: some View {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image("chevron-left")
                }
                .foregroundColor(.white)
            }
        }
    
    // MARK: - FirstInfo
    
    private struct StartInfo: View {
        
        // MARK: - Properties
        
        let characterImage : URL
        let characterName : String
        let characterStatus : String
        
        
        // MARK: - View
        
        var body: some View {
            VStack(spacing: 0) {
                     if let imageData = try? Data(contentsOf: characterImage), let uiImage = UIImage(data: imageData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .frame(width: 148, height: 148)
                        .cornerRadius(16)
                } else {
                    Text("Failed to load image")
                }
                Text(characterName)
                    .padding(.top, 24)
                    .foregroundColor(.white)
                    .font(.system(size: 22,weight: .bold))
                Text(characterStatus)
                    .padding(.top, 8)
                    .foregroundColor(Color("status"))
                    .font(.system(size: 16))
            }
        }
    }
    
    // MARK: - FirstInfo
    
    private struct FirstInfo: View {
       
        // MARK: - Properties
        
        let characterSpecies : String
        let characterType : String
        let characterGender : String
   
        // MARK: - View
        
        var body: some View {
            Text("Info")
                .font(.system(size: 17,weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 24)
                .padding(.bottom, 16)
            VStack(spacing: 0){
                CustomBadgeInfo(badgeInfo: .species, text: characterSpecies)
                CustomBadgeInfo(badgeInfo: .type, text: characterType.isEmpty ? "None" : characterType)
                CustomBadgeInfo(badgeInfo: .gender, text: characterGender)
            }
            .padding(.vertical,8)
            .background(Color("back-info"))
            .cornerRadius(16)
        }
    }
    
    // MARK: - SecondInfo
    
    private struct SecondInfo: View {
        
        // MARK: - Properties
        
        let characterOriginName : String
        let characterOriginURL : String

      
        // MARK: - View
        
        var body: some View {
            Text("Origin")
                .font(.system(size: 17,weight: .bold))
                .foregroundColor(.white)
                .padding(.top, 24)
                .padding(.bottom, 16)
            VStack{
                CustomBadgeOrigin(badgeOrigin: .planet, textName: characterOriginName, textURL: characterOriginURL)
            }
            .background(Color("back-info"))
            .cornerRadius(16)
        }
    }

    // MARK: - ThirdInfo
    
    private struct ThirdInfo: View {
        
        // MARK: - Properties
        
        let character : Character
        
        // MARK: - View
        var body: some View {
            VStack(alignment: .leading, spacing: 0) {
                Text("Episodes")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.top, 24)
                    .padding(.bottom, 8)
                ForEach(character.episodes, id: \.self) { episode in
                    CustomBadgeEpisodes(textName: episode.name, textEpisode: episode.episode , textData: episode.air_date)
                        .cornerRadius(16)
                        .padding(.vertical, 8)
                }
            }
        }
    }
}







