import SwiftUI

struct SettingsView: View {
    
    @State
    var cityName = ""
    @Environment(\.presentationMode)
    var presentationMode
    @AppStorage("cityName")
    private var storedCityName = ""

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: { self.presentationMode.wrappedValue.dismiss() } , label: {closeButton })
                    .accessibility(identifier: "close")
            }
            .padding(.top, 6)
            Form {
                Section(header: Text("Place")) {
                    TextField("Enter city name", text: $cityName)
                }
            }
        }
        .onAppear {  cityName = storedCityName }
        .onDisappear { storedCityName = cityName } 
    }
    
    private var closeButton: some View {
        Image(systemName: "xmark.circle")
            .templateStyle(width: 20, height: 20, color: .gray)
            .buttonStyle(DefaultButtonStyle())
            .padding(EdgeInsets(top: 2, leading: 0, bottom: 0, trailing: 6))
    }

}

struct SettingsView_Previews: PreviewProvider {

    static var previews: some View {
        SettingsView()
    }
    
}
