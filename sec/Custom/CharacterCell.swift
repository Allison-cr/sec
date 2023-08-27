import Foundation
import UIKit

// MARK: - CharacterCell

class CharacterCell: UITableViewCell {
 
    // MARK: - Properties
    
    private let squareWidth: CGFloat = 140
    private let squareHeight: CGFloat = 140
    private let horizontalSpacing: CGFloat = 16
    private let verticalSpacing: CGFloat = 16
    
    private let characterImageView = UIImageView()
    private let nameLabel = UILabel()
    private let infoBackgroundView = UIView()
    private let containerView = UIView()
    weak var delegate: CharacterCellDelegate?
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupContainerView()
        setupCharacterImageView()
        setuupBackgroundView()
        setupNameLabel()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    // MARK: - settings ContainerView
    
    private func setupContainerView() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1.0)
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        containerView.addSubview(characterImageView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: - settings CharacterImageView
    
    private func setupCharacterImageView() {
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.layer.cornerRadius = 10
        characterImageView.layer.masksToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        characterImageView.isUserInteractionEnabled = true
        characterImageView.addGestureRecognizer(tapGesture)
        NSLayoutConstraint.activate([
            characterImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            characterImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            characterImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            characterImageView.heightAnchor.constraint(equalToConstant: squareHeight - 16)
        ])
    }

    // MARK: - settings BackgroundView
    
    private func setuupBackgroundView() {
        containerView.addSubview(infoBackgroundView)
        infoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        infoBackgroundView.backgroundColor = UIColor(red: 38/255, green: 42/255, blue: 56/255, alpha: 1.0)
        NSLayoutConstraint.activate([
            infoBackgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            infoBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            infoBackgroundView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            infoBackgroundView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    // MARK: - settings NameLabel
  
    private func setupNameLabel() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 0
        nameLabel.textColor = .white
        infoBackgroundView.addSubview(nameLabel)
        let topConstraint = nameLabel.topAnchor.constraint(equalTo: infoBackgroundView.topAnchor, constant: 8)
        topConstraint.priority = .defaultHigh
        topConstraint.isActive = true
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: infoBackgroundView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: infoBackgroundView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: infoBackgroundView.bottomAnchor, constant: -8)
        ])
    }

    // MARK: - Configurations
    
    func configure(with character: Character, index: Int) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: character.image),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.characterImageView.image = image
                }
            }
        }
        self.tag = index
        nameLabel.text = character.name
    }
    
    // MARK: - tap on image
    
    @objc private func imageTapped() {
        delegate?.characterImageTapped(for: self)
    }
}

// MARK: - CharacterCellDelegate

protocol CharacterCellDelegate: AnyObject {
    func characterImageTapped(for cell: CharacterCell)
}


