//
//  ActivityPulseBar.swift
//  ActivityPulseBar
//
//  Created by Baptiste Sansierra on 03/06/2025.
//  Copyright © 2025 Baptiste Sansierra. All rights reserved.
//

import UIKit

/*
  Draw a bar moving from left to right
  Bar width is animated from barWMin to barWMax
  Bar speed up until speMax, then speed down until speMin
  The bar is drawn from x1=-margin to x2=frameWidth + margin
 */
public class ActivityPulseBar: UIView {

    // MARK: - public vars
    public var color: UIColor = UIColor.dynamicColor(light: "#A8A8A8", dark: "#515151")
    public var bgColor: UIColor = UIColor.dynamicColor(light: "#EEEEEE", dark: "#ABABAB") {
        didSet {
            backgroundColor = bgColor
        }
    }
    // Minimum bar width
    private let barWMin: CGFloat = 0.3
    // Maximum bar width
    private let barWMax: CGFloat = 0.75
    // Animation horizontal margin
    private var xMargin: CGFloat = 0.33
    // Increasing / decreasing width step
    private var widthStep: CGFloat = 0.001
    // Speed at t0
    public var spe0X: CGFloat = 500
    // Speed max
    public var speMax: CGFloat = 1200
    // Speed min
    public var speMin: CGFloat = 300
    // Acceleration
    public var accX: CGFloat = 600

    // MARK: - private vars
    private var timer: Timer?
    // Speeding up phase indicator
    private var speedUp = true
    // Increasing size phase indicator
    private var increasing = true
    // Timer interval
    private var timeStep = 0.01
    // Position at t0
    private var pos0X: CGFloat = 0
    // Current position
    private var posX: CGFloat = 0
    // Current bar width
    private var barW: CGFloat = 0.4
    // Current speed
    private var speX: CGFloat = 0

    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = bgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - override
    override public func draw(_ rect: CGRect) {
        let margin = xMargin * frameWidth
        let totalWidth = frameWidth + 2 * margin
        let q = (posX + margin) / totalWidth
        let r = CGFloat(Int(q)) * totalWidth
        let pos = posX - r

        let width = barW * frameWidth
        let rect = CGRect(x: pos - width * 0.5 , y: 0, width: width, height: frameHeight)
        color.setFill()
        UIRectFill(rect)
        // The part of the rect out should be visible on the other side of the screen
        if pos + width * 0.5 > frameWidth + margin {
            let remainW = pos + width * 0.5 - ( frameWidth + margin )
            let remainRect = CGRect(x: -margin, y: 0, width: remainW, height: frameHeight)
            UIRectFill(remainRect)
        } else if pos - width * 0.5 < -margin {
            let remainW =  -margin - ( pos - width * 0.5 )
            let remainRect = CGRect(x: frameWidth + margin - remainW, y: 0, width: remainW, height: frameHeight)
            UIRectFill(remainRect)
        }
    }

    // MARK: - public
    public func startAnimating() {
        if let timer = timer {
            timer.invalidate()
        }
        speX = spe0X
        posX = pos0X
        timer = Timer.scheduledTimer(withTimeInterval: timeStep, repeats: true, block: { [weak self] _ in
            self?.increment()
            DispatchQueue.main.async {
                self?.setNeedsDisplay()
            }
        })
    }

    public func stopAnimating() {
        timer?.invalidate()
    }

    // MARK: - private
    private func increment() {
        // Increase / decrease bar width
        if increasing {
            barW += widthStep
            if barW >= barWMax {
                increasing = false
            }
        } else {
            barW -= widthStep
            if barW <= barWMin {
                increasing = true
            }
        }
        // Update speed & position
        if speedUp {
            speX += CGFloat(timeStep) * accX
        } else {
            speX -= CGFloat(timeStep) * accX
        }
        if speX > speMax {
            speedUp = false
        } else if speX < speMin {
            speedUp = true
        }
        posX += CGFloat(timeStep) * speX
    }
}
