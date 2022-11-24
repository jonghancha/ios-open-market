//  Created by Aejong, Tottale on 2022/11/22.

import UIKit

class ProductGridCell: UICollectionViewCell {
    static let identifier = "cell"
    
    let stackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    let productImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stockLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureStackView() {
        stackView.addArrangedSubview(productImage)
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(priceLabel)
        stackView.addArrangedSubview(stockLabel)
    }

    func layout() {
        configureStackView()
        contentView.addSubview(stackView)

        layer.masksToBounds = true
        layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            productImage.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.5)
        ])
    }

    func configCell(with product: Product) {
        self.productImage.image = urlToImage(product.thumbnail)
        self.nameLabel.text = product.name
        self.priceLabel.text = product.price.description
        self.stockLabel.text = product.stock.description
    }
    
    func urlToImage(_ urlString: String) -> UIImage? {
        guard let url = URL(string: urlString),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}
