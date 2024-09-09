//
//  SecondChildViewController.swift
//  tca-navigation-test
//
//  Created by Yan Smaliak on 09/09/2024.
//

import ComposableArchitecture
import UIKit

@Reducer
struct SecondChildFeature {
    @ObservableState
    struct State {}
    enum Action {}

    var body: some ReducerOf<Self> {
        EmptyReducer()
    }
}

class SecondChildViewController: UIViewController {
    private let store: StoreOf<SecondChildFeature>

    init(store: StoreOf<SecondChildFeature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel()
        view.backgroundColor = .paleYellow
        label.text = "Second Child"
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        view.addSubview(label)
        label.center = view.center
    }
}
