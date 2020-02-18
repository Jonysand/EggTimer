//
//  sandglassSandView.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/17/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct sandglassSandView: View {
    @EnvironmentObject var userTimeInfo: timeInfo
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                // upper sand
                sandglassSandSubView(upOrdown: true)
                    .frame(width: geometry.size.width,height: geometry.size.height/2)
                // lower sand
                VStack{
                    sandglassSandSubView(upOrdown: false)
                        .frame(width: geometry.size.width,height: geometry.size.height/2)
                }
            }
            .clipShape(Path{path in
                let height = geometry.size.height
                let width = geometry.size.width
                let curveOffsetPercent:CGFloat = 0.1
                path.move(to: .init(x: width*curveOffsetPercent, y: 0))
                path.addLine(to: .init(x: width * (1-curveOffsetPercent), y: 0))
                path.addQuadCurve(to: .init(x: width*(1-curveOffsetPercent), y: height*(curveOffsetPercent)), control: .init(x: width, y: 0))
                path.addLine(to: .init(x: width*curveOffsetPercent, y: height*(1-curveOffsetPercent)))
                path.addQuadCurve(to: .init(x: width*curveOffsetPercent, y: height), control: .init(x: 0, y: height))
                path.addLine(to: .init(x: width*(1-curveOffsetPercent), y: height))
                path.addQuadCurve(to: .init(x: width*(1-curveOffsetPercent), y: height*(1-curveOffsetPercent)), control: .init(x: width, y: height))
                path.addLine(to: .init(x: width*curveOffsetPercent, y: height*curveOffsetPercent))
                path.addQuadCurve(to: .init(x: width*curveOffsetPercent, y: 0), control: .zero)
            })
                .foregroundColor(.orange)
        }
    }
}

struct sandglassSandView_Previews: PreviewProvider {
    static var previews: some View {
        sandglassSandView().environmentObject(timeInfo())
    }
}
