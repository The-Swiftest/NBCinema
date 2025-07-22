//
//  ReserveView.swift
//  NBCinema
//
//  Created by seongjun cho on 7/18/25.
//

import UIKit

import SnapKit
import Then

protocol ReserveViewDelegate: AnyObject {
    func reserveButtonTapped(inform: UserChoiceInform)
}

final class ReserveView: UIView {

    // MARK: - UI Components

    let headerView = HeaderView(.sub("예매하기"))

    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.contentInsetAdjustmentBehavior = .never
    }

    private let contentView = UIView()

    private let posterImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 10
        $0.layer.masksToBounds = true
    }

    private let movieTitleLabel = UILabel().then {
        $0.text = "영화 제목"
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }

    private let genreLabel = UILabel().then {
        $0.text = "장르"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray3
    }

    private let runtimeLabel = UILabel().then {
        $0.text = "0시간 00분"
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .gray3
    }

    private let userChoiceView = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 25
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private let dateSymbolLabelStackView = SymbolLabelStackView(
        symbol: UIImage(named: "calendarDark") ?? UIImage(systemName: "xmark")!,
        title: "날짜 선택").then {
            $0.label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.label.textColor = .black
        }

    private let dateStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
    }

    private let dateScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }

    private let timeSymbolLabelStackView = SymbolLabelStackView(
        symbol: UIImage(named: "clock") ?? UIImage(systemName: "xmark")!,
        title: "시간 선택").then {
            $0.label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.label.textColor = .black
        }

    private let firstStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }

    private let secondStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }

    private let thirdStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }

    private let peopleSymbolLabelStackView = SymbolLabelStackView(
        symbol: UIImage(named: "peopleDark") ?? UIImage(systemName: "xmark")!,
        title: "인원 선택").then {
            $0.label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            $0.label.textColor = .black
        }

    private let adulteLabel = UILabel().then {
        $0.text = "성인"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .black
    }

    private let youthLabel = UILabel().then {
        $0.text = "청소년"
        $0.font = UIFont.systemFont(ofSize: 12)
        $0.textColor = .black
    }

    private(set) lazy var adultCountView = CountView().then {
        $0.onCountChanged = { [weak self] num in
            self?.adultCount = num
        }
    }

    private(set) lazy var youthCountView = CountView().then {
        $0.onCountChanged = { [weak self] num in
            self?.youthCount = num
        }
    }

    private let paymentButton = NbcButton(title: "결제하기").then {
        $0.isEnabled = false
    }

    private let totalAmountLabel = UILabel().then {
        $0.text = "총 금액"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
    }

    private let totalAmountInformLabel = UILabel().then {
        $0.text = "0원"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .nbcMain
    }

    // MARK: - Properties
    weak var delegate: ReserveViewDelegate?

    private var amount: Int = 0 {
        didSet {
            if selectedDate != nil && selectedTime != nil && amount != 0 {
                paymentButton.isEnabled = true
            }
            totalAmountInformLabel.text = "\(amount.toCommaString())원"
        }
    }

    private var selectedDate: Date? {
        didSet {
            if selectedDate != nil && selectedTime != nil && amount != 0 {
                paymentButton.isEnabled = true
            }
        }
    }

    private var selectedTime: DateComponents?  {
        didSet {
            if selectedDate != nil && selectedTime != nil && amount != 0 {
                paymentButton.isEnabled = true
            }
        }
    }

    private var adultCount: Int = 0 {
        didSet {
            amount = adultCount * 13000 + youthCount * 10000
        }
    }

    private var youthCount: Int = 0 {
        didSet {
            amount = adultCount * 13000 + youthCount * 10000
        }
    }

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setHeaderUI()
        setScrollViewUI()
        setMovieInfoUI()
        setUserChoiceUI()
        makeReserveDateViews()
        makeReserveTimeViews(runTime: 120)
        posterImageView.loadImage(from: URL(string: "https://picsum.photos/id/1/100/150")!)
        paymentButton.addTarget(self, action: #selector(tapReserveButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // 좌석 구현 하면 적용
    //    // MARK: - Lifecycle
    //
    //    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    //        super.traitCollectionDidChange(previousTraitCollection)
    //
    //        /// 라이트/다크 모드 전환됨
    //        if previousTraitCollection?.userInterfaceStyle != traitCollection.userInterfaceStyle {
    //            if traitCollection.userInterfaceStyle == .light {
    //                userChoiceView.snp.updateConstraints {
    //                    $0.top.equalTo(posterImageView.snp.bottom)
    //                }
    //            } else {
    //                userChoiceView.snp.updateConstraints {
    //                    $0.top.equalTo(posterImageView.snp.bottom).offset(42)
    //                }
    //            }
    //        }
    //    }

    // MARK: - Setup Methods
    private func setHeaderUI() {
        addSubview(headerView)

        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
    }

    private func setScrollViewUI() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)

        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }

    private func setMovieInfoUI() {
        [posterImageView, movieTitleLabel, genreLabel, runtimeLabel].forEach {
            contentView.addSubview($0)
        }

        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalTo(22)
            $0.height.equalTo(130)
            $0.width.equalTo(100)
        }

        movieTitleLabel.snp.makeConstraints {
            $0.top.equalTo(posterImageView)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
        }

        genreLabel.snp.makeConstraints {
            $0.top.equalTo(movieTitleLabel.snp.bottom).offset(10)
            $0.leading.equalTo(movieTitleLabel)
            $0.trailing.equalToSuperview().inset(20)
        }

        runtimeLabel.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom).offset(4)
            $0.leading.equalTo(genreLabel)
        }
    }

    private func setUserChoiceUI() {
        contentView.addSubview(userChoiceView)

        [dateSymbolLabelStackView,
         dateScrollView,
         timeSymbolLabelStackView,
         firstStackView,
         secondStackView,
         thirdStackView,
         peopleSymbolLabelStackView,
         adulteLabel,
         adultCountView,
         youthLabel,
         youthCountView,
         paymentButton,
         totalAmountLabel,
         totalAmountInformLabel
        ].forEach {
            userChoiceView.addSubview($0)
        }

        dateScrollView.addSubview(dateStackView)

        // 좌석 구현할 때, 사용
        //        if traitCollection.userInterfaceStyle == .dark {
        //            // 다크 모드일 때 처리
        //            userChoiceView.snp.makeConstraints {
        //                $0.top.equalTo(posterImageView.snp.bottom).offset(42)
        //                $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        //                $0.bottom.equalToSuperview()
        //            }
        //        } else {
        //            // 라이트 모드일 때 처리
        //            userChoiceView.snp.makeConstraints {
        //                $0.top.equalTo(posterImageView.snp.bottom)
        //                $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        //                $0.bottom.equalToSuperview()
        //            }
        //        }

        userChoiceView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(23)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }

        dateSymbolLabelStackView.snp.makeConstraints {
            $0.top.equalTo(userChoiceView).offset(25)
            $0.leading.equalTo(20)
        }

        dateScrollView.snp.makeConstraints {
            $0.top.equalTo(dateSymbolLabelStackView.snp.bottom).offset(12)
            $0.leading.equalTo(dateSymbolLabelStackView)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(dateStackView)
        }

        dateStackView.snp.makeConstraints {
            $0.directionalEdges.equalToSuperview()
        }

        timeSymbolLabelStackView.snp.makeConstraints {
            $0.top.equalTo(dateScrollView.snp.bottom).offset(32)
            $0.leading.equalToSuperview().offset(20)
        }

        firstStackView.snp.makeConstraints {
            $0.top.equalTo(timeSymbolLabelStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(21)
        }

        secondStackView.snp.makeConstraints {
            $0.top.equalTo(firstStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(21)
        }

        thirdStackView.snp.makeConstraints {
            $0.top.equalTo(secondStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(21)
        }

        peopleSymbolLabelStackView.snp.makeConstraints {
            $0.top.equalTo(thirdStackView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(21)
        }

        adulteLabel.snp.makeConstraints {
            $0.top.equalTo(peopleSymbolLabelStackView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(21)
        }

        adultCountView.snp.makeConstraints {
            $0.centerY.equalTo(adulteLabel)
            $0.trailing.equalToSuperview().inset(21)
            $0.width.equalTo(82)
            $0.height.equalTo(24)
        }

        youthLabel.snp.makeConstraints {
            $0.top.equalTo(adulteLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(21)
        }

        youthCountView.snp.makeConstraints {
            $0.centerY.equalTo(youthLabel)
            $0.trailing.equalToSuperview().inset(21)
            $0.width.equalTo(82)
            $0.height.equalTo(24)
        }

        totalAmountLabel.snp.makeConstraints {
            $0.top.equalTo(youthLabel.snp.bottom).offset(30)
            $0.leading.equalTo(youthLabel)
        }

        totalAmountInformLabel.snp.makeConstraints {
            $0.top.equalTo(totalAmountLabel)
            $0.trailing.equalToSuperview().inset(25)
        }

        paymentButton.snp.makeConstraints {
            $0.top.equalTo(totalAmountLabel.snp.bottom).offset(32)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.trailing.equalToSuperview().inset(25)
        }
    }

    private func makeReserveTimeViews(runTime: Int) {
        for i in 0..<9 {
            let reservetimeView = ReserveTimeView(time: DateComponents(hour: 9 + i), runTime: runTime)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(timeTap))

            reservetimeView.addGestureRecognizer(tapGesture)
            switch i {
            case 0, 1, 2:
                firstStackView.addArrangedSubview(reservetimeView)
            case 3, 4, 5:
                secondStackView.addArrangedSubview(reservetimeView)
            case 6, 7, 8:
                thirdStackView.addArrangedSubview(reservetimeView)
            default:
                break
            }

        }
    }

    private func makeReserveDateViews() {
        for i in 0..<12 {
            let reserveDateView = ReserveDateView(
                date: Date().addingTimeInterval(TimeInterval(60 * 60 * 24 * i)))
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dateTap))
            reserveDateView.addGestureRecognizer(tapGesture)
            dateStackView.addArrangedSubview(reserveDateView)
        }
    }

    // MARK: - Methods

    func configure(item: MovieDetail) {
        DispatchQueue.main.async { [weak self] in
            self?.posterImageView.loadImage(
                from: item.posterURL ?? URL(string: "https://placehold.co/200x300")!)
            self?.movieTitleLabel.text = item.title
            self?.runtimeLabel.text = "\(item.runtime.toTimeString())"
            self?.genreLabel.text = item.genres.map(\.self.name).joined(separator: ", ")
        }
    }

    // MARK: - Actions

    @objc func dateTap(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? ReserveDateView else { return }

        self.dateStackView.subviews.forEach { view in
            (view as! ReserveDateView).isSelected = false
        }
        view.isSelected.toggle()

        // 여기서 저장용 데이터의 년월일 등록해야함
        self.selectedDate = view.reserveDate
    }

    @objc func timeTap(_ sender: UITapGestureRecognizer) {
        guard let view = sender.view as? ReserveTimeView else { return }

        self.firstStackView.subviews.forEach { view in
            (view as! ReserveTimeView).isSelected = false
        }
        self.secondStackView.subviews.forEach { view in
            (view as! ReserveTimeView).isSelected = false
        }
        self.thirdStackView.subviews.forEach { view in
            (view as! ReserveTimeView).isSelected = false
        }

        view.isSelected.toggle()

        // 여기서 저장용 데이터의 시간 등록해야함
        self.selectedTime = view.reserveTime
    }

    @objc func tapReserveButton() {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: selectedDate ?? Date())
        let reservationTime = calendar
            .date(byAdding: selectedTime ?? DateComponents(), to: day) ?? Date()
        let inform = UserChoiceInform(
            reservationTime: reservationTime,
            numOfPeople: adultCount + youthCount,
            amount: amount
        )

        delegate?.reserveButtonTapped(inform: inform)
    }

    func getMovieInfoString() -> String {
        let calendar = Calendar.current
        let day = calendar.startOfDay(for: selectedDate ?? Date())
        let reservationTime = calendar
            .date(byAdding: selectedTime ?? DateComponents(), to: day) ?? Date()
        var result = ""

        result += "영화 제목 : \(movieTitleLabel.text ?? "")\n"
        result += "예매 일시 : \(reservationTime.toMonthDayString())\n"
        result += "인원 : 청소년 \(youthCount)인, 성인 \(adultCount)인\n"
        result += "가격 : \(amount)"

        return result
    }
}
