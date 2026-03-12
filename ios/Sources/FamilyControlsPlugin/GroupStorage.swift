import FamilyControls
import Foundation
import ManagedSettings

@available(iOS 16.0, *)
class GroupStorage {

  static let shared = GroupStorage()

  private let encoder = PropertyListEncoder()
  private let decoder = PropertyListDecoder()
  private let prefix = "app_group_"

  func saveGroup(id: String, name: String, blocking: Int, selection: FamilyActivitySelection) {
    let group = StoredGroup(id: id, name: name, blocking: blocking, selection: selection)
    if let data = try? encoder.encode(group) {
      UserDefaults.standard.set(data, forKey: "\(prefix)\(id)")
    }
  }

  func loadGroup(id: String) -> StoredGroup? {
    guard let data = UserDefaults.standard.data(forKey: "\(prefix)\(id)") else { return nil }
    return try? decoder.decode(StoredGroup.self, from: data)
  }

  func getAllGroups() -> [StoredGroup] {
    let defaults = UserDefaults.standard
    var groups: [StoredGroup] = []

    for (key, value) in defaults.dictionaryRepresentation() {
      if key.hasPrefix(prefix), let data = value as? Data,
        let stored = try? decoder.decode(StoredGroup.self, from: data)
      {
        groups.append(stored)
      }
    }

    return groups
  }

  func deleteGroup(id: String) {
    UserDefaults.standard.removeObject(forKey: "\(prefix)\(id)")
  }
}

struct StoredGroup: Codable {
  let id: String
  let name: String
  let blocking: Int
  let selection: FamilyActivitySelection
}
