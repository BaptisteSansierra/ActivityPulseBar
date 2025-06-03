//
//  ViewController.swift
//  ActivityPulseBar
//
//  Created by bat on 3/6/25.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - private vars
    private var apb: ActivityPulseBar!
    private var processing: Bool = false {
        didSet {
            guard let _ = apb else { return }
            guard oldValue != processing else { return }
            if processing {
                apb.startAnimating()
                UIView.animate(withDuration: 0.3) {
                    self.apb.alpha = 1
                }
            } else {
                apb.stopAnimating()
                UIView.animate(withDuration: 0.3) {
                    self.apb.alpha = 0
                }
            }
        }
    }

    // MARK: - IBOutlets
    @IBOutlet weak var navBarBgView: UIView!
    @IBOutlet weak var navBarView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var startBt: UIButton!
    
    // MARK: - IBActions
    @IBAction func didPressStartBt(_ sender: Any) {
        guard processing else {
            start()
            return
        }
        stop()
    }
    
    // MARK: - override
    override func viewDidLoad() {
        super.viewDidLoad()
        navBarBgView.backgroundColor = UIColor.dynamicColor(light: .white, dark: .black)
        titleLb.textColor = UIColor.dynamicColor(light: .black, dark: .white)
        addActivityPulseBar()
    }

    // MARK: - private
    private func addActivityPulseBar() {
        apb = ActivityPulseBar()
        apb.alpha = 0
        view.addSubview(apb)
        apb.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: apb!, attribute: .trailing, relatedBy: .equal,
                                              toItem: view, attribute: .trailing, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: apb!, attribute: .leading, relatedBy: .equal,
                                              toItem: view, attribute: .leading, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: apb!, attribute: .height, relatedBy: .equal,
                                              toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 4))
        view.addConstraint(NSLayoutConstraint(item: apb!, attribute: .top, relatedBy: .equal,
                                              toItem: navBarView, attribute: .bottom, multiplier: 1, constant: -1))
    }
    
    private func start() {
        processing = true
        startBt.setTitle("Stop task", for: .normal)
    }

    private func stop() {
        processing = false
        startBt.setTitle("Start task", for: .normal)
    }
}

