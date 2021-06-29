import SwiftUI
import Resolver

struct ForecastView: View {
    
    @ObservedObject
    var viewModel : ForecastViewModel

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("Black")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                Spacer()
                if let currentForecast = viewModel.currentForecast{
                    Image(systemName: currentForecast.icon)
                        .iconStyle(width: 200, height: 200)
                    Text(currentForecast.description)
                        .defaultStyle(size: 32)
                        .padding(.bottom, 48)
                    HStack(spacing: 48) {
                        Text(currentForecast.temperature)
                            .defaultStyle(size: 32)
                        Text(currentForecast.pressure)
                            .defaultStyle(size: 32)
                    }
                }
                Spacer()
                HStack(spacing: 16) {
                    ForEach(viewModel.nextDaysForecast, id: \.date, content: DayForecastView.init)
                }
                Spacer()
            }
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    static var previews: some View {
        ForecastView(viewModel: ForecastViewModel(getForecastUseCase: GetForecastService(forecastProvider: FakeForecastProvider())))
    }
}
