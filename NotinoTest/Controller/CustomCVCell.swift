import UIKit
import SnapKit

final class CustomCVCell: UICollectionViewCell {
    
    // MARK: - Public Properties
    
    public static let identifier = "CustomCVCell"
    
    // MARK: - Private Properties
    
    private var product: Product?

    private var heartImageView: UIImageView!
    private var heartView: UIView!
    private var productImageView: UIImageView!
    private var brandLabel: UILabel!
    private var productLabel: UILabel!
    private var annotationLabel: UILabel!
    private var ratingView: UIView!
    private var priceLabel: UILabel!
    private var cartButton: UIButton!
    
    // MARK: - Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Creating Functions
    
    private func heartCreating() {
        heartView = UIView(frame: .zero)
        contentView.addSubview(heartView)
        heartView.snp.makeConstraints { make in
            make.top.right.equalTo(contentView)
            make.height.width.equalTo(48)
        }
        heartImageView = UIImageView(frame: .zero)
        setWishlistStatus(isWishlisted: WishlistAndCartManager.isProductExist(where: .wishlist, product!.id))
        heartImageView.contentMode = .scaleAspectFill
        heartImageView.clipsToBounds = true
        heartView.addSubview(heartImageView)
        heartImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(16)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedWishlist))
        heartView.addGestureRecognizer(tap)
    }
    
    private func mainInfoCreating() {
        productImageView = UIImageView(frame: .zero)
        productImageView.image = product!.productImage
        productImageView.contentMode = .scaleAspectFit
        contentView.addSubview(productImageView)
        productImageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(heartView.snp.bottom)
            make.height.equalTo(160)
            make.width.equalTo(164)
        }
        
        brandLabel = UILabel(frame: .zero)
        brandLabel.text = product!.brand
        brandLabel.textAlignment = .center
        brandLabel.numberOfLines = 0
        brandLabel.font = UIFont(name: Font.SFRegular, size: 14)
        brandLabel.textColor = Color.inkTertiary
        contentView.addSubview(brandLabel)
        brandLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productImageView.snp.bottom).inset(-12)
        }

        productLabel = UILabel(frame: .zero)
        productLabel.text = product!.productName
        productLabel.textAlignment = .center
        productLabel.numberOfLines = 0
        productLabel.font = UIFont(name: Font.SFMedium, size: 14)
        productLabel.textColor = .black
        contentView.addSubview(productLabel)
        productLabel.snp.makeConstraints() { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(brandLabel.snp.bottom).inset(-4)
        }

        annotationLabel = UILabel(frame: .zero)
        annotationLabel.text = product!.annatation
        annotationLabel.textAlignment = .center
        annotationLabel.numberOfLines = 0
        annotationLabel.font = UIFont(name: Font.SFRegular, size: 14)
        annotationLabel.textColor = Color.inkSecondary
        contentView.addSubview(annotationLabel)
        annotationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(productLabel.snp.bottom)
        }
    }
    
    private func ratingCreating() {
        ratingView = UIView(frame: .zero)
        contentView.addSubview(ratingView)
        ratingView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview()
            make.top.equalTo(annotationLabel.snp.bottom).inset(-12)
        }
        
        for i in 0...4 {
            let star = UIImageView(frame: .zero)
            star.image = Int(product!.rating.rounded()) > i ? UIImage(named: Images.starFilled) : UIImage(named: Images.star)
            star.contentMode = .scaleAspectFit
            ratingView.addSubview(star)
        }
        
        for i in 0...4 {
            ratingView.subviews[i].snp.makeConstraints { make in
                make.height.width.equalTo(12)
                make.top.bottom.equalToSuperview()
                make.centerY.equalToSuperview()
                switch i {
                case 0...1:
                    make.right.equalTo(ratingView.subviews[i+1].snp.left).inset(-1)
                case 2:
                    make.centerX.equalToSuperview().inset(-1)
                case 3...4:
                    make.left.equalTo(ratingView.subviews[i-1].snp.right).inset(-1)
                default:
                    break
                }
            }
        }
    }
    
    private func priceCreating() {
        priceLabel = UILabel(frame: .zero)
        priceLabel.text = product!.price
        priceLabel.textAlignment = .center
        priceLabel.font = UIFont(name: Font.SFMedium, size: 14)
        priceLabel.textColor = .black
        contentView.addSubview(priceLabel)
        priceLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(ratingView.snp.bottom).inset(-12)
        }
    }
    
    private func cartButtonCreating() {
        cartButton = UIButton(frame: .zero)
        cartButton.layer.borderColor = Color.borderColor
        cartButton.layer.borderWidth = 1
        setCartStatus(isInCart: WishlistAndCartManager.isProductExist(where: .cart, product!.id))
        contentView.addSubview(cartButton)
        
        cartButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(priceLabel.snp.bottom).inset(-12)
            make.bottom.equalToSuperview().inset(12)
        }
        
        var configuration = UIButton.Configuration.borderless()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        cartButton.configuration = configuration
        cartButton.addTarget(self, action: #selector(tappedCartButton), for: .touchUpInside)
    }
    
    // MARK: - Private Logic Functions
    
    @objc func tappedCartButton() {
        setCartStatus(isInCart: WishlistAndCartManager.changeCartStatus(product!.id) == .added)
    }
    
    @objc func tappedWishlist() {
        setWishlistStatus(isWishlisted: WishlistAndCartManager.changeWhitelistStatus(product!.id) == .added)
    }
    
    private func setCartStatus(isInCart: Bool) {
        if let font = UIFont(name: Font.SFMedium, size: 14) {
            let (text, textColor) = isInCart ? ("V košíku", Color.inkTertiary) : ("Do košíku", .black)
            let attributedText = NSAttributedString(string: text,
                                                    attributes: [NSAttributedString.Key.font: font,
                                                                 NSAttributedString.Key.foregroundColor: textColor])
            cartButton.setAttributedTitle(attributedText, for: .normal)
        } else {
            print("<CustomTVCell\\setCartStatus> ERROR: the font isn't exist.")
        }
    }
    
    private func setWishlistStatus(isWishlisted: Bool) {
        heartImageView.image = isWishlisted ? UIImage(named: Images.heartFilled) : UIImage(named: Images.heart)
    }
    
}

// MARK: - SetProductProtocol

extension CustomCVCell: SetProductProtocol {
    func setProduct(_ product: Product) {
        contentView.subviews.forEach { $0.removeFromSuperview() }
        contentView.sizeToFit()
        self.product = product
        heartCreating()
        mainInfoCreating()
        ratingCreating()
        priceCreating()
        cartButtonCreating()
        contentView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
