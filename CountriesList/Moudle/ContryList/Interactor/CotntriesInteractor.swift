//
//  File.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import Foundation
import Alamofire

public class CotntriesInteractor<T>: CountryPresentorToInteractorProtocol {
    deinit {
        print("Deinit ::\(self)")
        requests.forEach({$0.cancel()})
    }
    weak var result: InteractorToPresenterProtocol?
    private var requests: [MoyaCancellablePromise<T>]  = []
    private var countries: [Country] = [] {
        didSet {
            self.result?.fetched(countries: countries)
        }
    }

    private var filteredCountries: [Country] = [] {
        didSet {
            self.result?.fetched(countries: filteredCountries)
        }
    }
    var selectedCountries: [Country] {
        return self.countries.filter({$0.isSelected})
    }

    public func fetchCotntries() {
        let request = ContryService().getRegionalBloc(Region.EU)
        request.promise.done { [weak self](countries) in
            guard let strongSelf = self else { return }
            strongSelf.countries = countries
            strongSelf.result?.fetched(countries: countries)
        }.catch { [weak self] (error) in
            guard let strongSelf = self else { return }
            strongSelf.result?.fetched(error: error)
        }.finally {
            print("Done!!!")
        }
    }

    func filter(term: String) {
        self.filteredCountries = self.countries.filter({($0.name ?? "").contains(term) || ($0.nativeName ?? "").contains(term)})
    }

    func filterCanceledByUser() {
        self.result?.fetched(countries: countries)
    }
    func toggle(country: Country) {
        country.toggle()
    }
}
