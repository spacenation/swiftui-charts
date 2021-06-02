//
//  SwiftUIView.swift
//  
//
//  Created by Alexander Heinrich on 29.03.21.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            
            HStack(alignment: .bottom) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 50, height: 100, alignment: .bottomLeading)
                    .offset(x: 0, y: 100)
                
                
                Rectangle()
                    .fill(Color.blue)
                    .frame(width: 50, height: 50, alignment: .bottomLeading)
                    
                
                Rectangle()
                    .fill(Color.green)
                    .frame(width: 50, height: 100, alignment: .bottomLeading)
                    
                
                Rectangle()
                    .fill(Color.yellow)
                    .frame(width: 50, height: 120, alignment: .bottomLeading)
                
                Spacer()
                    
            }
            

        }
        .frame(width: 500, height: 500)
        .background(Color.gray)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
