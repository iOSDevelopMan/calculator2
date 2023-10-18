import SwiftUI

public struct LoaderView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.7)
            ProgressView()
                .scaleEffect(3)
        }
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
    }
}
