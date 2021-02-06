//
//  HomePresenter.swift
//  CountriesList
//
//  Created by mozhgan on 2/5/21.
//

import Foundation
final class HomePresenter: VTPHomeProtocol {
    var router: PTRHomeProtocol?

    weak var view: PTVHomeProtocol?

    func choose() {
        router?.choose(callback: { [weak self] (countries: [Country]) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.view?.show(countries: countries)
        })
    }

}
