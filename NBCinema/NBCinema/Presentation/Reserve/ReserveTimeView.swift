//
//  ReserveTimeView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/18/25.
//

import UIKit

import SnapKit
import Then

final class ReserveTimeView: UIView {

    // MARK: - Properties

    let reserveTime: DateComponents

    var isSelected: Bool = false {
        didSet {
            backgroundColor = isSelected ? .nbcSub : .white
            self.layer.borderColor = isSelected ? UIColor.nbcMain.cgColor : UIColor.gray2.cgColor
        }
    }

    // MARK: - UI Components

    private let timeLabel = UILabel().then {
        $0.text = "00:00 ~ 00:00"
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray3
    }

    private let seatLabel = UILabel().then {
        let seatCount = "12"
        let totalCount = "/80석"
        let attributedString = NSMutableAttributedString(string: seatCount + totalCount)

        $0.textColor = .gray3
        $0.font = .systemFont(ofSize: 12)
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor.red,
                                      range: NSRange(location: 0, length: seatCount.count))
        $0.attributedText = attributedString
    }

    // MARK: - Initializers

    init(time: DateComponents, runTime: Int) {
        self.reserveTime = time

        super.init(frame: .zero)

        self.isUserInteractionEnabled = true

        setTimeText(time: time, runTime: runTime)
        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Components

    private func setUI() {
        self.layer.borderColor = UIColor.gray2.cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 10

        [timeLabel, seatLabel].forEach {
            self.addSubview($0)
        }

        timeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(9)
            $0.centerX.equalToSuperview()
        }

        seatLabel.snp.makeConstraints {
            $0.top.equalTo(timeLabel.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }

        self.snp.makeConstraints {
            $0.height.equalTo((UIScreen.main.bounds.width - 78) / 6)
        }
    }

    // MARK: - Methods

    private func setTimeText(time: DateComponents, runTime: Int) {
        let calendar = Calendar.current
        let startDate = calendar.date(from: time) ?? Date()
        let endDate = calendar.date(byAdding: .minute, value: runTime, to: startDate) ?? Date()
        let finalTimeComponents = calendar.dateComponents([.hour, .minute], from: endDate)

        let timeText = "\(reserveTime.hour ?? 0):" +
            String(format: "%02d", reserveTime.minute ?? 0)

        let endTimeText = "~\(finalTimeComponents.hour ?? 0):" +
            String(format: "%02d", finalTimeComponents.minute ?? 0)

        let attributedString = NSMutableAttributedString(string: timeText + endTimeText)

        attributedString.addAttribute(.font,
                                      value: UIFont.systemFont(ofSize: 14, weight: .bold),
                                      range: NSRange(location: 0, length: timeText.count))
        attributedString.addAttribute(.foregroundColor,
                                      value: UIColor.black,
                                      range: NSRange(location: 0, length: timeText.count))
        timeLabel.attributedText = attributedString
    }
}
