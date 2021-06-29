import SwiftUI

struct ProfileView: View {
    
    @State
    var text = ""
    @State
    var dob = Date()
    @State
    var sub = false
    @State
    var errors = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal info")) {
                    TextField("First name", text: $text)
                    TextField("Last name", text: $text)
                    TextField("Email name", text: $text)
                        .keyboardType(.emailAddress)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $text)
                    SecureField("Password confirmation", text: $text)
                    DatePicker("Birthday", selection: $dob, displayedComponents: .date)
                    Toggle("Subscriber", isOn: $sub)
                        .toggleStyle(SwitchToggleStyle(tint: .primary))
                }
                if sub {
                    Section(header: Text("Payment info")) {
                        TextField("Credit card", text: $text)
                        TextField("CVV", text: $text)
                        DatePicker("Expiration date", selection: $dob, displayedComponents: .date)
                    }
                }
                if errors {
                    Text("Please fill the form corectly")
                        .foregroundColor(.red)
                }
            }
            .navigationTitle("Profile")
        }
    }
    
}

struct ProfileView_Previews: PreviewProvider {
    
    static var previews: some View {
        ProfileView()
    }
    
}
