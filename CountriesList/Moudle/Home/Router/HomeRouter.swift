//
//  HomeRouter.swift
//  CountriesList
//
//  Created by mozhgan on 2/5/21.
//

import Foundation
import UIKit

final class HomeRouter: PTRHomeProtocol {

    let presentingViewController: UIViewController

    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    func choose(callback: @escaping CountriesViewController.SelectedCountriesCallback) {
        let view = CountriesRouter.createModule(callback: callback)
        self.presentingViewController.present(view, animated: true, completion: nil)
    }

    class func createModule() -> UIViewController {
        let view = HomeViewController(nibName: "\(HomeViewController.self)", bundle: nil)//CountriesViewController()
        let presenter: VTPHomeProtocol = HomePresenter()
        let router: PTRHomeProtocol = HomeRouter(presentingViewController: view)
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        return view
    }

}
