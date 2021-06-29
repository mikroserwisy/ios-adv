import SwiftUI
import Resolver

struct ForecastView: View {
    
    @ObservedObject
    var viewModel: ForecastViewModel
    @State
    var showSettings = false
    @AppStorage("cityName")
    private var storedCityName = ""

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("Blue"), Color("Black")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack {
                HStack {
                    Image(systemName: "location")
                        .templateStyle(width: 20, height: 20)
                        .onTapGesture { viewModel.refreshForecastForCurrentLocation() }
                    Spacer()
                    Image(systemName: "slider.horizontal.3")
                        .templateStyle(width: 20, height: 20)
                        .onTapGesture { showSettings = true }
                        .accessibility(identifier: "settings")
                }
                .padding()
                Text(viewModel.cityName)
                    .defaultStyle(size: 32)
                    .accessibility(identifier: "city")
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
        .sheet(isPresented: $showSettings) { SettingsView() }
        .onChange(of: storedCityName, perform: viewModel.refreshForecast(for:))
        //.onAppear { viewModel.refreshForecast(for: storedCityName) }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            viewModel.refreshForecast(for: storedCityName) 
        }
        .alert(isPresented: $viewModel.errors) {
            Alert(title: Text("Alert"),
                  message: Text("Weather refresh failed"),
                  dismissButton: .default(Text("Close")))
        }
    }
}

struct ForecastView_Previews: PreviewProvider {
    
    static var previews: some View {
        ForecastView(viewModel: ForecastViewModel())
    }
    
}
