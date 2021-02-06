//
//  HomeViewController.swift
//  CountriesList
//
//  Created by mozhgan on 2/5/21.
//

import UIKit

class HomeViewController: UIViewController {
    var presenter: VTPHomeProtocol?

    @IBOutlet weak var selectedCountriesView: UITextView? {
        didSet {
            selectedCountriesView?.text = ""
        }
    }
    @IBOutlet weak var chooseBtn: CustomButton? {
        didSet {
            chooseBtn?.setTitle(LocalizeStrings.Home.choose, for: UIControl.State.normal)
        }
    }
    
    @IBOutlet weak var captionLbl: TitleLabel? {
        didSet {
            captionLbl?.text = LocalizeStrings.Home.caption
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = LocalizeStrings.Home.title
    }
}
extension HomeViewController {
    @IBAction func choose(sender: UIButton) {
        self.presenter?.choose()
    }
}
extension HomeViewController: PTVHomeProtocol {
    func show(countries: [Country]) {
        self.selectedCountriesView?.text = countries.map({$0.name ?? ""}).joined(separator: "\n")
    }
}
