//
//  ContentView.swift
//  NewsAPI
//
//  Created by Dzaky Saputra on 15/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    var body: some View {
      TabView{
        NewsList()
          .tabItem{
            Image(systemName: "house.fill")
            Text("News")
          }
        SearchList()
          .tabItem{
            Image(systemName: "magnifyingglass")
            Text("Search")
          }
        FavoriteNewsList()
          .tabItem{
            Image(systemName: "heart")
            Text("Favorite")
          }
        Profile()
          .tabItem{
            Image(systemName: "person.fill")
            Text("About")
          }
      }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
