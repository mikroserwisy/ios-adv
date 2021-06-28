import SwiftUI

struct DefaultButtonStyle: ButtonStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.blue.opacity(0.5) : Color.blue)
    }
    
}
