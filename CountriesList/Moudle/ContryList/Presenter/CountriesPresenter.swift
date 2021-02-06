//
//  File.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//
import UIKit
import Alamofire
final class CountriesPresenter: VTPCountriesProtocol {
    weak var view: PTVCountriesProtocol?
    var interactor: PTICountryProtocol?
    var router: PTRCountryProtocol?

    private var list: [Country] = [] {
        didSet {
            self.view?.refresh()
        }
    }
    var numberOfSection: Int {
        return 1
    }

    var numberOfRowsInSection: Int {
        return self.list.count
    }
    var selectedCountries: [Country] {
        return Array( Set(interactor?.selectedCountries ?? []))
    }
}

extension CountriesPresenter {
    func fetch(index country: IndexPath) -> Country {
        return self.list[country.row]
    }

    internal func fetchCountries() {
        if Connectivity.isConnectedToInternet() {
            self.interactor?.fetchCotntries()
        } else {
            //self.view?.show(error: AFError.in)
        }
    }

    func filter(term: String) {
        self.interactor?.filter(term: term)
    }

    func filterCanceledByUser() {
        self.interactor?.filterCanceledByUser()
    }
    func toggle(index country: IndexPath) {
        let copy = self.fetch(index: country)
        self.interactor?.toggle(country: copy)
        view?.reload(at: country)
    }
}
extension CountriesPresenter: ITPCountryProtocol {
    func fetched(countries: [Country]) {
        self.view?.stopLoading()
        self.list = countries
    }

    func fetched(error: Error) {
        self.view?.stopLoading()
        self.view?.show(error: error)
    }

}
