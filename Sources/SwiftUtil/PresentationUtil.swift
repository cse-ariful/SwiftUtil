//
//  SheetState.swift
//
//  Created by Ariful Jannat Arif on 11/30/23.
//

import SwiftUI

/// A generic type representing a boolean value that can also hold associated data of type `T`.
public struct SheetState<T: Equatable>: DynamicProperty, Equatable {
    public static func == (lhs: SheetState<T>, rhs: SheetState<T>) -> Bool {
        return lhs.value == rhs.value
    }

    /// The associated data of type `T`.
    public var value: T?

    /// Toggles the boolean value and sets the associated data.
    public mutating func toggle(with data: T) {
        self.value = data
    }
    
    public init(value: T? = nil) {
        self.value = value
    }
}

/// A view modifier for presenting a sheet based on the state of a `SheetState<T>` binding.
 
struct SheetModifier<V: View, T: Equatable>: ViewModifier {
    /// Binding to a `SheetState<T>` value that determines the presentation state of the sheet.
    @Binding var data: SheetState<T>
    
    /// Flag indicating whether the sheet is currently presented.
    @State var present = false
    
    /// Closure providing the content of the sheet based on associated data of type `T`.
    var sheetContent: (T) -> V
    
    /// Modifies the content view to present a sheet when the binding's value is true.
    /// - Parameter content: The content view to be modified.
    /// - Returns: A modified view with sheet presentation behavior.
    func body(content: Content) -> some View {
        content
            .sheet(
                isPresented: $present,
                onDismiss: { data.value = nil }
            ) {
                if let data = data.value {
                    self.sheetContent(data)
                } else {
                    EmptyView()
                }
            }
            .onChange(of: data) { newValue in
                self.present = newValue.value != nil
            }
    }
}

/// A view modifier for presenting a full-screen cover based on the state of a `SheetState<T>
struct FullScreenCover<V: View, T: Equatable>: ViewModifier {
    /// Binding to a `SheetState<T>` value that determines the presentation state of the full-screen cover.
    @Binding var data: SheetState<T>
    
    /// Flag indicating whether the full-screen cover is currently presented.
    @State var present = false
    
    /// Closure providing the content of the full-screen cover based on associated data of type `T`.
    var sheetContent: (T) -> V

    /// Modifies the content view to present a full-screen cover when the binding's value is true.
    /// - Parameter content: The content view to be modified.
    /// - Returns: A modified view with full-screen cover presentation behavior.
    func body(content: Content) -> some View {
        content
            .fullScreenCover(
                isPresented: $present,
                onDismiss: { data.value = nil }
            ) {
                if let data = data.value {
                    self.sheetContent(data)
                } else {
                    EmptyView()
                }
            }
            .onChange(of: data) { newValue in
                self.present = newValue.value != nil
            }
    }
}

extension View {
    /// Presents a sheet based on the state of a `SheetState<T>` binding.
    /// - Parameters:
    ///   - isPresented: Binding to a `SheetState<T>` value determining the presentation state.
    ///   - content: A closure providing the content of the sheet based on associated data of type `T`.
    /// - Returns: A modified view with sheet presentation behavior.
    public func sheet<V: View, T>(isPresented: Binding<SheetState<T>>, @ViewBuilder content: @escaping (_ value: T) -> V) -> some View {
        self.modifier(SheetModifier(data: isPresented, sheetContent: content))
    }
    
    /// Presents a full-screen cover based on the state of a `SheetState<T>` binding.
    /// - Parameters:
    ///   - isPresented: Binding to a `SheetState<T>` value determining the presentation state.
    ///   - content: A closure providing the content of the full-screen cover based on associated data of type `T`.
    /// - Returns: A modified view with full-screen cover presentation behavior.
    public func fullScreenCover<V: View, T>(isPresented: Binding<SheetState<T>>, @ViewBuilder content: @escaping (_ value: T) -> V) -> some View {
        self.modifier(FullScreenCover(data: isPresented, sheetContent: content))
    }
}





