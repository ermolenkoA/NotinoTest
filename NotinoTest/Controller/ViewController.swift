import UIKit
import SnapKit

final class ViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var collectionView: UICollectionView!
    private var products = [Product]()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = UIColor(red: 249/255, green: 249/255, blue: 249/255, alpha: 0.94)
        title = "Produkty"
        
        products.append(Product(id: "1",
                                productImage: UIImage(named: "img1")!,
                                brand: "Gucci",
                                productName: "Messi",
                                annatation: "Bla bla Bla bla Bla bla Bla bla Bla bla. Bla bla Bla bla Bla bla Bla bla",
                                rating: 2.3,
                                price: "20 $"))
        products.append(Product(id: "2",
                                productImage: UIImage(named: "img2")!,
                                brand: "Gucci2",
                                productName: "Messi2",
                                annatation: "Bla bla Bla bla. Bla bla Bla bla Bla bla Bla bla",
                                rating: 4.7,
                                price: "100 $"))
        products.append(Product(id: "3",
                                productImage: UIImage(named: "img3")!,
                                brand: "Gucci3",
                                productName: "Messi3",
                                annatation: "Bla bla Bla bla Bla bla Bla bla Bla bla. Bla bla Bla bla Bla bla Bla bla",
                                rating: 3,
                                price: "400 $"))
        products.append(Product(id: "4",
                                productImage: UIImage(named: "img1")!,
                                brand: "Gucci",
                                productName: "Messi",
                                annatation: "Bla bla Bla bla Bla bla Bla bla Bla bla. Bla bla Bla bla Bla bla Bla bla",
                                rating: 2.3,
                                price: "20 $"))
        products.append(Product(id: "5",
                                productImage: UIImage(named: "img2")!,
                                brand: "Gucci2",
                                productName: "Messi2",
                                annatation: "Bla bla Bla bla. Bla bla Bla bla Bla bla Bla bla",
                                rating: 4.7,
                                price: "100 $"))
        products.append(Product(id: "6",
                                productImage: UIImage(named: "img3")!,
                                brand: "Gucci3",
                                productName: "Messi3",
                                annatation: "Bla bla Bla bla Bla bla Bla bla Bla bla. Bla bla Bla bla Bla bla Bla bla",
                                rating: 3,
                                price: "400 $"))
        
        collectionViewSettings()
    }
    
    // MARK: - Private Functions
    
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
        
        collectionView.register(CustomCVCell.self, forCellWithReuseIdentifier: CustomCVCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { maker in
            maker.trailing.top.bottom.leading.equalTo(view.safeAreaLayoutGuide)
        }
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
