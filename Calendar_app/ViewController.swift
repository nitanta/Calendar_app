//
//  ViewController.swift
//  Calendar_app
//
//  Created by Nitanta Adhikari on 31/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let calendarView: UICalendarView = {
        let view = UICalendarView()
        //let gregorianCalendar = Calendar(identifier: .gregorian)
        view.calendar = .current
        //view.locale = Locale(identifier: "zh_TW")
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
            calendarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            calendarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            calendarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            calendarView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    private func configureUI() {
        calendarView.visibleDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 6, day: 6)

        
//        let fromDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 1, day: 1)
//        let toDateComponents = DateComponents(calendar: Calendar(identifier: .gregorian), year: 2023, month: 12, day: 31)
//        guard let fromDate = fromDateComponents.date, let toDate = toDateComponents.date else {
//            return
//        }
//        let calendarViewDateRange = DateInterval(start: fromDate, end: toDate)
//        calendarView.availableDateRange = calendarViewDateRange
        
//        calendarView.availableDateRange = DateInterval(start: .now, end: .distantFuture)
        
        
        let observer = CalendarObserver()
        calendarView.delegate = observer

//        observer.observeEventChanges { [weak self] changedDates in
//            self?.calendarView.reloadDecorations(for: changedDates, animated: true)
//        }
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        dateSelection.setSelected(DateComponents(calendar: .current, year:2023, month: 6, day: 6), animated: true)
        calendarView.selectionBehavior = dateSelection
        
        

    }
}

//MARK: UICalendarSelectionSingleDateDelegate
extension ViewController: UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
}

//MARK: UICalendarSelectionMultiDateDelegate
extension ViewController: UICalendarSelectionMultiDateDelegate {
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didSelectDate dateComponents: DateComponents) {
        
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, didDeselectDate dateComponents: DateComponents) {
        
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canSelectDate dateComponents: DateComponents) -> Bool {
        return true
    }
    
    func multiDateSelection(_ selection: UICalendarSelectionMultiDate, canDeselectDate dateComponents: DateComponents) -> Bool {
        return true
    }
}

class CalendarObserver: NSObject, UICalendarViewDelegate {
    // Your database implementation goes here.
    func calendarView(_ calendarView: UICalendarView, decorationFor: DateComponents) -> UICalendarView.Decoration? {
        // Create and return calendar decorations here.
        guard let day = decorationFor.day else {
            return nil
        }
        
        if !day.isMultiple(of: 2) {
//            return UICalendarView.Decoration.default(color: .systemGreen, size: .large)
            
//            return UICalendarView.Decoration.image(UIImage(systemName: "add"))
            
            return UICalendarView.Decoration.customView {
                let label = UILabel()
                label.textColor = .systemMint
                label.text = "ABC"
                return label
            }
        }
        
        return nil
    }
}


