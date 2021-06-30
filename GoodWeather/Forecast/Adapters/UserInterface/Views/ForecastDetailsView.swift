import SwiftUI
import Combine

struct ForecastDetailsView: View {
    
    @ObservedObject
    var viewModel: ForecastDetailsViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.forecast) { model in
                VStack {
                    HStack {
                        Image(systemName: model.icon)
                            .iconStyle()
                        Spacer()
                        Text(model.description)
                    }
                }
            }
            //.listRowSeparator(.hidden)
            .navigationTitle("Forecast details")
        }

    }
    
}

struct ForecastDetailsView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForecastDetailsView(viewModel: ForecastDetailsViewModel())
    }
    
}
