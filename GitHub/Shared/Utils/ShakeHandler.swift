import UIKit

/// A reusable handler for detecting shake gestures and triggering actions.
class ShakeHandler {
    // MARK: - Properties
    weak var delegate: (any ShakeClearable)?

    // MARK: - Initializer
    init(delegate: (any ShakeClearable)? = nil) { // Optional delegate
        self.delegate = delegate
    }

    // MARK: - Shake Detection
    func handleMotionBegan(_ motion: UIEvent.EventSubtype) {
        if motion == .motionShake {
            delegate?.clearCache()
        }
    }
}
