//
//  ContentView.swift
//  FieldValidators
//
//  Created by John Bethancourt on 1/5/21.
//

import SwiftUI
import Combine

/// Creates a custom ICAO text field with validation highlighting and prevention of illegal values
///
/// - Parameters:
///   - text: A bindable string
///
struct ICAOTextField: View {
    
    @Binding var text: String
    
    var body: some View {
        TextField("ICAO", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .foregroundColor(text.isValidICAO() ? .green : .red)
            .padding()
            //Subscribe to a Just publisher of our own icao value
            .onReceive(Just(text)) { newValue in
                var value = String(newValue.uppercased().prefix(4)) // uppercased and no more than 4 characters
                let set = CharacterSet(charactersIn: "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                value = value.components(separatedBy: set.inverted).joined() // prevent anything but the set
                if value != newValue {
                    self.text = value
                }
            }
    }
}
 
struct ContentView: View {
    
    @State var toICAO = ""
    @State var fromICAO = ""
    @State var allDone = false
    
    var body: some View {
        
        ZStack{
            
            VStack{
                
                ICAOTextField(text: $toICAO) // implementation up there 👆
                
                ICAOTextField(text: $fromICAO)  // implementation up there 👆
                
                HStack{
                    Button(action: { allDone = true  }) { Text("Submit") }
                        .padding(22)
                    .disabled(!toICAO.isValidICAO() || !fromICAO.isValidICAO()) // Submit button enabled only if both ICAOs are valid
                    Spacer()
                    Button(action: { allDone = false;  toICAO = ""; fromICAO = ""}) { Text("Reset") } // RESET
                        .padding(22)
                  
                }
                Spacer()
                 
            }
            
            // A suprise if you click the Submit button
            if allDone { Surprise() }
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
