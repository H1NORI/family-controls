import Capacitor
import FamilyControls
import Foundation
import SwiftUI

/// Please read the Capacitor iOS Plugin Development Guide
/// here: https://capacitorjs.com/docs/plugins/ios
@objc(FamilyControlsPlugin)
public class FamilyControlsPlugin: CAPPlugin, CAPBridgedPlugin {
  public let identifier = "FamilyControlsPlugin"
  public let jsName = "FamilyControls"
  public let pluginMethods: [CAPPluginMethod] = [
    CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "checkPermission", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "requestPermission", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "openAppPicker", returnType: CAPPluginReturnPromise),

    CAPPluginMethod(name: "getGroups", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "saveGroup", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "blockGroup", returnType: CAPPluginReturnPromise),
    CAPPluginMethod(name: "unblockAll", returnType: CAPPluginReturnPromise),
  ]
  private let implementation = FamilyControls()

  private var lastSelection: FamilyActivitySelection?

  @objc func echo(_ call: CAPPluginCall) {
    let value = call.getString("value") ?? ""
    call.resolve([
      "value": implementation.echo(value)
    ])
  }

  @objc func checkPermission(_ call: CAPPluginCall) {
    if #available(iOS 16.0, *) {
      let status = AuthorizationCenter.shared.authorizationStatus

      call.resolve([
        "status": "\(status)"
      ])
    } else {
      call.reject("Screen Time API requires iOS 16 or newer")
    }
  }

  @objc func requestPermission(_ call: CAPPluginCall) {

    if #available(iOS 16.0, *) {
      Task {
        do {
          try await AuthorizationCenter.shared.requestAuthorization(for: .individual)

          call.resolve([
            "granted": true
          ])
        } catch {
          call.reject("Authorization failed")
        }
      }
    } else {
      call.reject("Screen Time API requires iOS 16 or newer")
    }
  }

  @objc func openAppPicker(_ call: CAPPluginCall) {
    if #available(iOS 16.0, *) {

      DispatchQueue.main.async {

        let groupId = call.getString("id") ?? ""

        let storedGroup = GroupStorage.shared.loadGroup(id: groupId)
        let selection = storedGroup?.selection ?? FamilyActivitySelection()

        print("Group ID:", groupId)
        print("Loaded selection apps:", selection.applicationTokens.count)
        print("Loaded selection categories:", selection.categoryTokens.count)

        let picker = AppPickerView(initialSelection: selection) { selection in

          self.lastSelection = selection

          let totalApps = 49
          let totalCategories = 10

          call.resolve([
            "selectedApps": selection.applicationTokens.count,
            "selectedCategories": selection.categoryTokens.count,
            "totalApps": totalApps,
            "totalCategories": totalCategories,
          ])
        }

        let hosting = UIHostingController(rootView: picker)

        self.bridge?.viewController?.present(hosting, animated: true)
      }

    } else {
      call.reject("Screen Time API requires iOS 16 or newer")
    }
  }

  @objc func getGroups(_ call: CAPPluginCall) {

    if #available(iOS 16.0, *) {

      let groups = GroupStorage.shared.getAllGroups()

      var result: [[String: Any]] = []

      let totalApps = 49
      let totalCategories = 10

      for group in groups {

        result.append([
          "id": group.id,
          "name": group.name,
          "blocking": group.blocking,
          "selectedApps": group.selection.applicationTokens.count,
          "selectedCategories": group.selection.categoryTokens.count,
          "totalApps": totalApps,
          "totalCategories": totalCategories,
        ])
      }

      call.resolve([
        "groups": result
      ])
    }
  }

  @objc func saveGroup(_ call: CAPPluginCall) {
    if #available(iOS 16.0, *) {

      let name = call.getString("name") ?? "Unnamed"

      guard let blocking = call.getInt("blocking") else {
        call.reject("Blocking required")
        return
      }

      let id = call.getString("id") ?? UUID().uuidString

      var selection: FamilyActivitySelection
      if let last = lastSelection {
        selection = last
      } else if let stored = GroupStorage.shared.loadGroup(id: id)?.selection {
        selection = stored
      } else {
        selection = FamilyActivitySelection()
      }

      GroupStorage.shared.saveGroup(id: id, name: name, blocking: blocking, selection: selection)

      let totalApps = 49
      let totalCategories = 10

      lastSelection = nil

      call.resolve([
        "id": id,
        "name": name,
        "blocking": blocking,
        "selectedApps": selection.applicationTokens.count,
        "selectedCategories": selection.categoryTokens.count,
        "totalApps": totalApps,
        "totalCategories": totalCategories,
      ])
    } else {
      call.reject("Screen Time API requires iOS 16 or newer")
    }
  }

  @objc func blockGroup(_ call: CAPPluginCall) {

    guard let name = call.getString("name") else {
      call.reject("Group name required")
      return
    }

    if #available(iOS 16.0, *) {

      //guard let selection = GroupStorage.shared.loadGroup(id: id) else {
        call.reject("Group not found")
        return
      //}

      //BlockingManager.shared.block(selection: selection)

      //call.resolve()
    }
  }

  @objc func unblockAll(_ call: CAPPluginCall) {

    if #available(iOS 16.0, *) {

      BlockingManager.shared.unblockAll()

      call.resolve()
    }
  }

}
