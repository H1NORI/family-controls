import Foundation

@objc public class FamilyControls: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
