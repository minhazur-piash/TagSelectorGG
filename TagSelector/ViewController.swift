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
    
    @IBOutlet weak var textTagCollectionView: TTGTextTagCollectionView!
    let presenter: Presentr = {
        let width = ModalSize.full
        let height = ModalSize.custom(size: 600.0)
        let center = ModalCenterPosition.bottomCenter
        
        let presenter = Presentr(presentationType: PresentationType.custom(width: width, height: height, center: center))
        presenter.transitionType = .coverHorizontalFromRight // Optional
        presenter.transitionType = .coverHorizontalFromLeft
        presenter.transitionType = .crossDissolve
        presenter.dismissAnimated = true
        return presenter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textTagCollectionView.addTags(["this", "is", "text"])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func runTagSelector(_ sender: Any) {
        viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TagSelectorViewConroller") as UIViewController
        (viewController as! TagSelectorViewConroller).translateControllerDelegate = self
        customPresentViewController(presenter, viewController: viewController!, animated: true, completion: nil)
    }
    
    func translate() {
        debugPrint("will translate")
        
        
        
        
        
        
        
//        viewController?.view.transform = CGAffineTransform( translationX: 0.0, y: 200.0 )
//        
//        UIView.animate(withDuration: 0.5, delay: 1.2, options: [], animations: {
//            self.viewController?.view.frame = CGRect(x: -90, y: -90, width: 100, height: 100)
//        }, completion: nil)
        
//        customPresentViewController(presenter2, viewController: viewController, animated: true, completion: nil)
    }
    
}

