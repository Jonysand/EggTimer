//
//  sandglassView.swift
//  EggTimer
//
//  Created by Yongkun Li on 2/17/20.
//  Copyright © 2020 Yongkun Li. All rights reserved.
//

import SwiftUI

struct sandglassView: View {
    @EnvironmentObject var userTimeInfo: timeInfo
    
    var sandglassShape: some View{
        sandglassBodyView()
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                // sand
                sandglassSandView().environmentObject(self.userTimeInfo)
                
                // main body
                sandglassBodyView()
            }
        }
        
    }
}

struct sandglassView_Previews: PreviewProvider {
    static var previews: some View {
        sandglassView().environmentObject(timeInfo())
    }
}
