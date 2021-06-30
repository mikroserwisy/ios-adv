import SwiftUI
import Resolver

struct RouterView: View {
    
    @EnvironmentObject
    var router: Router

    var body: some View {
        switch router.route {
        case .forecast:
            ForecastView(viewModel: ForecastViewModel())
        case .forecastDetails:
            ForecastDetailsView(viewModel: ForecastDetailsViewModel())
        }
    }
    
}

struct RouterView_Previews: PreviewProvider {
    
    static var previews: some View {
        RouterView()
    }
    
}
