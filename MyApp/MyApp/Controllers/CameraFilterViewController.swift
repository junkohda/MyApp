//
//  CameraFilterViewController.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/18.
//

import Foundation
import RxSwift

class CameraFilterViewController: UIViewController {

    @IBOutlet weak var applyFilterButton: UIButton!
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController
        else {
            fatalError("Segue destination is not found")
        }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: disposeBag)
    }
    
    
    @IBAction func applyFilterButtonPressed() {
        
        guard let sourceImage = self.photoImageView.image else {
            return
        }
         
        FiltersService().applyFilter(to: sourceImage)
            .subscribe(onNext: {filterdImage in
                
                DispatchQueue.main.async {
                    self.photoImageView.image = filterdImage
                }
            }).disposed(by: disposeBag)
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.applyFilterButton.isHidden = false
    }
    
}

