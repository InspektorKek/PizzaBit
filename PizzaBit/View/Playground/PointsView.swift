//
//  PointsView.swift
//  PizzaBit
//
//  Created by Sarah Ndenbe on 09/12/22.
//

import SwiftUI

struct PointsView: View {
    @State var combo : String  = "000"
    @State var best : String = "999"
    @State var score : String = "090"
    
    var body: some View {
        ZStack {
            Image("PointsZone")
            VStack(alignment: .trailing, spacing: 0){
                
                
                HStack {
                    Text("COMBO")
                        .font(.custom("IsWasted", size: 22))
                        .foregroundColor(Color("Dough"))
                        
                    Spacer()
                    
                    Text(combo)
                        .font(.custom("Blocktopia", size: 45))
                        .foregroundColor(Color("Dough"))
                        
                }.padding(.leading,56)
                    .padding(.top)
                    .shadow(color: Color(uiColor: .systemPurple), radius:0,x:0.75, y: 0.25)
                    .shadow(color: Color(uiColor: .systemGreen), radius:0,x:-0.75, y: -0.25)
                    .shadow(color: Color(uiColor: .label), radius: 0,x:0.5, y: 0.5)
                    .shadow(color: Color(uiColor: .label), radius: 0,x:-0.5, y: -0.5)
                    .shadow(color: Color(uiColor: .systemPurple), radius: 0,x:1, y: 1)
                    .frame(width: 230)
                
                HStack{
                    
                    HStack {
                        Image("0tomato")
                            .resizable()
                            .frame(width: 30,height: 30)
                            .scaledToFill()
                            .padding(.bottom,5)
                        
                        Text(score)
                            .font(.custom("Blocktopia", size: 25))
                            .foregroundColor(Color(uiColor: .label))
                            .shadow(color: Color(uiColor: .systemGreen), radius:0,x:-1)
                        
                    }
                    
                    
                    Spacer()
                    HStack {
                        Text("BEST \(best)")
                    }
                    .shadow(color: Color(uiColor: .systemPurple), radius:0,x:-1, y: 0)
                    .foregroundColor(Color(uiColor: .label))
                    .font(.custom("Blocktopia", size: 25))
                    .shadow(color:Color(uiColor: .white), radius:0,x:1)
                    
                    
                }.frame(width: 230)
            }
            
        }
        .frame(width: 250)
    }
}

struct PointsView_Previews: PreviewProvider {
    static var previews: some View {
        PointsView()
    }
}
