//
//  MainTabItem.swift
//  MovieMania
//
//  Created by Sushant Dhakal on 2025-02-17.
//

import SwiftUI

struct MainTabItem: View {
    private let currentUserDetails : UserDetails
    
    init(currentUserDetails: UserDetails) {
        self.currentUserDetails = currentUserDetails
    }
    var body: some View {
            TabView {
                
                Tab("Home", systemImage: TabItem.home.icon) {
                    NavigationView{
                        HomeView()
                            .toolbarBackground(.visible, for: .tabBar)
                    }
                }
                
                Tab("Favourite", systemImage: TabItem.favourite.icon) {
                    NavigationView{
                        FavouriteListingView()                        .toolbarBackground(.visible, for: .tabBar)
                    }
                }
                Tab("WishList", systemImage: TabItem.watchlist.icon) {
                    NavigationView{
                        WishListView()
                            .toolbarBackground(.visible, for: .tabBar)
                    }
                }
                Tab("Watched", systemImage: TabItem.alreadyWatched.icon) {
                    NavigationView{
                        WatchedListView()                        .toolbarBackground(.visible, for: .tabBar)
                    }
                }
                
                Tab("Setting", systemImage: TabItem.setting.icon) {
                    SettingView()
                        .toolbarBackground(.visible, for: .tabBar)
                }
            }
        
    }
}

extension MainTabItem {
    private enum TabItem:String {
        case home, favourite, watchlist, alreadyWatched, setting
        
        
        fileprivate var icon: String {
            switch self {
            case .home:
                "house.fill"
            case .favourite:
                "heart.fill"
            case .watchlist:
                "bookmark.fill"
            case .alreadyWatched:
                "checkmark.square.fill"
            case .setting:
                "gearshape.fill"
            }
        }
    }
}

#Preview {
    MainTabItem(currentUserDetails: .previewPlaceholder)
}
