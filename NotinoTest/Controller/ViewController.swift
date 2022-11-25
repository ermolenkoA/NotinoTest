import UIKit
import SnapKit
import AlignedCollectionViewFlowLayout
final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    private var mainView: UIView!
    private var collectionView: UICollectionView!
    private var activityIndicator = UIActivityIndicatorView()
    private var products = [Product]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        
        title = "Produkty"
        if let font = UIFont(name: Font.SFMedium, size: 16) {
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: font]
        }
        mainViewSettings()
        activityIndicatorSettings()
        startSearching()
    }
    
    // MARK: - Private Functions
    
    private func startSearching() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        JSONManager.getData{ [weak self] products in
            guard let self = self else {
                return
            }
            if let products = products {
                self.products = products
            }
            self.collectionViewSettings()
        }
    }
    
    private func endSearching() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
    }
    
    private func activityIndicatorSettings() {
        activityIndicator.color = .black
        activityIndicator.style = .large
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func mainViewSettings() {
        mainView = UIView(frame: .zero)
        mainView.backgroundColor = .white
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalToSuperview()
        }
    }
    
    private func collectionViewSettings() {
        let layout = AlignedCollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 8
        layout.verticalAlignment = .top
        layout.estimatedItemSize = CGSize(width: 164, height: 450)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .clear
        mainView?.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        endSearching()
        
        collectionView.register(CustomCVCell.self, forCellWithReuseIdentifier: CustomCVCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}

// MARK: - UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCVCell.identifier, for: indexPath)
        (cell as? SetProductProtocol)?.setProduct(products[indexPath.item])
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
}
