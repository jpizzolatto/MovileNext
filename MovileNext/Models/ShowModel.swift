//
//  ShowModel.swift
//  MovileNext
//
//  Created by User on 21/06/15.
//  Copyright (c) 2015 JPizzolatto. All rights reserved.
//

import Foundation
import Argo
import Runes

struct Identifiers {
    let trakt : Int
    let slug : String?
    let tvdb : Int?
    let imdb : String?
    let tmdb : Int?
    let tvrange : Int?
}

struct ImageURLS {
    let full : NSURL?
    let medium : NSURL?
    let thumb : NSURL?
}

enum ShowStatus : String {
    case returning = "returning series"
    case inProduction = "in production"
    case canceled = "canceled"
    case ended = "ended"
}

struct Show {
    let title : String
    let ids : Identifiers
    let year : Int
    let overview : String?
    let firstAired : NSDate?
    let homepage : NSURL?
    let runtime : Int?
    let certification : String?
    let network : String?
    let country : String?
    let updatedAt : NSDate?
    let trailer : NSURL?
    let status : ShowStatus?
    let raiting : Float?
    let votes : Int?
    let language : String?
    let genres : [String]?
    let airedEpisodes : Int?
    let imageFanart : ImageURLS?
    let imagePoster : ImageURLS?
    let imageLogo : NSURL?
    let imageClearart : NSURL?
    let imageBanner : NSURL?
    let imageThumb : NSURL?
}
