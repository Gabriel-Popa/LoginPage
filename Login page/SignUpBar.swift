//
//  LoginBar.swift
//  Login page
//
//  Created by Andrei-Gabriel Popa on 17.12.2022.
//

import SwiftUI

struct SignUpBar: View {
    var body: some View {
        
            RoundedRectangle(cornerRadius: 50)
                .padding(.horizontal, 30.0)
                .scaledToFit()
                .foregroundColor(.white)
                .shadow(radius: 3)
    }
}

struct SignUpBar_Previews: PreviewProvider {
    static var previews: some View {
        SignUpBar()
    }
}
