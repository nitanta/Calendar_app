//
//  ViewController.swift
//  Calendar_app
//
//  Created by Nitanta Adhikari on 31/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = ViewModel()
    
    let calendarView: UICalendarView = {
        let view = UICalendarView()
        view.calendar = .current
        view.fontDesign = .rounded
        view.tintColor = .systemMint
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }

    private func setupUI() {
        view.addSubview(calendarView)
        
        NSLayoutConstraint.activate([
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            calendarView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calendarView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    private func configureUI() {
//        let currentDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: Date())
//        calendarView.visibleDateComponents = currentDateComponents
//
//        guard let currentYear = Calendar.current.dateComponents([.year], from: Date()).year else { return }
//
//        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: currentYear, month: 1, day: 1)
//        let toDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: currentYear, month: 12, day: 31)
//        guard let fromDate = fromDateComponents.date, let toDate = toDateComponents.date else {
//            return
//        }
//        let calendarViewDateRange = DateInterval(start: fromDate, end: toDate)
//        calendarView.availableDateRange = calendarViewDateRange
        
//        Available date range from .now to .distantFuture
//        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        
        
//        calendarView.delegate = self
        
//        Reload decoration using observations
//        observer.observeEventChanges { [weak self] changedDates in
//            self?.calendarView.reloadDecorations(for: changedDates, animated: true)
//        }
        
        
//        Single data selection
//        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
////        dateSelection.setSelected(currentDateComponents, animated: true)
//        calendarView.selectionBehavior = dateSelection
        
//        Multi date selection
//        let dateComponentsRanges = (0...5).map {
//            Calendar.current.dateComponents([.year, .month, .day], from: Date().addData(days: $0))
//        }
//        let dateSelection = UICalendarSelectionMultiDate(delegate: self)
////        dateSelection.setSelectedDates(dateComponentsRanges, animated: true)
//        calendarView.selectionBehavior = dateSelection
        

    }
    
    @objc func decorationTap() {
        debugPrint("DECORATION TAP")
    }
}

//MARK: UICalendarSelectionSingleDateDelegate
//extension ViewController: UICalendarSelectionSingleDateDelegate {
//    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
//        debugPrint("DID SELECT SINGLE DATE", dateComponents?.date as Any)
//    }
//
//    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
//        return true
//    }
//}

//MARK: UICalendarSelectionMultiDateDelegate
//extension ViewController: UICalendarSelectionMultiDateDelegate {
//    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
//        debugPrint("DID SELECT MULTI DATE", dateComponents.date)
//    }
//
//    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
//        debugPrint("DID DESELECT MULTI DATE", dateComponents.date)
//    }
//
//    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
//        return true
//    }
//
//    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
//        return true
//    }
//}

//extension ViewController: UICalendarViewDelegate {
//    func calendarView(_ calendarView: UICalendarView, decorationFor: DateComponents) -> UICalendarView.Decoration? {
//        guard let date = decorationFor.date else {
//            return nil
//        }
//        let decorationComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
//        if let importantDate = viewModel.datasource.first(where: { $0.components == decorationComponents }) {
////            Default decorator
////            return .default(color: importantDate.tag.color, size: .large)
//
////            Image decoration
////            return .image(UIImage(systemName: "star.fill"), color: importantDate.tag.color)
//
////            Custom view decoration
//            return .customView { [weak self] in
//                let button = TagButton(tags: importantDate.tag)
//                button.addTarget(self, action: #selector(self?.decorationTap), for: .touchUpInside)
//                return button
//            }
//        }
//
//        return nil
//    }
//}

class ViewModel {
    enum Tag: String {
        case chore
        case reminder
        case event
        case errand
        
        var color: UIColor {
            switch self {
            case .chore: return .red
            case .reminder: return .blue
            case .event: return .yellow
            case .errand: return .green
            }
        }
    }
    
    struct ImportantDate {
        let date: Date
        let message: String
        let tag: Tag
        
        var components: DateComponents {
            Calendar.current.dateComponents([.year, .month, .day], from: date)
        }
    }
    
    let datasource: [ImportantDate] = [
        .init(date: Date(), message: "Call, Nirvaan", tag: .reminder),
        .init(date: Date().addData(days: 2), message: "Take your pet to see the vet", tag: .errand),
        .init(date: Date().addData(days: 6), message: "Attend Rick's wedding", tag: .event),
        .init(date: Date().addData(days: 8), message: "Clean aparment!!!!!", tag: .chore)
    ]
    
    var fromDate: DateComponents?
    var toDate: DateComponents?
    
    func addDate(date: DateComponents) {
        
    }
    
    func removeDate(date: DateComponents) {
        
    }
}

extension Date {
    func addData(days: Int) -> Self {
        return Calendar.current.date(byAdding: .day, value: days, to: self) ?? Date()
    }
}

class TagButton: UIButton {
    let tags: ViewModel.Tag
    public init(tags: ViewModel.Tag) {
        self.tags = tags
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        let size = CGSize(width: UIView.layoutFittingExpandedSize.width, height: 20)
        return size
    }
    
    private func setupUI() {
        setTitle(tags.rawValue, for: .normal)
        backgroundColor = tags.color
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 8)
        layer.cornerRadius = 10
    }
    
}

/*
class ViewController: UIViewController {
    
    enum TokenType: String, CaseIterable {
        case small
        case medium
        case large
        
        var image: UIImage? {
            return UIImage(systemName: "flag")
        }
    }
    
    var availableTokens: [UISearchToken] = []

    let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.tintColor = .systemTeal
        view.placeholder = "Search"
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureUI()
    }

    private func setupUI() {
        view.addSubview(searchBar)
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }

    private func configureUI() {
        availableTokens = TokenType.allCases.map({ tokenType -> UISearchToken in
            let token = UISearchToken(icon: tokenType.image, text: tokenType.rawValue)
            token.representedObject = tokenType.rawValue
            return token
        })
        searchBar.searchTextField.tokens = availableTokens
        searchBar.searchTextField.tokenBackgroundColor = .systemGray2
        
        searchBar.searchTextField.allowsCopyingTokens = true
        searchBar.searchTextField.allowsDeletingTokens = true
        
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
    }
    
}

extension ViewController: UISearchTextFieldDelegate {
    func searchTextField(_ searchTextField: UISearchTextField, didSelect suggestion: UISearchSuggestion) {
        debugPrint(suggestion.description)
    }
    
    func searchTextField(_ searchTextField: UISearchTextField, itemProviderForCopying token: UISearchToken) -> NSItemProvider {
        debugPrint(token)
        let provider = NSItemProvider()
        return provider
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        debugPrint(searchBar.searchTextField.tokens.map { $0.representedObject})
    }
}
*/
