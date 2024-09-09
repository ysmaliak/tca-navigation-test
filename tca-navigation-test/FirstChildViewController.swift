//
//  FirstChildViewController.swift
//  tca-navigation-test
//
//  Created by Yan Smaliak on 09/09/2024.
//

import ComposableArchitecture
import UIKit

@Reducer
struct FirstChildFeature {
    @ObservableState
    struct State {}
    enum Action {
        enum Delegate {
            case buttonTapped
        }

        case buttonTapped
        case delegate(Delegate)
    }

    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .buttonTapped:
                return .send(.delegate(.buttonTapped))

            case .delegate:
                return .none
            }
        }
    }
}

class FirstChildViewController: UIViewController {
    private let store: StoreOf<FirstChildFeature>

    init(store: StoreOf<FirstChildFeature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .paleGreen
        let stack = UIStackView()
        stack.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        view.addSubview(stack)
        stack.center = view.center

        let label = UILabel()
        label.text = "First Child"
        stack.addArrangedSubview(label)

        let button = UIButton()
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addAction(UIAction { [weak self] _ in self?.store.send(.buttonTapped) }, for: .touchUpInside)
        stack.addArrangedSubview(button)
    }
}
