//
//  BottomSheet.swift
//  tax-mate
//
//  Created by Stephen Yao on 8/4/2022.
//

import Foundation
import SwiftUI

struct BottomSheetView<Content: View>: View {
    @Binding var isPresented: Bool
    @ViewBuilder var content: () -> Content
    var onDismiss: (() -> Void)?
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
                .overlay(content: content)
                .offset(y: offset)
        }
        .ignoresSafeArea()
        .background(.clear)
        .onAppear {
            withAnimation(.easeOut) {
                self.opacity = 0.75
                self.offset = 0
            }
        }
    }
}

extension View {
    var keyWindow: UIWindow {
        UIApplication
        .shared
        .connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
        .first { $0.isKeyWindow }!
    }
    
    public func bottomSheet<A>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> A) -> some View where A : View {
        if !isPresented.wrappedValue {
            if let root = keyWindow.rootViewController {
                UIView.animate(withDuration: 0.3) {
                    root.presentedViewController?.view.alpha = 0
                } completion: { _  in
                    root.presentedViewController?.dismiss(animated: false, completion: nil)
                }
            }
            return self
        } else {
            if let root = keyWindow.rootViewController {
                guard root.presentedViewController == nil else {
                    return self
                }                
                let bottomSheetViewController = UIHostingController(rootView: BottomSheetView(isPresented: isPresented, content: content))
                bottomSheetViewController.view.backgroundColor = .clear
                bottomSheetViewController.modalPresentationStyle = .custom
                root.present(bottomSheetViewController, animated: false, completion: nil)
            }
            return self
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
