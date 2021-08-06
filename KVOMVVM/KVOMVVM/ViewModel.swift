//
//  ViewModel.swift
//  KVOMVVM
//
//  Created by akio0911 on 2020/12/20.
//

import Foundation

struct Item {
    let name: String
}

final class ViewData: NSObject {
    let items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
}

// Model View ViewModel - Wikipedia
// https://ja.wikipedia.org/wiki/Model_View_ViewModel#Model
// ViewModel
// Viewを描画するための状態の保持と、Viewから受け取った入力を適切な形に変換してModelに伝達する役目を持つ。すなわちViewとModelの間の情報の伝達と、Viewのための状態保持のみを役割とする要素である。Viewとの通信はデータバインディング機構のような仕組みを通じて行うため、ViewModelの変更は開発者から見て自動的にViewに反映される。
final class ViewModel: NSObject {
    /// Viewを描画するための状態の保持
    /// KVOを使って自動的にViewに反映させる
    @objc dynamic private(set) var viewData = ViewData(items: [])
    
    private let model = Model()
    
    func reload() {
        // Viewから受け取った入力を適切な形に変換してModelに伝達する
        let items = model.fetch()
        
        /// Viewを描画するための状態の保持
        /// KVOを使って自動的にViewに反映させる
        viewData = ViewData(items: items)
    }
}

// Model View ViewModel - Wikipedia
// https://ja.wikipedia.org/wiki/Model_View_ViewModel#Model
// Model
// アプリケーションのドメイン（問題領域）を担う、そのアプリケーションが扱う領域のデータと手続き（ビジネスロジック - ショッピングの合計額や送料を計算するなど）を表現する要素である。
// 多くのアプリケーションではデータの格納に永続的な記憶の仕組み（データベースなど）が使われていたり、サーバが別途存在するアプリケーションではサーバ側との通信ロジックなどが含まれている。

final class Model {
    /// サーバ側との通信ロジック
    func fetch() -> [Item] {
        (0...Int.random(in: (1...10)))
            .map { Item(name: "Apple \($0)") }
    }
}
