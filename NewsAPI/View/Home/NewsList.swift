//
//  NewsList.swift
//  NewsAPI
//
//  Created by Dzaky Saputra on 15/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsList: View {
  @ObservedObject var newsViewModel = NewsViewModel()
  
    var body: some View {
      NavigationView{
        List(newsViewModel.data){ item in
          NavigationLink(destination: NewsDetail(news: item)) {
            HStack{
              
              if item.image != ""{
                WebImage(url: URL(string: item.image)!)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 120, height: 170)
                  .background(Image("loader")

                                .aspectRatio(contentMode: .fill)
                                )
                  .cornerRadius(10)
              }
              else{
                Image("loader")
                  .resizable()
                  .frame(width: 120, height: 170)
                  .cornerRadius(10)
              }
              
              VStack(alignment: .leading, spacing: 10){
                Text(item.title).fontWeight(.bold)
                
                Text(item.description).font(.caption)
                  .lineLimit(4)
                  .multilineTextAlignment(.leading)
              }
            }
          }
        }
        .navigationBarTitle(Text("News"))
      }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct NewsList_Previews: PreviewProvider {
    static var previews: some View {
        NewsList()
    }
}
