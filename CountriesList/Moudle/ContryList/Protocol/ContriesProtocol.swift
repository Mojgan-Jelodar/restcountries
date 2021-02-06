//
//  CountriesProtocol.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation
import UIKit

protocol PTVCountriesProtocol: NSObjectProtocol {
    func refresh()
    func show(error: Error)
    func stopLoading()
    func reload(at indexPath: IndexPath)
}

protocol InteractorToPresenterProtocol: class {
      func fetched(countries: [Country])
      func fetched(error: Error)

}

protocol CountryPresentorToInteractorProtocol: class {
    var result: InteractorToPresenterProtocol? {get set}
    var selectedCountries: [Country] { get }
    func fetchCotntries()
    func filter(term: String)
    func toggle(country: Country)
    func filterCanceledByUser()
}

protocol VTPCountriesProtocol: class {
    var view: PTVCountriesProtocol? {get set}
    var interactor: CountryPresentorToInteractorProtocol? {get set}
    var router: CountryPresenterToRouterProtocol? {get set}
    var numberOfSection: Int { get }
    var numberOfRowsInSection: Int { get }
    var selectedCountries: [Country] { get }

    func fetch(index country: IndexPath) -> Country
    func fetchCountries()
    func filter(term: String)
    func filterCanceledByUser()
    func toggle(index country: IndexPath)
}

protocol CountryPresenterToRouterProtocol: class {
    static func createModule(callback: @escaping CountriesViewController.SelectedCountriesCallback) -> UIViewController
    func showDetail(Country: Country)
}
