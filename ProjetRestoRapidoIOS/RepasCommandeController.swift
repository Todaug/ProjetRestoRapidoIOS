//
//  RepasCommandeController.swift
//  ProjetRestoRapidoIOS
//
//  Created by Francis on 2016-03-09.
//  Copyright © 2016 Device. All rights reserved.
//

import Foundation
import UIKit

class RepasCommandeController :  UIViewController , UIPageViewControllerDataSource {
    
    // MARK: - Variables
    private var pageViewController: UIPageViewController?
    
    // Initialize it right away here
    
    private let contentImages : [RepasCommande] = [
        
        /*RepasCommande( _Id: 0, _Nom : "Pizza",  _Image : UIImage(), _Prix : 50.0 , _Description : "Merveille ", _boBle : false, _boLait : false, _boOeuf : false, _boArachide : false, _boSoja : false, _boFruitCoque : false, _boPoisson : false, _boSesame : false, _boCrustace : false, _boMollusque : false, _commentaire : ""),
        
        RepasCommande( _Id: 0, _Nom : "Spag",  _Image : UIImage(), _Prix : 50.0 , _Description : "Merveille ", _boBle : false, _boLait : false, _boOeuf : false, _boArachide : false, _boSoja : false, _boFruitCoque : false, _boPoisson : false, _boSesame : false, _boCrustace : false, _boMollusque : false, _commentaire : ""),
        
        RepasCommande( _Id: 0, _Nom : "Poutine",  _Image : UIImage(), _Prix : 50.0 , _Description : "Merveille ", _boBle : false, _boLait : false, _boOeuf : false, _boArachide : false, _boSoja : false, _boFruitCoque : false, _boPoisson : false, _boSesame : false, _boCrustace : false, _boMollusque : false, _commentaire : "")*/
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createPageViewController()
        setupPageControl()
    }
    
    private func createPageViewController() {
        
        let pageController = self.storyboard!.instantiateViewControllerWithIdentifier("PageController") as! UIPageViewController
        
        pageController.dataSource = self
        
        if contentImages.count > 0 {
            let firstController = getItemController(0)!
            let startingViewControllers: NSArray = [firstController]
            pageController.setViewControllers((startingViewControllers as! [UIViewController]), direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
        }
        
        pageViewController = pageController
        addChildViewController(pageViewController!)
        self.view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
    }
    
    private func setupPageControl() {
        let appearance = UIPageControl.appearance()
        appearance.pageIndicatorTintColor = UIColor.grayColor()
        appearance.currentPageIndicatorTintColor = UIColor.whiteColor()
        appearance.backgroundColor = UIColor.darkGrayColor()
    }
    
    // MARK: - UIPageViewControllerDataSource
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex > 0 {
            return getItemController(itemController.itemIndex-1)
        }
        
        return nil
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        
        let itemController = viewController as! PageItemController
        
        if itemController.itemIndex+1 < contentImages.count {
            return getItemController(itemController.itemIndex+1)
        }
        
        return nil
    }
    
    //creer la item contenant linfo du repas
    private func getItemController(itemIndex: Int) -> PageItemController? {
        
        if itemIndex < contentImages.count {
            let pageItemController = self.storyboard!.instantiateViewControllerWithIdentifier("ItemController") as! PageItemController
            pageItemController.itemIndex = itemIndex
            pageItemController.Repas = contentImages[itemIndex]
            return pageItemController
        }
        
        return nil
    }
    
    // MARK: - Page Indicator
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return contentImages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}