import SwiftUI

struct ProfileView: View {
    
    @ObservedObject
    var viewModel: ProfileViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal info")) {
                    TextField("First name", text: $viewModel.firstName)
                    TextField("Last name", text: $viewModel.lastName)
                    TextField("Email name", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .disableAutocorrection(true)
                    SecureField("Password", text: $viewModel.password)
                    SecureField("Password confirmation", text: $viewModel.passwordConfirmation)
                    DatePicker("Birthday", selection: $viewModel.birthday, displayedComponents: .date)
                    Toggle("Subscriber", isOn: $viewModel.subscriber)
                        .toggleStyle(SwitchToggleStyle(tint: .primary))
                }
                if viewModel.subscriber {
                    Section(header: Text("Payment info")) {
                        TextField("Credit card", text: $viewModel.cardNumber)
                        TextField("CVV", text: $viewModel.cardCvv)
                        DatePicker("Expiration date", selection: $viewModel.cardExpirationDate, displayedComponents: .date)
                    }
                }
                if !viewModel.isFormValid {
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
        ProfileView(viewModel: ProfileViewModel())
    }
    
}
