//
//  ReserveDateView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/18/25.
//

import UIKit

import SnapKit
import Then

final class ReserveDateView: UIView {

    // MARK: - Properties

    let reserveDate: Date

    var isSelected: Bool = false {
        didSet {
            backgroundColor = isSelected ? .nbcSub : .white
            self.layer.borderColor = isSelected ? UIColor.nbcMain.cgColor : UIColor.gray2.cgColor
        }
    }

    // MARK: - UI Components

    private let dayOfWeekLabel = UILabel().then {
        $0.text = "요일"
        $0.font = .systemFont(ofSize: 10)
        $0.textColor = .black
    }

    private let dayLabel = UILabel().then {
        $0.text = "00일"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .black
    }

    // MARK: - Initializers

    init(date: Date) {
        let calendar = Calendar.current
        let dayComponents = calendar.dateComponents([.day], from: date)
        let todayComponents = calendar.dateComponents([.day], from: Date())

        if dayComponents == todayComponents {
            dayOfWeekLabel.text = "오늘"
            dayOfWeekLabel.textColor = .nbcMain
        } else if dayComponents.day == (todayComponents.day ?? 0) + 1 {
            dayOfWeekLabel.text = "내일"
            dayOfWeekLabel.textColor = .nbcMain
        } else {
            dayOfWeekLabel.text = date.toDayofWeekString()
        }

        dayLabel.text = String(dayComponents.day ?? 0)
        self.reserveDate = date
        super.init(frame: .zero)
        setUI()

        self.isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 48, height: 49)
    }

    // MARK: - Setup Methods

    private func setUI() {
        self.layer.borderColor = UIColor.gray2.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10

        [dayOfWeekLabel, dayLabel].forEach {
            self.addSubview($0)
        }

        dayOfWeekLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.centerX.equalToSuperview()
        }

        dayLabel.snp.makeConstraints {
            $0.top.equalTo(dayOfWeekLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
    }
}
