//
//  CountryCell.swift
//  Countries
//
//  Created by mozhgan on 3/2/2020.
//  Copyright © 2019 mozhgan. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import SDWebImageSVGKitPlugin

protocol CountryCellDelegate: class {
    func toggle(cell: CountryCell)
}

final class CountryCell: UITableViewCell {
    weak var delegate: CountryCellDelegate?
    private let cardView: UIView = {
        let vw = UIView()
        vw.clipsToBounds = true
        vw.layer.cornerRadius = 10
        return vw
    }()

    private let descriptionLabel: TitleLabel = {
        let lbl = TitleLabel()
        lbl.textAlignment = .left
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()

    private let imgView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.sd_imageIndicator = SDWebImageActivityIndicator.white
        img.sd_imageTransition = .flipFromLeft
        img.layer.cornerRadius = Layout.defaultCornerRadius
        return img
    }()

    private let addBtn: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.custom)
        btn.setTitle(LocalizeStrings.CountryListView.add, for: UIControl.State.normal)
        btn.setTitle(LocalizeStrings.CountryListView.added, for: UIControl.State.selected)
        btn.contentMode = .scaleToFill
        btn.clipsToBounds = true
        btn.layer.masksToBounds = true
        btn.layer.cornerRadius = Layout.defaultCornerRadius
        btn.backgroundColor = UIColor.gray
        return btn
    }()

    // MARK: - Intializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CountryCell {
    @objc func toggle(sender: UIButton) {
        self.delegate?.toggle(cell: self)
    }
}
extension CountryCell {
    func configCell(country: Country, delegate: CountryCellDelegate) {
        self.delegate = delegate
        self.descriptionLabel.text = (country.name ?? "") + "/" + (country.nativeName ?? "")
        self.addBtn.isSelected = country.isSelected
        self.imgView.backgroundColor = UIColor.random
        guard let url = URL(string: country.flag ?? "") else { return }
        imgView.sd_setImage(with: url, placeholderImage: nil, options: [.retryFailed], context: [.imageThumbnailPixelSize: Layout.flagImageSize])
    }

    private func setup() {
        addBtn.addTarget(self, action: #selector(toggle(sender:)), for: .touchUpInside)
        SDImageCodersManager.shared.addCoder(SDImageSVGKCoder.shared)
        self.contentView.addSubview(self.cardView)
        self.cardView.addSubview(self.imgView)
        self.cardView.addSubview(self.descriptionLabel)
        self.cardView.addSubview(self.addBtn)

        self.cardView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Layout.defaultMargin)
            make.bottom.equalToSuperview().offset(-Layout.defaultMargin)
            make.height.greaterThanOrEqualTo(self.imgView).offset(Layout.defaultMargin * 4).priority(.required)
            make.leading.equalTo(self.contentView.safeAreaLayoutGuide.snp.leading).offset(Layout.defaultMargin)
            make.trailing.equalTo(self.contentView.safeAreaLayoutGuide.snp.trailing).offset(-Layout.defaultMargin)
        }

        self.imgView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(Layout.defaultMargin * 2)
            make.size.equalTo(Layout.flagImageSize)
            make.leading.equalTo(self.cardView.safeAreaLayoutGuide.snp.leading).offset(Layout.defaultMargin)
        }

        self.descriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.imgView.snp_trailingMargin).offset(Layout.defaultMargin * 2)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(self.cardView.safeAreaLayoutGuide.snp.trailing).offset(-Layout.defaultMargin)
        }

        self.addBtn.snp.makeConstraints { (make) in
            make.trailingMargin.equalTo(self.descriptionLabel.snp_trailingMargin)
            make.centerY.equalToSuperview()
        }

    }
}
