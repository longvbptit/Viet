//
//  ChangerIcon.swift
//  FackDay
//
//  Created by Vegeta on 22/03/2021.
//

import Foundation


enum ChangerIconType: Int, CaseIterable {
    case background = 1
    case icon = 2
}

extension ChangerIconType {
    func image(_ isSelect: Bool) -> String {
        switch self {
        case .background: return isSelect ? "bt_bg_select" : "bt_bg"
        case .icon: return isSelect ? "bt_icon_select" : "bt_icon"
        }
    }
}

struct ChangerIcon {
    static let backgrounds: [String] = ["bg1.png","bg2.png","bg3.png","bg4.png","bg5.png","bg6.png","bg7.png","bg8.png","bg9.png","bg10.png","bg11.png","bg12.png","bg13.png","bg14.png","bg15.png","bg16.png","bg17.png","bg18.png","bg19.png","bg20.png","bg21.png","bg22.png","bg23.png","bg24.png","bg25.png","bg26.png","bg27.png","bg28.png","bg29.png","bg30.png","bg31.png","bg32.png","bg33.png","bg34.png","bg35.png","bg36.png","bg37.png","bg38.png","bg39.png","bg40.png","bg41.png","bg42.png","bg43.png","bg44.png","bg45.png","bg46.png","bg47.png","bg48.png","bg49.png","bg50.png","bg51.png","bg52.png","bg53.png"]
    
    static let icons: [String] = ["ic1.png","ic2.png","ic3.png","ic4.png","ic5.png","ic6.png","ic7.png","ic8.png","icon9.png","icon10.png","icon11.png","icon12.png","icon13.png","icon14.png","icon15.png","icon16.png","icon17.png","icon18.png","icon19.png","icon20.png","icon21.png","icon22.png","icon23.png","icon24.png","icon25.png","icon26.png","icon27.png","icon28.png","icon29.png","icon30.png","icon31.png","icon32.png","icon33.png"]
    
}
