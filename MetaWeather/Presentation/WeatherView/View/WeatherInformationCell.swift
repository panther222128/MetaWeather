//
//  WeatherInformationCell.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/04/28.
//

import UIKit

class WeatherInformationCell: UITableViewCell {
    
    @IBOutlet weak var locationNameContainerView: UIView!
    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var todayWeatherInformationView: WeatherInformationView!
    @IBOutlet weak var tomorrowWeatherInformationView: WeatherInformationView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(with locationWeathers: LocationWeathers) {
        self.drawBorderLine()
        self.applyFontToLabel()
        
        self.locationNameLabel.text = locationWeathers.title

        guard let todayWeather = locationWeathers.locationWeathers.first else { return }
        let tomorrowWeather = locationWeathers.locationWeathers[1]
        
        // MARK: - 오늘 날씨 정보 요소들 값을 뷰에서 나타나도록
        self.todayWeatherInformationView.weatherStateNameLabel.text = "\(todayWeather.weatherStateName)"
        let todayWeatherIntTemperature: Int = Int(todayWeather.temperature)
        self.todayWeatherInformationView.temperatureLabel.text = "\(todayWeatherIntTemperature)°C"
        self.todayWeatherInformationView.humidityLabel.text = "\(todayWeather.humidity)%"
        let todayWeatherImageUrlString = ImageHotlink.hotlink + todayWeather.weatherStateAbbreviation + ".png"
        self.todayWeatherInformationView.weatherStateImageView.loadImageUsingUrlString(urlString: todayWeatherImageUrlString)
        
        // MARK: - 내일 날씨 정보 요소들 값을 뷰에서 나타나도록
        self.tomorrowWeatherInformationView.weatherStateNameLabel.text = "\(tomorrowWeather.weatherStateName)"
        let tomorrowWeatherIntTemperature: Int = Int(tomorrowWeather.temperature)
        self.tomorrowWeatherInformationView.temperatureLabel.text = "\(tomorrowWeatherIntTemperature)°C"
        self.tomorrowWeatherInformationView.humidityLabel.text = "\(tomorrowWeather.humidity)%"
        let tomorrowWeatherImageUrlString = ImageHotlink.hotlink + tomorrowWeather.weatherStateAbbreviation + ".png"
        self.tomorrowWeatherInformationView.weatherStateImageView.loadImageUsingUrlString(urlString: tomorrowWeatherImageUrlString)
    }
    
}

extension WeatherInformationCell {
    
    private func drawBorderLine() {
        self.locationNameContainerView.addLeftBorder(with: Values.borderColor, with: Values.borderWidth)
        self.locationNameContainerView.addBottomBorder(with: Values.borderColor, with: Values.borderWidth)
        self.locationNameContainerView.addRightBorder(with: Values.borderColor, with: Values.borderWidth)
    }
    
    private func applyFontToLabel() {
        self.locationNameLabel.font = UIFont(name: Values.defaultFont, size: CGFloat(Values.weatherInfoElementFontSize))
    }
    
}

