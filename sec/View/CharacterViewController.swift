import UIKit
import SwiftUI

// MARK: - CharacterViewController

class CharacterViewController: UIViewController, CharacterCellDelegate {
    
    // MARK: - Properties
    
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
      
    private var characters: [Character] = []
    private var isLoading = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1.0)
        // MARK: - Setup
        setupTitleLabel()
        setupScrollView()
        setupActivityIndicator()
        loadData()
    }
    
    
    // MARK: - Private
    
    /// setting ScrollView
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    /// setting TitleLabel
    private func setupTitleLabel() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Characters"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        scrollView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
        ])
    }
    
    /// setting ActivityIndicator
    private func setupActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        scrollView.addSubview(activityIndicator) // Добавьте activityIndicator в scrollView
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: -100),
        ])
    }
    
    /// loading information of 'Character'
    private func loadData() {
        guard !isLoading else { return }
        isLoading = true
        activityIndicator.startAnimating()
        if let url = URL(string: "https://rickandmortyapi.com/api/character")
        {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
                guard let data = data else {
                    print("Error loading data: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let response = try JSONDecoder().decode(CharacterResponse.self, from: data)
                    DispatchQueue.main.async {
                        self?.characters = response.results
                        self?.setupCharacterViews()
                        self?.isLoading = false
                        
                        DispatchQueue.main.async {
                            self?.activityIndicator.stopAnimating()
                        }
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }
            task.resume()
        }
    }
    
    /// setting two columns CharacterViews
    private func setupCharacterViews() {
        
        // MARK: - Properties
        
        var currentX: CGFloat = 20
        var currentY: CGFloat = LayoutConstants.topMargin

            for (index, character) in characters.enumerated() {
                let characterCell = CharacterCell(style: .default, reuseIdentifier: "CharacterCell")
                characterCell.configure(with: character, index: index)
                characterCell.frame = CGRect(x: currentX, y: currentY, width: LayoutConstants.squareWidth, height: LayoutConstants.squareHeight)
                scrollView.addSubview(characterCell)
                characterCell.delegate = self

                currentX += LayoutConstants.squareWidth + LayoutConstants.horizontalSpacing

                if currentX + LayoutConstants.squareWidth > scrollView.bounds.width {
                    currentX = 20
                    currentY += LayoutConstants.squareHeight + LayoutConstants.verticalSpacing
                }
            }
        scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: currentY + LayoutConstants.squareHeight + LayoutConstants.verticalSpacing)
        }
    
    /// tap on image to switch to CharacterDetailView
    func characterImageTapped(for cell: CharacterCell) {
        let characterIndex = cell.tag
        let character = characters[characterIndex]
        let characterDetailView = CharacterDetailView(character: character)
        let hostingController = UIHostingController(rootView: characterDetailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
    
    
}

// MARK: - Layout

private struct LayoutConstants {
    private static let screenWidth = UIScreen.main.bounds.width
    private static let margin: CGFloat = 48
    static let columnWidth: CGFloat = (screenWidth - margin) / 2
    static let squareWidth: CGFloat = 156
    static let squareHeight: CGFloat = 222
    static let horizontalSpacing: CGFloat = 16
    static let verticalSpacing: CGFloat = 16
    static let topMargin: CGFloat = 8
}
