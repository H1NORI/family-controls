import FamilyControls
import SwiftUI

@available(iOS 16.0, *)
struct AppPickerView: View {

  @State var selection: FamilyActivitySelection

  @Environment(\.dismiss) private var dismiss

  let onComplete: (FamilyActivitySelection) -> Void

  init(
    initialSelection: FamilyActivitySelection,
    onComplete: @escaping (FamilyActivitySelection) -> Void
  ) {
    self.onComplete = onComplete
    _selection = State(initialValue: initialSelection)
  }

  var body: some View {
    VStack {
      FamilyActivityPicker(selection: $selection)

      VStack(spacing: 12) {

        Button(action: {
          onComplete(selection)
          dismiss()
        }) {
          Text("Save")
            .font(.headline)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color(red: 0.11, green: 0.69, blue: 0.96))
            .cornerRadius(12)
        }

        Button(action: {
          dismiss()
        }) {
          Text("Cancel")
            .font(.headline)
            .foregroundColor(.primary)
            .frame(maxWidth: .infinity)
            .padding()
            //.background(Color(.systemGray6))
            .cornerRadius(12)
        }
      }
      .padding(.horizontal)
    }
  }
}
