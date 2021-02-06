//
//  File.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit

final class CountriesRouter: CountryPresenterToRouterProtocol {

    let presentingViewController: UIViewController

    required init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    func showDetail(Country: Country) {
    }
    class func createModule(callback: @escaping CountriesViewController.SelectedCountriesCallback) -> UIViewController {
        let view = CountriesViewController(callback: callback)
        let presenter: VTPCountriesProtocol & InteractorToPresenterProtocol = CountriesPresenter()
        let interactor: CountryPresentorToInteractorProtocol = CotntriesInteractor<Country>()
        let router: CountryPresenterToRouterProtocol = CountriesRouter(presentingViewController: view)
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.result = presenter
        return view
    }
}
