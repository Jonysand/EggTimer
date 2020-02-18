//
//  digitView.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/17/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct digitView: View{
    let degree: Double
    let strokeColor: Color
    
    var body: some View {
        // clock shape
        //        ZStack{
        //            GeometryReader{ geometry in
        //                Path{ path in
        //                    path.move(to: .init(x: geometry.size.width/2, y: geometry.size.height/2))
        //                    path.addArc(center: .init(x: geometry.size.width/2, y: geometry.size.height/2), radius: geometry.size.width/2, startAngle: .degrees(-90), endAngle: .degrees(-90+self.degree), clockwise: false)
        //                    }
        //                .foregroundColor(self.strokeColor.opacity(0.6))
        //            }
        //            Circle()
        //                .stroke(strokeColor, lineWidth: 5)
        //        }
        
        // arrow shape
        GeometryReader{ geo in
            VStack{
                Path{path in
                    path.move(to: .init(x: geo.size.width/2, y: 0))
                    path.addLine(to: .init(x: geo.size.width, y: geo.size.height))
                    path.addLine(to: .init(x: 0, y: geo.size.height))
                }
            }.foregroundColor(self.strokeColor)
        }
    }
}

struct digitView_Previews: PreviewProvider {
    static var previews: some View {
        digitView(degree: 90, strokeColor: .orange)
    }
}
