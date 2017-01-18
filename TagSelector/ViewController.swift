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

class ViewController: UIViewController, TranslateControllerDelegate {
    
    var viewController:UIViewController?
    private var skillViewControllerHeight: CGFloat!
    
    @IBOutlet weak var textTagCollectionView: TTGTextTagCollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skillViewControllerHeight = UIScreen.main.bounds.height - UIApplication.shared.statusBarFrame.height

        
        textTagCollectionView.addTags(["this", "is", "text"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func runTagSelector(_ sender: Any) {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TagSelectorViewConroller") as UIViewController
        (viewController as! TagSelectorViewConroller).translateControllerDelegate = self
        
        customPresentViewController(getPresentr(height: Float(skillViewControllerHeight)), viewController: viewController!, animated: true, completion: nil)
    }
    
    func translate() {
        debugPrint("will translate")
        
        
        debugPrint(viewController?.view.frame.debugDescription)
        viewController?.view.frame = CGRect(x: 0.0, y: 25.0, width: 414.0, height: skillViewControllerHeight)
        debugPrint(viewController?.view.frame.debugDescription)  //Optional("(0.0, 252.0, 414.0, 600.0)")
        
        
        
//        viewController?.view.transform = CGAffineTransform( translationX: 0.0, y: 200.0 )
//        
//        UIView.animate(withDuration: 0.5, delay: 1.2, options: [], animations: {
//            self.viewController?.view.frame = CGRect(x: -90, y: -90, width: 100, height: 100)
//        }, completion: nil)
        
//        customPresentViewController(presenter2, viewController: viewController, animated: true, completion: nil)
    }
    
    func getPresentr(height: Float) -> Presentr {
        let width = ModalSize.full
        let height = ModalSize.custom(size: height)
        let center = ModalCenterPosition.bottomCenter
        
        let presenter = Presentr(presentationType: PresentationType.custom(width: width, height: height, center: center))
        presenter.transitionType = .coverHorizontalFromRight // Optional
        presenter.transitionType = .coverHorizontalFromLeft
        presenter.transitionType = .crossDissolve
        presenter.dismissAnimated = true
        return presenter

    }
    
}

