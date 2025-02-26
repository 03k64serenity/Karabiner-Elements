import SwiftUI

struct ProfilesView: View {
  @ObservedObject private var settings = Settings.shared
  @State private var showingSheet = false
  @State private var editingProfile: Profile?

  var body: some View {
    VStack(alignment: .leading, spacing: 12.0) {
      List {
        VStack(alignment: .leading, spacing: 0.0) {
          ForEach($settings.profiles) { $profile in
            HStack(alignment: .center, spacing: 0) {
              Text(profile.name)

              Button(action: {
                editingProfile = profile
                showingSheet = true
              }) {
                Label("Edit", systemImage: "pencil")
              }
              .padding(.leading, 12.0)

              Spacer()

              if profile.selected {
                Label("Selected", systemImage: "checkmark.square")
              } else {
                Button(action: {
                  settings.selectProfile(profile)
                }) {
                  Label("Select", systemImage: "square")
                }
              }
            }
            .padding(.vertical, 12.0)
            .padding(.horizontal, profile.selected ? 12.0 : 0)
            .overlay(
              RoundedRectangle(cornerRadius: 8)
                .stroke(
                  Color(NSColor.selectedControlColor),
                  lineWidth: profile.selected ? 3 : 0
                )
                .padding(2)
            )

            Divider()
          }

          Spacer()
        }
      }
      .background(Color(NSColor.textBackgroundColor))

      Button(action: {
        settings.appendProfile()
      }) {
        Label("Add new profile", systemImage: "plus.circle.fill")
      }
    }
    .padding()
    .sheet(isPresented: $showingSheet) {
      ProfileEditView(profile: $editingProfile, showing: $showingSheet)
    }
  }
}

struct ProfilesView_Previews: PreviewProvider {
  static var previews: some View {
    ProfilesView()
  }
}
