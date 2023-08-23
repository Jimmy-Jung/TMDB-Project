//
//  MapViewController.swift
//  TMDB Project
//
//  Created by 정준영 on 2023/08/23.
//

import UIKit
import CoreLocation
import MapKit

enum LocationStatus {
    case valid
    case invalid
}

enum theaterCase {
    case lotte
    case cgv
    case mega
    case all
}

final class MapViewController: UIViewController {
    // 위치 매니저 생성: 위치에 대한 대부분을 담당
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let theater = TheaterList()
    private lazy var currentStatusButton: UIButton = {
       let button = UIButton()
        var configuration = UIButton.Configuration.plain()
        var titleAtt = AttributedString.init("위치 서비스 이용 불가")
        titleAtt.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        configuration.attributedTitle = titleAtt
        configuration.image = UIImage(systemName: "location.slash.circle")
        configuration.preferredSymbolConfigurationForImage = .init(pointSize: 14)
        configuration.imagePadding = 3
        configuration.imagePlacement = .leading
        button.configuration = configuration
        button.backgroundColor = .systemBackground
        button.tintColor = .systemRed
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(statusButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var searchCinemaButton: UIButton = {
        let button = UIButton()
         var configuration = UIButton.Configuration.plain()
         var titleAtt = AttributedString.init("영화관 찾기")
         titleAtt.font = UIFont.systemFont(ofSize: 20, weight: .bold)
         configuration.attributedTitle = titleAtt
         configuration.image = UIImage(systemName: "popcorn")
         configuration.preferredSymbolConfigurationForImage = .init(pointSize: 20)
         configuration.imagePadding = 8
         configuration.imagePlacement = .leading
         button.configuration = configuration
         button.backgroundColor = .systemBlue
         button.tintColor = .white
         button.layer.cornerRadius = 10
         button.layer.masksToBounds = true
         button.addTarget(self, action: #selector(searchCinemaButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    @objc private func statusButtonTapped(_ sender: UIButton) {
        showLocationSettingAlert()
    }
    @objc private func searchCinemaButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "영화관 선택", message: nil, preferredStyle: .actionSheet)
        let cinema1 = UIAlertAction(title: "롯데시네마", style: .default) { [weak self] _ in
            self?.setAnnotation(type: .lotte)
        }
        let cinema2 = UIAlertAction(title: "CGV", style: .default) { [weak self] _ in
            self?.setAnnotation(type: .cgv)
        }
        let cinema3 = UIAlertAction(title: "메가박스", style: .default) { [weak self] _ in
            self?.setAnnotation(type: .mega)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(cinema1)
        alert.addAction(cinema2)
        alert.addAction(cinema3)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setupDelegate()
        checkDeviceLocationAuthorization()
        setupUserLocation()
        
    }
    
    private func setAnnotation(type: theaterCase) {
        var locations: [MKPointAnnotation] = []
        switch type {
        case .lotte:
            locations.append(theater.getLocation(num: 0))
            locations.append(theater.getLocation(num: 1))
        case .cgv:
            locations.append(theater.getLocation(num: 2))
            locations.append(theater.getLocation(num: 3))
        case .mega:
            locations.append(theater.getLocation(num: 4))
            locations.append(theater.getLocation(num: 5))
        case .all:
            (0...5).forEach { locations.append(theater.getLocation(num: $0)) }
        }
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(locations)
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D, title: String) {
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 800, longitudinalMeters: 800)
        mapView.setRegion(region, animated: true)
        // 지도에 어노테이션 추가
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.coordinate = center
        setAnnotation(type: .all)
        mapView.addAnnotation(annotation)
    }
    
    private func setupUserLocation() {
        self.mapView.showsUserLocation = true
        DispatchQueue.global().async {
            self.mapView.setUserTrackingMode(.follow, animated: true)
        }
        
    }
    
    private func changeStatusLabel(status: LocationStatus) {
        switch status {
        case .valid:
            currentStatusButton.isHidden = true
        case .invalid:
            currentStatusButton.isHidden = false
        }
    }
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(currentStatusButton)
        view.addSubview(searchCinemaButton)
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        currentStatusButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide ).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide ).offset(-20)
            make.height.equalTo(30)
        }
        searchCinemaButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(40)
        }
    }
    
    private func setupDelegate() {
        locationManager.delegate = self
        mapView.delegate = self
    }
    
    private func showLocationSettingAlert() {
        showCancelAlert(
            title: "위치 정보 이용",
            message: "위치 서비스를 이용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요",
            preferredStyle: .alert,
            cancelTitle: "취소",
            okTitle: "설정으로 이동",
            cancelHandler: { [weak self] _ in
                let defaultLocation = CLLocationCoordinate2D(latitude: 37.517731, longitude: 126.886316)
                self?.setRegionAndAnnotation(center: defaultLocation, title: "새싹")
            },
            okHandler:  { _ in
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
        )
    }
    
    private func showLocationFailedAlert() {
        showCancelAlert(title: "위치를 가져오는데 실패했습니다", message: nil, preferredStyle: .alert, cancelTitle: "확인", okTitle: nil)
    }
    
    private func checkDeviceLocationAuthorization() {
        // main 스레드에서는 불가능
        DispatchQueue.global().async { [weak self] in
            guard let self else {return}
            if CLLocationManager.locationServicesEnabled() {
                // 현재 위치권한 상태를 가져옴
                let authorization: CLAuthorizationStatus
                
                if #available(iOS 14.0, *) {
                    authorization = locationManager.authorizationStatus
                } else {
                    authorization = CLLocationManager.authorizationStatus()
                }
                print(authorization)
                
                DispatchQueue.main.async {
                    self.checkCurrentLocationAuthorization(status: authorization)
                }
            } else {
                DispatchQueue.main.async {
                    self.showLocationFailedAlert()
                }
            }
        }
    }
    
    private func checkCurrentLocationAuthorization(status: CLAuthorizationStatus) {
        print("check", terminator: " ")
        
        switch status {
        // 최초 상태
        case .notDetermined:
            // 정확도 정하고
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            // 얼럿 띄우기
            // info.plist에 설정이 되어있어야함
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("restricted")
            changeStatusLabel(status: .invalid)
        case .denied:
            print("denied")
            changeStatusLabel(status: .invalid)
            self.showLocationSettingAlert()
        case .authorizedAlways:
            print("authorizedAlways")
        case .authorizedWhenInUse:
            print("authorizedWhenInUse")
            // didUpdateLocations 멧드 실행
            changeStatusLabel(status: .valid)
            locationManager.startUpdatingLocation()
        case .authorized:
            print("authorized")
        @unknown default: // 권한이 더 생길것에 대한 가능성 대비
            print("unkown")
        }
    }

}

extension MapViewController: CLLocationManagerDelegate {
    // 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("===", locations)
        if let coordinate = locations.last?.coordinate {
            print(coordinate)
            setRegionAndAnnotation(center: coordinate, title: "Home")
        }
        manager.stopUpdatingLocation()
    }
    // 사용자의 위치를 가지고 오지 못한 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        showLocationFailedAlert()
    }
    
    // 사용자의 권한 상태가 바뀔 때를 알려줌
    // 하지만 vc에서는 권한이 바뀌지 않아도 호출해주는데, nav에서는 호출 안해줌
    // 거부했다가 설정에서 변경을 했거나, 혹은 notDetermined상태에서 허용을 했거나
    // 허용해서 위치를 가지고 오는 도중에, 설정에서 거부를 하고 앱으로 다시 돌아올 때 등
    // iOS14이상
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkDeviceLocationAuthorization()
    }
    // 사용자의 권한 상태가 바뀔때를 알려줌
    // ios14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        print(#function)
    }
    
    func mapView(_ mapView: MKMapView, didSelect annotation: MKAnnotation) {
        print(#function)
    }

}

