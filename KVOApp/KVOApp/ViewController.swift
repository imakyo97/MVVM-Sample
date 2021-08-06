//
//  ViewController.swift
//  KVOApp
//
//  Created by akio0911 on 2021/04/07.
//

import UIKit

class ViewController: UIViewController {

    private let viewModel = ViewModel()

    @IBOutlet weak var label: UILabel!

    private var disposeBag = Set<NSKeyValueObservation>()

    override func viewDidLoad() {
        super.viewDidLoad()

        disposeBag.insert(
            viewModel.observe(
                \ViewModel.labelText,
                options: [.initial, .new],
                changeHandler: { [weak self] _, change in
                    self?.label.text = change.newValue
                }
            )
        )
    }

    @IBAction func didTapButton(_ sender: Any) {
        viewModel.increment()
    }
}

class ViewModel: NSObject {

    private let counter = Counter()

    @objc dynamic var labelText: String = ""

    override init() {
        super.init()
        updateLabelText()
    }

    func increment() {
        counter.increment()
        updateLabelText()
    }

    private func updateLabelText() {
        labelText = String("現在のカウントは\(counter.count)です")
    }
}

class Counter {
    private(set) var count = 0

    func increment() {
        count += 1
    }
}
