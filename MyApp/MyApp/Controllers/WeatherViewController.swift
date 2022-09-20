//
//  WeatherViewController.swift
//  MyApp
//
//  Created by jun.kohda on 2022/09/19.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class WeatherViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map{self.cityNameTextField.text}
            .subscribe(onNext: { city in
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(by: city)
                    }
                }
            }).disposed(by: disposeBag)
    }

    private func displayWeather(_ weather: Weather?) {
        if let weather = weather {
            self.temperatureLabel.text = "\(weather.temp)度"
            self.humidityLabel.text = "\(weather.humidity)%"
        } else {            let alert = UIAlertController(title: "エラー", message: "エラーが発生しました", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true, completion: nil)
            self.temperatureLabel.text = "温度"
            self.humidityLabel.text = "湿度"
        }
    }
    
    private func fetchWeather(by city: String) {
        
        let resource = Resource<WeatherResult>(url: URL(string: ConstStruct.weatherURL1+city+ConstStruct.weatherURL2)!)

        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .retry(3)
            .catchError { error in                
                let alert = UIAlertController(title: "エラー", message: "都市名が不正です", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true, completion: nil)
                print(error.localizedDescription)
                
                return Observable.just(WeatherResult.empty)
            }.asDriver(onErrorJustReturn: WeatherResult.empty)
        
        
        search.map { "\($0.main.temp)度"}
            .drive(self.temperatureLabel.rx.text)
            .disposed(by: disposeBag)
        
        search.map{"\($0.main.humidity)%"}
            .drive(self.humidityLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

