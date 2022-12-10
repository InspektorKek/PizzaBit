//
//  PointsView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 09/12/22.
//

import SwiftUI

struct PointsView: View {
    var body: some View {
        ZStack {
            Image("PointsZone")
            HStack {
                VStack(alignment: .trailing){
                    
                    Text("Hits")
                        .font(.custom("PixelatedPusab", size: 40))
                        .foregroundColor(Color("Dough"))
                    Text("0")
                        .font(.custom("Blocktopia", size: 40))
                        .foregroundColor(Color("Dough"))
                       
                    
                }
                } .shadow(color: Color(uiColor: .label), radius: 0,x:1, y: 1)
                    .shadow(color: Color(uiColor: .label), radius: 0,x:-1, y: -1)
           
        }
    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView()
    }
}
