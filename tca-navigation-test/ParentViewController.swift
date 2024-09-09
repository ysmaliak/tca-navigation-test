//
//  ParentViewController.swift
//  tca-navigation-test
//
//  Created by Yan Smaliak on 09/09/2024.
//

import ComposableArchitecture
import UIKit

@Reducer
struct ParentFeature {
    @Reducer
    enum Destination {
        case firstChild(FirstChildFeature)
        case secondChild(SecondChildFeature)
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
                state.destination = .firstChild(FirstChildFeature.State())
                return .none

            case .destination(.presented(.firstChild(.delegate(.buttonTapped)))):
                state.destination = .secondChild(SecondChildFeature.State())
                return .none

            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

class ParentViewController: UIViewController {
    @UIBindable private var store: StoreOf<ParentFeature>

    init(store: StoreOf<ParentFeature>) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .paleBlue
        let stack = UIStackView()
        stack.frame = CGRect(x: 0, y: 0, width: 200, height: 400)
        view.addSubview(stack)
        stack.center = view.center

        let label = UILabel()
        label.text = "Parent"
        stack.addArrangedSubview(label)

        let button = UIButton()
        button.setTitle("Tap", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addAction(UIAction { [weak self] _ in self?.store.send(.buttonTapped) }, for: .touchUpInside)
        stack.addArrangedSubview(button)

        present(item: $store.scope(state: \.destination?.firstChild, action: \.destination.firstChild)) {
            FirstChildViewController(store: $0)
        }

        present(item: $store.scope(state: \.destination?.secondChild, action: \.destination.secondChild)) {
            SecondChildViewController(store: $0)
        }
    }
}
