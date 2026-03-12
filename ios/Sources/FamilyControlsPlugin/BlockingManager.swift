import ManagedSettings
import FamilyControls

@available(iOS 16.0, *)
class BlockingManager {

    static let shared = BlockingManager()

    private let store = ManagedSettingsStore()

    func block(selection: FamilyActivitySelection) {

        store.shield.applications = selection.applicationTokens
        store.shield.applicationCategories = .specific(selection.categoryTokens)
    }

    func unblockAll() {

        store.shield.applications = nil
        store.shield.applicationCategories = nil
    }
}
