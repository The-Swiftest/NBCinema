//
//  MyPageView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/17/25.
//

import UIKit

import SnapKit
import Then

class MyPageView: UIView {
    let headerView = HeaderView(.logo)

    let myPageScrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }

    let profileImageView = UIImageView().then {
        $0.image = UIImage(systemName: "person.circle.fill")
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.tintColor = .gray2
    }

    let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.text = (KeychainService.load(service: KeychainConstants.service,
                                        account: KeychainConstants.emailAccount) ?? "사용자") + "님"
    }

    let logoutButton = UIButton().then {
        $0.setTitle("  로그아웃", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setImage(UIImage(systemName: "iphone.and.arrow.right.outward"), for: .normal)
        $0.tintColor = .nbcMain
        $0.setTitleColor(.nbcMain, for: .normal)
    }

    let reservationsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = "예매 내역"
    }

    let reservationsMoreButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing

        var attr = AttributeContainer()
        attr.font = .systemFont(ofSize: 16, weight: .bold)

        config.attributedTitle = AttributedString("더보기", attributes: attr)
        config.baseForegroundColor = .gray2
        $0.setImage(UIImage(named: "rightArrow"), for: .normal)
        $0.configuration = config
    }

    private let reservationStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
    }

    let favoriteLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.text = "찜한 영화"
    }

    let favoriteMoreButton = UIButton().then {
        var config = UIButton.Configuration.plain()
        config.imagePlacement = .trailing

        var attr = AttributeContainer()
        attr.font = .systemFont(ofSize: 16, weight: .bold)

        config.attributedTitle = AttributedString("더보기", attributes: attr)
        config.baseForegroundColor = .gray2
        $0.setImage(UIImage(named: "rightArrow"), for: .normal)
        $0.configuration = config
    }

    private let favoriteStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 15
    }

    var favoriteTrashButtonTapped: ((String) -> Void)?

    private let contentView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemBackground
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        [headerView, myPageScrollView].forEach {
            addSubview($0)
        }

        [profileImageView,
         nameLabel,
         logoutButton,
         reservationsLabel,
         reservationsMoreButton,
         reservationStackView,
         favoriteLabel,
         favoriteMoreButton,
         favoriteStackView].forEach {
            contentView.addSubview($0)
        }

        myPageScrollView.addSubview(contentView)

        headerView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }

        myPageScrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(self.safeAreaLayoutGuide)
        }

        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(myPageScrollView.snp.width)
        }

        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.height.equalTo(90)
            $0.leading.equalTo(20)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(14)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
        }

        logoutButton.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(nameLabel)
        }

        reservationsLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).offset(20)
        }

        reservationsMoreButton.snp.makeConstraints {
            $0.top.equalTo(reservationsLabel)
            $0.trailing.equalTo(contentView).inset(20)
        }

        reservationStackView.snp.makeConstraints {
            $0.top.equalTo(reservationsLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        favoriteLabel.snp.makeConstraints {
            $0.top.equalTo(reservationStackView.snp.bottom).offset(30)
            $0.leading.equalTo(contentView).offset(20)
        }

        favoriteMoreButton.snp.makeConstraints {
            $0.top.equalTo(favoriteLabel)
            $0.trailing.equalTo(contentView).inset(20)
        }

        favoriteStackView.snp.makeConstraints {
            $0.top.equalTo(favoriteLabel.snp.bottom).offset(15)
            $0.leading.bottom.trailing.equalToSuperview().inset(20)
        }
    }

    func makeReservationView(items: [ReservationDetail]) {
        /// 먼저 있는 예매 내역 삭제
        reservationStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }

        /// 새로운 예매 내역이 없는 경우 label 추가
        if items.isEmpty {
            let emptyLabel = UILabel().then {
                $0.text = "예매 내역이 없습니다."
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = .gray3
                $0.textAlignment = .center
            }
            self.reservationStackView.addArrangedSubview(emptyLabel)
            /// 더보기 버튼 비활성화
            self.reservationsMoreButton.isEnabled = false
        } else {
            /// 더보기 버튼 활성화
            self.reservationsMoreButton.isEnabled = true
            /// 예매 내역 추가
            for item in items {
                let reservationView = ReservationView()
                reservationView.configure(with: item)
                self.reservationStackView.addArrangedSubview(reservationView)
            }
        }
    }

    func makeFavoriteView(items: [FavoriteMovie]) {
        /// 먼저 있는 찜한 내역 삭제
        favoriteStackView.arrangedSubviews.forEach { view in
            view.removeFromSuperview()
        }

        /// 새로운 찜한 내역이 없는 경우 label 추가
        if items.isEmpty {
            let emptyLabel = UILabel().then {
                $0.text = "찜한 영화가 없습니다."
                $0.font = .systemFont(ofSize: 14)
                $0.textColor = .gray3
                $0.textAlignment = .center
            }
            self.favoriteStackView.addArrangedSubview(emptyLabel)
            /// 더보기 버튼 비활성화
            self.favoriteMoreButton.isEnabled = false
        } else {
            /// 더보기 버튼 활성화
            self.favoriteMoreButton.isEnabled = true
            /// 예매 내역 추가
            for item in items {
                let favoriteView = FavoriteView()
                favoriteView.configure(with: item)
                favoriteView.trashButtonTapped = { [weak self] movieTitle in
                    self?.favoriteTrashButtonTapped?(movieTitle)
                }
                self.favoriteStackView.addArrangedSubview(favoriteView)
            }
        }
    }
}
