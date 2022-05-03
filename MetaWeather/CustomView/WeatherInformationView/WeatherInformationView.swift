//
//  WeatherInformationView.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/05/01.
//

import UIKit

class WeatherInformationView: UIView {

    @IBOutlet weak var weatherStateImageView: CustomImageView!
    @IBOutlet weak var weatherStateNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.loadViewFromXib()
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.loadViewFromXib()
        self.configure()
    }
    
    func configure() {
        self.drawBorderLine()
        self.applyFontToLabel()
        self.applyTextColorToLabel()
    }
    
    func loadViewFromXib(){
        let viewFromXib = Bundle.main.loadNibNamed("WeatherInformationView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }

}

extension WeatherInformationView {
    
    private func drawBorderLine() {
        self.addBottomBorder(with: Values.borderColor, with: Values.borderWidth)
        self.addRightBorder(with: Values.borderColor, with: Values.borderWidth)
    }
    
    private func applyFontToLabel() {
        self.weatherStateNameLabel.font = UIFont(name: Values.defaultFont, size: CGFloat(Values.weatherInfoElementFontSize))
        self.temperatureLabel.font = UIFont(name: Values.defaultFont, size: CGFloat(Values.weatherInfoElementFontSize))
        self.humidityLabel.font = UIFont(name: Values.defaultFont, size: CGFloat(Values.weatherInfoElementFontSize))
    }
    
    private func applyTextColorToLabel() {
        self.temperatureLabel.textColor = Values.temperatureTextColor
    }
    
}
