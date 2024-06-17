//
//  RoomDetailsViewController.swift
//  YallaBook
//
//  Created by Moe on 22/05/2024.
//

import UIKit
import RealmSwift


class RoomDetailsViewController: UIViewController {

    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var isBooked: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var roomDescription: UILabel!
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photosPageControl: UIPageControl!
    
    var roomDetails: RoomData?
    
    private var roomLogic = RoomDetailLogic()
    
    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        startTimer()
    }
    
    private func setupUI() {
        registerRoomPhotoCell()
        updateUI()
        applyBrandColors()
    }
    
    private func applyBrandColors() {
        detailsView.backgroundColor = UIColor(hexString: K.BrandColor.primary)
        bookButton.tintColor = UIColor(hexString: K.BrandColor.secondry)
    }
    
    private func registerRoomPhotoCell() {
        photoCollectionView.register(UINib(nibName: K.roomPhotoCellNibName, bundle: nil), forCellWithReuseIdentifier: K.roomPhotoIdentifer)
    }
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(showNextPhoto), userInfo: nil, repeats: true)
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func showNextPhoto() {

        let nextIndex = roomLogic.getNextPhotoIndex()
        
        photoCollectionView.scrollToItem(at: IndexPath(item: nextIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        photosPageControl.currentPage = nextIndex
    }
    
    private func updateUI() {
        UIHelper.roundCorners(of: detailsView, with: 20)
        isBooked.text = "\(roomDetails?.number ?? 0)"
        roomDescription.text = roomDetails?.roomDescription
        price.text = "\(roomDetails?.price ?? 0.0)$"
        photosPageControl.numberOfPages = roomLogic.photos.count
    }
    
    @IBAction func bookRoomPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! BookAnAppointmentViewController
        
        destinationVC.roomDetails = roomDetails
        destinationVC.delegate = self
        stopTimer()
    }
    
    deinit {
        stopTimer()
    }
}

//MARK: - Booking Room Delegate

extension RoomDetailsViewController: BookingRoomDelegate {
    func updateUIOnDismiss() {
        updateUI()
        startTimer()
    }
}

//MARK: - Collection View Data Source

extension RoomDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomLogic.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.roomPhotoIdentifer, for: indexPath) as! RoomCollectionViewCell
        
        cell.roomImageView.image = roomLogic.photos[indexPath.row]
        
        return cell
    }
}

//MARK: - Collection View Delegate Flow Layout
extension RoomDetailsViewController: UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
