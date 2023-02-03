//
//  SideMenuViewModel.swift
//  MovieHub
//
//  Created by Atchu on 3/2/23.
//

import Foundation

class SideMenuViewModel: SideMenuViewModelContract {
    
    var menuItems = [SideMenu(title: "Popular"),
                     SideMenu(title: "Top Rated"),
                     SideMenu(title: "Upcoming"),
                     SideMenu(title: "Now Playing")]
    
    func getValueFromIndexPath(index: Int) -> String {
        return menuItems[index].title
    }
}
