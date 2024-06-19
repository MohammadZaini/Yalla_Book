//
//  HotelsViewController.swift
//  YallaBook
//
//  Created by Moe on 22/05/2024.
//

import UIKit
import RealmSwift

class HotelsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var hotelLogic = HotelLogic()
    
    private var selectedIndexPath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerHotelCardCell()
//        let realm = try! Realm()
//        print(realm.configuration.fileURL)
        view.backgroundColor = UIColor(hexString: K.BrandColor.secondry)
    }
    
    private func registerHotelCardCell() {
        collectionView.register(UINib(nibName: K.hotelCardNibName, bundle: nil), forCellWithReuseIdentifier: K.hotelCardCellIdentfier)
    }
}

//MARK: - UI Collection View DataSource
extension HotelsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return hotelLogic.hotels?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.hotelCardCellIdentfier, for: indexPath) as! HotelCardCell
    
//        let hotel = HotelData(name: "Donkin", location: "UK", rating: 4, image: "somePath")
//        
//        do {
//            try realm.write {
//                realm.add(hotel)
//            }
//        } catch {
//            print(error.localizedDescription)
//        }
        
        if let hotel = hotelLogic.hotels?[indexPath.row] {
            
            cell.hotelName.text = hotel.name
            cell.locationLabel.text = hotel.location
            cell.hotelImageView.image = UIImage(named: "hotelImage")
            cell.hotelStarsLabel.text = "\(hotel.rating) Stars"
        }
        
        return cell
    }
}

//MARK: - UI Collection View Delegate
extension HotelsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath.row
        performSegue(withIdentifier: K.goToRoomsSegue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! RoomsViewController
        destinationVC.selectedHotel = hotelLogic.hotels?[selectedIndexPath]
    }
    
}

//MARK: - UI Collection View Delegate Flow Layout
extension HotelsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
