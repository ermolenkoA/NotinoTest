import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView!
    private var activityIndicator = UIActivityIndicatorView()
    private var products = [Product]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        title = "Produkty"
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
    
    private func collectionViewSettings() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: 164, height: 400)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.alwaysBounceVertical = true
        collectionView.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { maker in
            maker.trailing.top.bottom.leading.equalTo(view.safeAreaLayoutGuide)
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

// MARK: - UICollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {

}
