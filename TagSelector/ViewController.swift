//
//  ViewController.swift
//  TagSelector
//
//  Created by minhazur rahman on 1/11/17.
//  Copyright © 2017 minhazur rahman. All rights reserved.
//

import UIKit
import Presentr
import TTGTagCollectionView

class ViewController: UIViewController, ScaleTagSelectorControllerDelegate {
    
    var tagSelectorVC: UIViewController?
    var modalViewPadding: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let navBarHeight = self.navigationController!.navigationBar.frame.height
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        modalViewPadding = navBarHeight + statusBarHeight
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func runTagSelector(_ sender: Any) {
        tagSelectorVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TagSelectorViewConroller") as UIViewController
        (tagSelectorVC as! TagSelectorViewConroller).scaleDelegate = self
        
        customPresentViewController(getPresentr(), viewController: tagSelectorVC!, animated: true, completion: nil)
    }
    
    func scale() {
        debugPrint("will scale presented view....")
        
        UIView.animate(withDuration: 0.2, delay: 0.01, options: [], animations: {
            self.tagSelectorVC?.view.frame = CGRect(x: 0.0, y: self.modalViewPadding, width: self.view.frame.width, height: self.view.frame.height - self.modalViewPadding)
        }, completion: nil)
    }
    
    func getPresentr() -> Presentr {
        let width = ModalSize.full
        let height = ModalSize.custom(size: Float(self.view.frame.height - modalViewPadding))
        let center = ModalCenterPosition.bottomCenter
        
        let presenter = Presentr(presentationType: PresentationType.custom(width: width, height: height, center: center))
        presenter.transitionType = .coverHorizontalFromRight // Optional
        presenter.transitionType = .coverHorizontalFromLeft
        presenter.transitionType = .crossDissolve
        presenter.dismissAnimated = true
        return presenter

    }
    
}

