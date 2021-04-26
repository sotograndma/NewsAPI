//
//  FavoriteNewsList.swift
//  NewsAPI
//
//  Created by Dzaky Saputra on 20/04/21.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteNewsList: View {
  
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: FavoriteNews.entity(), sortDescriptors:
        []) var favoriteNews: FetchedResults<FavoriteNews>
  
    var body: some View {
      NavigationView{
        VStack{
          List{
            ForEach(favoriteNews, id: \.self){item in
              NavigationLink(destination: FavoriteNewsDetail(data: item)){
                HStack{
                  
                  if item.image != ""{
                    WebImage(url: URL(string: item.wrappedImage)!)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 120, height: 170)
                      .background(Image("loader"))
                      .cornerRadius(10)
                  }
                  else{
                    Image("loader")
                      .resizable()
                      .frame(width: 120, height: 170)
                      .cornerRadius(10)
                  }
                  
                  VStack(alignment: .leading, spacing: 10){
                    Text(item.wrappedTitle).fontWeight(.bold)
                    
                    Text(item.wrappedDesc).font(.caption)
                      .lineLimit(4)
                      .multilineTextAlignment(.leading)
                  }
                }
              }
            }.onDelete(perform: deleteNewsList)
          }
        }
        .navigationBarTitle(Text("FavoriteNews"))
      }
    }
  
  private func deleteNewsList(at offsets: IndexSet){
    for index in offsets{
      let favorite = favoriteNews[index]
      moc.delete(favorite)
  
      do{
        try moc.save()
      } catch{
        print(error)
      }
    }
  }
}

struct FavoriteNewsList_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteNewsList()
    }
}
