import UIKit
import SwiftUI

// MARK: - CharacterViewController

class CharacterViewController: UIViewController, CharacterCellDelegate {
    
    // MARK: - Properties
    
    private let columnWidth: CGFloat = (UIScreen.main.bounds.width - 48) / 2
    private let squareWidth: CGFloat = 156
    private let squareHeight: CGFloat = 222
    private let horizontalSpacing: CGFloat = 16
    private let verticalSpacing: CGFloat = 16
    private let topMargin: CGFloat = 8

    private let scrollView = UIScrollView()
    private var characters: [Character] = []
    private var isLoading = false
    private let titleLabel = UILabel()
    private let activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 4/255, green: 12/255, blue: 30/255, alpha: 1.0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Characters"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 28)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 24),
        ])
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .white
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        loadData()
    }
    
    // MARK: - loadData
    
    private func loadData() {
        guard !isLoading else { return }
        isLoading = true
        activityIndicator.startAnimating()
        let url = URL(string: "https://rickandmortyapi.com/api/character")!
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
    
    // MARK: - setupCharacterViews
    
    private func setupCharacterViews() {
        
        // MARK: - Properties
        
            var currentX: CGFloat = 20
            var currentY: CGFloat = topMargin

            for (index, character) in characters.enumerated() {
                let characterCell = CharacterCell(style: .default, reuseIdentifier: "CharacterCell")
                characterCell.configure(with: character, index: index)
                characterCell.frame = CGRect(x: currentX, y: currentY, width: squareWidth, height: squareHeight)
                scrollView.addSubview(characterCell)
                characterCell.delegate = self

                currentX += squareWidth + horizontalSpacing

                if currentX + squareWidth > scrollView.bounds.width {
                    currentX = 20
                    currentY += squareHeight + verticalSpacing
                }
            }
            scrollView.contentSize = CGSize(width: scrollView.bounds.width, height: currentY + squareHeight + verticalSpacing)
        }
    
    // MARK: - characterImageTapped
    
    func characterImageTapped(for cell: CharacterCell) {
        let characterIndex = cell.tag
        let character = characters[characterIndex]
        let characterDetailView = CharacterDetailView(character: character)
        let hostingController = UIHostingController(rootView: characterDetailView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

// MARK: - UIScrollView

extension UIScrollView {
    func indexPathForSubview(_ subview: UIView) -> IndexPath? {
        for (index, cell) in subviews.enumerated() {
            if cell === subview {
                let row = index / 2
                let column = index % 2
                return IndexPath(row: row, section: column)
            }
        }
        return nil
    }
}

