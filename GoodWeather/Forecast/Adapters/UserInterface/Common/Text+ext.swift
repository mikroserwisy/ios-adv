import SwiftUI

extension Text {
    
    func defaultStyle(size: CGFloat = 18) -> some View {
        font(.system(size: size, weight: .medium))
            .foregroundColor(.white)
            .iOS { $0.padding(2) }
    }
    
}
