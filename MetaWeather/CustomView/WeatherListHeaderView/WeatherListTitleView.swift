//
//  WeatherListSectionHeader.swift
//  MetaWeather
//
//  Created by Jun Ho JANG on 2022/05/01.
//

import UIKit

class WeatherListTitleView: UIView {
    
    @IBOutlet weak var locationTitleContainerView: UIView!
    @IBOutlet weak var todayTitleContainerView: UIView!
    @IBOutlet weak var tomorrowTitleContainerView: UIView!
    
    @IBOutlet weak var locationTitleLabel: UILabel!
    @IBOutlet weak var todayTitleLabel: UILabel!
    @IBOutlet weak var tomorrowTitleLabel: UILabel!

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
    }
    
    func loadViewFromXib(){
        let viewFromXib = Bundle.main.loadNibNamed("WeatherListTitleView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
}

extension WeatherListTitleView {
    
    private func drawBorderLine() {
        self.locationTitleContainerView.addTopBorder(with: Values.borderColor, with: Values.borderWidth)
        self.locationTitleContainerView.addLeftBorder(with: Values.borderColor, with: Values.borderWidth)
        self.locationTitleContainerView.addRightBorder(with: Values.borderColor, with: Values.borderWidth)
        self.locationTitleContainerView.addBottomBorder(with: Values.borderColor, with: Values.borderWidth)
        
        self.todayTitleContainerView.addTopBorder(with: Values.borderColor, with: Values.borderWidth)
        self.todayTitleContainerView.addRightBorder(with: Values.borderColor, with: Values.borderWidth)
        self.todayTitleContainerView.addBottomBorder(with: Values.borderColor, with: Values.borderWidth)
        
        self.tomorrowTitleContainerView.addTopBorder(with: Values.borderColor, with: Values.borderWidth)
        self.tomorrowTitleContainerView.addBottomBorder(with: Values.borderColor, with: Values.borderWidth)
        self.tomorrowTitleContainerView.addRightBorder(with: Values.borderColor, with: Values.borderWidth)
    }
    
    private func applyFontToLabel() {
        self.locationTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Values.weatherListHeaderTitleFontSize))
        self.todayTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Values.weatherListHeaderTitleFontSize))
        self.tomorrowTitleLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(Values.weatherListHeaderTitleFontSize))
    }
    
}
