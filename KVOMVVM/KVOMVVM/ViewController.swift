//
//  ViewController.swift
//  KVOMVVM
//
//  Created by akio0911 on 2020/12/20.
//

import UIKit

// Model View ViewModel - Wikipedia
// https://ja.wikipedia.org/wiki/Model_View_ViewModel#Model
// View
// アプリケーションの扱うデータをユーザーが見るのに適した形で表示し、ユーザーからの入力を受け取る要素である。すなわちUIへの入力とUIからの出力を担当する。MVVMにおけるViewは、後述するViewModelに含まれたデータをデータバインディング機構のようなものを通じて自動的に描画するだけで自身の役割を果たす。Viewそのものに複雑なロジックと状態を持たないのがMVVMのViewの特徴である。
final class ViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    private let viewModel = ViewModel()
    
    // RxSwift でいうところの DisposeBag 的なやつ
    private var observations = Set<NSKeyValueObservation>()
    
    private var items: [Item] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }
    
    /// MVVMにおけるViewは、後述するViewModelに含まれたデータをデータバインディング機構のようなものを通じて自動的に描画するだけで自身の役割を果たす。
    private func setupBindings() {
        // Using Key-Value Observing in Swift | Apple Developer Documentation
        // https://developer.apple.com/documentation/swift/cocoa_design_patterns/using_key-value_observing_in_swift
        
        // RxSwift でいうところの subscribe 的なやつ
        let observation = viewModel.observe(
            \.viewData,
            changeHandler: { _, _ in
                DispatchQueue.main.async { [weak self] in
                    guard let strongSelf = self else { return }
                    strongSelf.items = strongSelf.viewModel.viewData.items
                    strongSelf.tableView.reloadData()
                }
            }
        )

        // RxSwift でいうところの disposed(by:) 的なやつ
        observations.insert(observation)
    }
    
    /// ユーザーからの入力を受け取る
    /// UIへの入力
    @IBAction func reload(_ sender: Any) {
        viewModel.reload()
    }
}

extension ViewController: UITableViewDataSource {
    /// アプリケーションの扱うデータをユーザーが見るのに適した形で表示
    /// UIからの出力
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    /// アプリケーションの扱うデータをユーザーが見るのに適した形で表示
    /// UIからの出力
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        return cell
    }
}
