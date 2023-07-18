//
//  WeatherScreen.swift
//  ClimaViewCode
//
//  Created by Matheus Sousa on 13/07/23.
//

import Foundation
import UIKit

protocol WeatherScreenDelegate: AnyObject {
    func tappedLocationButton()
    func tappedSearchButton()
}

class WeatherScreen: UIView {
    
    private weak var delegate: WeatherScreenDelegate?
    
    public func delegate(delegate: WeatherScreenDelegate?){
        self.delegate = delegate
    }
    
    lazy var backgroundImageView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "background")
        image.contentMode = .scaleAspectFill
        
        return image
    }()
    

    lazy var locationButton: UIButton = {
        let button = UIButton()
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 40, weight: .bold, scale: .default)
        let imageIcon = UIImage(systemName: "location.circle.fill", withConfiguration: imageConfig)?.withTintColor(.whiteDark, renderingMode: .alwaysOriginal)
        
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(imageIcon, for: .normal)
        button.addTarget(self, action: #selector(tappedLocationButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var searchButton: UIButton = {
       let button = UIButton()
        
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 40, weight: .regular, scale: .default)
        let imageIcon = UIImage(systemName: "magnifyingglass", withConfiguration: imageConfig)?.withTintColor(.whiteDark, renderingMode: .alwaysOriginal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(imageIcon, for: .normal)
        button.addTarget(self, action: #selector(tappedSearchButton), for: .touchUpInside)
        
        return button
    }()
    
    lazy var searchTextField: UITextField = {
        let tf = UITextField()
        
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = UIColor.systemFill
        tf.textColor = .systemGray
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 6
        tf.textAlignment = .right
        tf.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        tf.font = UIFont.systemFont(ofSize: 22)
        tf.textColor = .whiteDark
        
        return tf
    }()
    
    lazy var headerView: UIStackView = {
        let stack = UIStackView()
       
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.addArrangedSubview(locationButton)
        stack.addArrangedSubview(searchTextField)
        stack.addArrangedSubview(searchButton)
        stack.alignment = .center
        stack.spacing = 12
        stack.distribution = .fillProportionally
        
        return stack
    }()
    
    lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        let imageConfig = UIImage.SymbolConfiguration(
            pointSize: 85, weight: .regular, scale: .default)
        let imageIcon = UIImage(systemName: "sun.max", withConfiguration: imageConfig)?.withTintColor(.whiteDark, renderingMode: .alwaysOriginal)
        image.image = imageIcon
        
        return image
    }()
    
    lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "21"
        label.textColor = .whiteDark
        label.font = UIFont.boldSystemFont(ofSize: 80)
        
        return label
    }()
    
    lazy var temperatureSymbolLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "°"
        label.textColor = .whiteDark
        label.font = UIFont.systemFont(ofSize: 80)
        
        return label
    }()
    
    lazy var temperatureTypeLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "C"
        label.textColor = .whiteDark
        label.font = UIFont.systemFont(ofSize: 80)
        
        return label
    }()
    
    lazy var temperatureStackView: UIStackView = {
        let stack = UIStackView()
       
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .fill
        stack.distribution = .fill
        stack.addArrangedSubview(temperatureLabel)
        stack.addArrangedSubview(temperatureSymbolLabel)
        stack.addArrangedSubview(temperatureTypeLabel)
        
        return stack
    }()
    
    lazy var cityNameLabel: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "London"
        label.textColor = .whiteDark
        label.font = UIFont.systemFont(ofSize: 28)
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(backgroundImageView)
        self.addSubview(headerView)
        self.addSubview(iconImageView)
        self.addSubview(temperatureStackView)
        self.addSubview(cityNameLabel)
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tappedLocationButton(){
        self.delegate?.tappedLocationButton()
    }
    
    @objc func tappedSearchButton(){
        self.delegate?.tappedSearchButton()
    }
    
    func configConstraints(){
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            self.headerView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.headerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.headerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20
                                                    ),
            self.locationButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            self.locationButton.widthAnchor.constraint(equalToConstant: 40),
            self.locationButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.searchButton.widthAnchor.constraint(equalToConstant: 40),
            self.searchButton.heightAnchor.constraint(equalToConstant: 40),
            
            self.searchTextField.heightAnchor.constraint(equalToConstant: 40),
            
            self.iconImageView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor, constant: 20),
            self.iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.temperatureStackView.topAnchor.constraint(equalTo: self.iconImageView.bottomAnchor, constant: 12),
            self.temperatureStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            
            self.cityNameLabel.topAnchor.constraint(equalTo: self.temperatureStackView.bottomAnchor, constant: 12),
            self.cityNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }
}
