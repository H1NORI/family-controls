import Capacitor
import FamilyControls
import Foundation

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
    ]
    private let implementation = FamilyControls()

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
                "granted": "\(status)"
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
                let picker = FamilyActivityPickerViewController()
                self.bridge?.viewController?.present(picker, animated: true)
            }
        }
    }
  
}
