//
//  BottomSheet.swift
//  tax-mate
//
//  Created by Stephen Yao on 8/4/2022.
//

import Foundation
import SwiftUI
import Introspect

struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    @State private var opacity: Double = 0
    @State private var offset: Double = 250
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(opacity)
                .onTapGesture {
                    withAnimation {
                        self.opacity = 0
                        self.offset = 250
                        self.isPresented.toggle()
                    }
                }
            RoundedRectangle(cornerRadius: 25.0)
                .foregroundColor(.white)
                .frame(height: 250)
                .frame(maxWidth: .infinity)
                .offset(y: offset)
                .overlay {
                    self.content().opacity(self.opacity)
                }
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation(.easeOut) {
                self.opacity = 0.75
                self.offset = 0
            }
        }
        .background(Color.red)
    }
}

extension View {
    public func bottomSheet<A>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> A) -> some View where A : View {
        return ZStack {
            self
            if isPresented.wrappedValue {
                BottomSheet(isPresented: isPresented, content: content)
            }
        }
    }
}

struct BottomSheetPreviewDemo: View {
    @State var showsSheet = false
    
    var body: some View {
        Button {
            self.showsSheet = true
        } label: {
            Text("Toggle Sheet")
        }
        .bottomSheet(isPresented: $showsSheet) {
            Text("Bottom sheet content")
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetPreviewDemo()
    }
}
