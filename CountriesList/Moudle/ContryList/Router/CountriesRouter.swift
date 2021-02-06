//
//  File.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit

final class CountriesRouter: PTRCountryProtocol {

    weak var presentingViewController: UIViewController?

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    static func createModule(callback: @escaping CountriesViewController.SelectedCountriesCallback) -> UIViewController {
        let view = CountriesViewController(callback: callback)
        let presenter: VTPCountriesProtocol & ITPCountryProtocol = CountriesPresenter()
        let interactor: PTICountryProtocol = CotntriesInteractor<Country>()
        let router: PTRCountryProtocol = CountriesRouter(presentingViewController: view)
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.result = presenter
        return view
    }
}
