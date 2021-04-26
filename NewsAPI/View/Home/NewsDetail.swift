//
//  NewsDetail.swift
//  NewsAPI
//
//  Created by Dzaky Saputra on 15/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct NewsDetail: View {
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(entity: FavoriteNews.entity(), sortDescriptors:[]) var favoriteNews: FetchedResults<FavoriteNews>
  
  let news: News
  
  var body: some View{
    ScrollView{
      VStack(alignment: .leading){
        WebImage(url: URL(string: news.image))
          .resizable()
          .aspectRatio(contentMode: .fit)
          .clipped()
        
        VStack(alignment: .leading, spacing: 20){
          Text(news.title)
            .font(.title)
            .fontWeight(.bold)
          Text(news.description)
            .font(.body)
          
          HStack(alignment: .center){
                      if (checkId(id: news.id) == true){
                        Button(action: {
                          self.deleteFavoriteNews(id: news.id)
                          try? self.moc.save()
                        }){
                          HStack{
                            Image(systemName: "trash").foregroundColor(.red)
                            Text("Delete Favorite").foregroundColor(.red)
                          }.padding(7)
                          .cornerRadius(30)
                        }
                      }else{
                        Button(action: {
                          self.addFavoriteNews(data: news)
                          try? self.moc.save()
                        }){
                          HStack{
                            Image(systemName: "heart").foregroundColor(.blue)
                            Text("Add Favorite").foregroundColor(.blue)
                          }.padding(7)
                          .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.blue, lineWidth: 2))
                        }
                      }
                    }
          
        }.padding()
      }
    }
  }
  private func checkId(id: UUID) -> Bool {
    for news in favoriteNews {
      if news.wrappedId == id {
        return true
      }
    }
    return false
  }
  private func deleteFavoriteNews(id: UUID){
    for news in favoriteNews {
      if news.wrappedId == id {
        moc.delete(news)
      }
    }
  }
  
  private func addFavoriteNews(data: News){
    let favorite = FavoriteNews(context: self.moc)
    favorite.id = data.id
    favorite.title = data.title
    favorite.image = data.image
    favorite.desc = data.description
    
  }
  
}
