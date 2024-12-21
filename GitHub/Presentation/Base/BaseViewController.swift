import UIKit
import Combine

class BaseViewController<VM: BaseViewModel>: UIViewController {
    // MARK: - Properties
    let viewModel: VM
    var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindToBaseViewModel()
    }

    // MARK: - Setup Methods
    /// Override to set up UI in child classes
    func setupView() {
        view.backgroundColor = .white
    }

    /// Override to add additional bindings in child classes
    func bindViewModel() {}

    // MARK: - Bind to BaseViewModel
    private func bindToBaseViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.handleLoading(isLoading: isLoading)
            }
            .store(in: &cancellables)

        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.handleError(message: message)
            }
            .store(in: &cancellables)
    }

    // MARK: - Loading and Error Handling
    func handleLoading(isLoading: Bool) {
        // Default implementation: can be overridden for custom behavior
        if isLoading {
            showActivityIndicator()
        } else {
            hideActivityIndicator()
        }
    }

    func handleError(message: String?) {
        // Default implementation: can be overridden for custom behavior
        guard let message = message else { return }
        hideActivityIndicator()
        showErrorAlert(message: message)
    }

    // MARK: - UI Helpers
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        indicator.center = view.center
        return indicator
    }()

    private func showActivityIndicator() {
        activityIndicator.startAnimating()
    }

    private func hideActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

