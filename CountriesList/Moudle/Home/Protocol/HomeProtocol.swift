//
//  HomeProtocol.swift
//  CountriesList
//
//  Created by mozhgan on 2/5/21.
//

import Foundation
import UIKit

protocol PTRHomeProtocol: class {
    static func createModule() -> UIViewController
    func choose(callback: @escaping CountriesViewController.SelectedCountriesCallback)
}
protocol PTVHomeProtocol: NSObjectProtocol {
    func show(countries: [Country])
}
protocol VTPHomeProtocol: class {
    var view: PTVHomeProtocol? {get set}
    var router: PTRHomeProtocol? {get set}
    func choose()
}
