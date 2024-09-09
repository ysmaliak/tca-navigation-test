//
//  AppViewController.swift
//  tca-navigation-test
//
//  Created by Yan Smaliak on 09/09/2024.
//

import ComposableArchitecture
import UIKit

@Reducer
struct AppFeature {
    @Reducer
    enum Destination {
        case parent(ParentFeature)
    }

    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
    }
    enum Action {
        case buttonTapped
        case destination(PresentationAction<Destination.Action>)
    }

    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                state.destination = .parent(ParentFeature.State())
                return .none

            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

class AppViewController: UIViewController {
    @UIBindable private var store: StoreOf<AppFeature>

    init(store: StoreOf<AppFeature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let stack = UIStackView()
        stack.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        view.addSubview(stack)
        stack.center = view.center

        let label = UILabel()
        label.text = "App"
        stack.addArrangedSubview(label)

        let button = UIButton()
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addAction(UIAction { [weak self] _ in self?.store.send(.buttonTapped) }, for: .touchUpInside)
        stack.addArrangedSubview(button)

        present(item: $store.scope(state: \.destination?.parent, action: \.destination.parent)) {
            ParentViewController(store: $0)
        }
    }
}

extension UIColor {
    static let paleBlue = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0)
    static let paleGreen = UIColor(red: 152/255, green: 251/255, blue: 152/255, alpha: 1.0)
    static let paleYellow = UIColor(red: 255/255, green: 255/255, blue: 224/255, alpha: 1.0)
}
