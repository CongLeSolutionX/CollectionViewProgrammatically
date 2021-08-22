//
//  CardsData.swift
//  CollectionViewProgrammatically
//
//  Created by Cong Le on 8/21/21.
//

import UIKit

final class CardsData {
  static let instance = CardsData()
  
  class var shared: CardsData {
    return instance
  }
  
  let json: [String: Any]
  
  var cards: [CardViewModel] {
    return parseCards(forJson: json)
  }
  
  init() {
    guard let cardsUrl = Bundle.main.url(forResource: "CardsData", withExtension: "json") else {
      json = [:]
      return
    }
    
    do {
      let  cardsData = try Data(contentsOf: cardsUrl)
      if let cardsJson = try JSONSerialization.jsonObject(with: cardsData, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
        json = cardsJson
      } else {
        json = [:]
        print("[LOG] Error parsing CardsData.json data")
      }
    } catch {
      json = [:]
      print("[LOG] Error parsing .json data")
    }
  }
  
  // MARK: - Parse cards -
  func parseCards(forJson jsoon: [String: Any]) -> [CardViewModel] {
    guard let cardsData = json["cardTitles"] as? [[String: Any]] else { return [] }
    let cards = cardsData.compactMap { (cardsDictionary) -> CardViewModel? in
      guard let cardTypeString = cardsDictionary["type"] as? String else { return nil }
      
      let bgImageString = cardsDictionary["backgroundImage"] as? String
      let bgTypeString = cardsDictionary["backgroundType"] as? String
      let bgType = BackgroundType(rawValue: bgTypeString ?? "")
      let title = cardsDictionary["title"] as? String
      let subtitle = cardsDictionary["subtitle"] as? String
      let description = cardsDictionary["description"] as? String
      let apps = cardsDictionary["apps"] as? [[String: String]]
      
      switch cardTypeString {
      case "appOfTheDay":
        guard let bgImge = UIImage(named: bgImageString ?? "card1"),
              let app = apps?.first,
              let appViewModel = parseApp(for: app, viewType: AppViewType.featured) else { break }
        let cardType = CardViewType.appOfTheDay(bgImage: bgImge, bgType: bgType, app: appViewModel)
        return CardViewModel(viewType: cardType)
        
      case "appCollection":
        guard let title = title,
              let subtitle = subtitle,
              let apps = apps else { break }
        
        let appViewModels = apps.compactMap {
          parseApp(for: $0, viewType: AppViewType.horizontal)
        }
        
        let cardType = CardViewType.appCollection(apps: appViewModels, title: title, subtitle: subtitle)
        return CardViewModel(viewType: cardType)
        
      case "appArticle":
        guard let bgImage = UIImage(named: bgImageString ?? "card1"),
              let title = title,
              let subtitle = subtitle,
              let app = apps?.first,
              let appViewModel = parseApp(for: app, viewType: AppViewType.none),
              let desctiption =  description else { break }
        
        let cardType = CardViewType.appArticle(bgImage: bgImage, bgType: bgType, title: title, subtitle: subtitle, description: desctiption, app: appViewModel)
        
        return CardViewModel(viewType: cardType)
      default:
        return nil
      }
      return nil
    }
    return cards
  }
  
  // MARK: - Parse Apps -
  func parseApp(for Json: [String: String], viewType: AppViewType) -> AppViewModel? {
    guard let name = Json["name"],
          let tagline = Json["tagline"],
          let categoryString = Json["category"],
          let costString = Json["cost"],
          let iconName = Json["iconName"],
          let image = UIImage(named: iconName),
          let hasInAppPurchase = Json["hasInAppPurchase"]?.boolValue(),
          let alreadyPurchased = Json["alreadyPurchsed"]?.boolValue(),
          let onDevice = Json["onDevice"]?.boolValue() else
    { return nil }
    
    return AppViewModel(
      name: name,
      tagline: tagline,
      category: categoryString,
      cost: Cost.cost(fromString: costString),
      hasInAppPurchase: hasInAppPurchase,
      alreadyPurchased: alreadyPurchased,
      isOnDevice: onDevice,
      iconImage: image,
      appViewType: viewType
    )
  }
}
