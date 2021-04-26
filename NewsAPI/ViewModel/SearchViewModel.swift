//
//  SearchViewModel.swift
//  NewsAPI
//
//  Created by Dzaky Saputra on 22/04/21.
//

import SwiftUI
import SwiftyJSON

class SearchViewModel: ObservableObject{
  
  @Published var search = ""
  @Published var news: [News] = []
  @Published var newsFiltered: [News] = []
  
  func filterNews(){
    withAnimation(.linear){
      self.newsFiltered = self.news.filter{
        return $0.title.lowercased().contains(self.search.lowercased())
      }
    }
  }
  
  init(){
    let url = "https://newsapi.org/v2/top-headlines?country=id&category=science&apiKey="
    
    let session = URLSession(configuration: .default)
    
    session.dataTask(with: URL(string: url)!){ (data, _, error) in
      
      if error != nil{
        print((error?.localizedDescription)!)
        return
      }
      
      let json = try! JSON(data: data!)
      let items = json["articles"].array!
      
      for i in items{
        let title = i["title"].stringValue
        let description = i["description"].stringValue
        let image = i["urlToImage"].stringValue
        
        DispatchQueue.main.async {
          self.news.append(News(title: title, image: image, description: description))
        }
      }
    }.resume()
  }
}
