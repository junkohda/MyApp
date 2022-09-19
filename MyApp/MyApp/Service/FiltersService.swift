//
//  FiltersService.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/18.
//

import Foundation
import UIKit
import CoreImage
import RxSwift

class FiltersService {
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage) -> Observable<UIImage> {
        
        return Observable<UIImage>.create { observer in
            
            self.applyFilter(to: inputImage) { filterImage in
                observer.onNext(filterImage)
            }
            return Disposables.create()
        }
    }
    
    func applyFilter(to inputImage: UIImage, completion: @escaping ((UIImage) -> ())) {
        
        let filter = CIFilter(name: "CICMYKHalftone")!
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        if let sourceImage = CIImage(image: inputImage) {
            
            filter.setValue(sourceImage, forKey: kCIInputImageKey)
            
            if let cgimg = self.context.createCGImage(filter.outputImage!, from: filter.outputImage!.extent) {
                
                let processdImage = UIImage(cgImage: cgimg, scale: inputImage.scale,orientation: inputImage.imageOrientation)
                completion(processdImage)
            }
        }
    }
}

