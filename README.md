# RickAndMorty
>Тестовое задание:  
    1. Заставка с временной задержкой  
    2. Получить и вывести список персонажей с сервера, UIkit  
    3. При нажатии на персонажа открыть новый экран с подробной информацией об этом персонаже, SwiftUI

---
>[!IMPORTANT]
__1. Заставка.__  Сам экран создан программно и прописан полностью на SwiftUI.  
```Swift
func start() {
        let splashScreen = SplashScreen()
        let hostingController = UIHostingController(rootView: splashScreen)

        window.rootViewController = hostingController
        window.makeKeyAndVisible()

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showCharacterScreen()
        }
    }
```
<img src="https://raw.githubusercontent.com/Allison-cr/sec/main/sec/utils/Simulator%20Screenshot%20-%20iPhone%2014%20Pro%20-%202024-01-30%20at%2001.00.10.png" width="230" height="450">

>[!IMPORTANT]
__2. Список персонажей__ 
>Модель данных 
```Swift
    enum CodingKeys: String, CodingKey {
        case name
        case gender
        case species
        case image
        case status
        case type
        case origin
        case episodesURLs = "episode"
    }
    
    // MARK: - Initializers
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        gender = try container.decode(String.self, forKey: .gender)
        species = try container.decode(String.self, forKey: .species)
        image = try container.decode(URL.self, forKey: .image)
        status = try container.decode(String.self, forKey: .status)
        type = try container.decode(String.self, forKey: .type)
        origin = try container.decode(Location.self, forKey: .origin)
        let episodesURLs = try container.decode([URL].self, forKey: .episodesURLs)
        episodes = []
        for episodeURL in episodesURLs {
            if let episodeData = try? Data(contentsOf: episodeURL) {
                if let episode = try? JSONDecoder().decode(EpisodeData.self, from: episodeData) {
                    episodes.append(episode)
                }
            }
        }
    }
}
```

>[!IMPORTANT]Пока идет загрузка данных, выведен индикатор загрузки получения данных

<img src="https://raw.githubusercontent.com/Allison-cr/sec/main/sec/utils/Simulator%20Screenshot%20-%20iPhone%2014%20Pro%20-%202024-01-30%20at%2001.00.14.png" width="230" height="450">
<img src="https://raw.githubusercontent.com/Allison-cr/sec/main/sec/utils/Simulator%20Screenshot%20-%20iPhone%2014%20Pro%20-%202024-01-30%20at%2001.00.33.png" width="230" height="450">


> __3.Детальный экран персонажа__ 

```Swift
    func showCharacterDetailScreen(for character: Character) {
        let characterDetailView = CharacterDetailView(character: character)
        let hostingController = UIHostingController(rootView: characterDetailView)
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(hostingController, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: hostingController)
            window.rootViewController = navigationController
        }
    }
```
<img src="https://raw.githubusercontent.com/Allison-cr/sec/main/sec/utils/Simulator%20Screenshot%20-%20iPhone%2014%20Pro%20-%202024-01-30%20at%2001.00.39.png" width="230" height="450">
<img src="https://raw.githubusercontent.com/Allison-cr/sec/main/sec/utils/Simulator%20Screenshot%20-%20iPhone%2014%20Pro%20-%202024-01-30%20at%2001.00.46.png" width="230" height="450">


