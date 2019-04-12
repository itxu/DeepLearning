//
//  NetworkTool.swift
//  Donghong
//
//  Created by Donghong on 2019/2/26.
//  Copyright © 2019 Donghong. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD
import HandyJSON

protocol NetworkToolProtocol {
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ())
    static func loadRelationUserRecommend(user_id: Int,completionHandler: @escaping (_ sections: [UserCard]) -> ())
    static func loadUserDetail(user_id: Int,completionHandler: @escaping (_ userDetail: UserDetail) -> ())
    static func loadRelationUnfollow(user_id: Int,completionHandler: @escaping (_ users: ConcernUser) -> ())
    static func loadRelationFollow(user_id: Int,completionHandler: @escaping (_ user: ConcernUser) -> ())
    static func loadHomeNewsTitleData(completionHandler: @escaping(_ newsTitle: [HomeNewsTitle]) -> ())
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ())
    static func loadHomeSearchSuggestInfo(completionHandler: @escaping(_ suggestInfo: String) -> ())
    static func loadUserDetailDongtaiList(user_id: Int,completionHandler: @escaping (_ sections: [UserDetailDongtai]) -> ())
}

struct NetworkTool: NetworkToolProtocol {
  
    static func loadUserDetail(user_id userId: Int, completionHandler: @escaping (_ userDetail: UserDetail) -> ()) {
        
        let url = BASE_URL + "/user/profile/homepage/v4/?"
        let params = ["user_id": userId,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            // 网络错误的提示信息
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                completionHandler(UserDetail.deserialize(from: json["data"].dictionaryObject)!)
            }
        }
    }

    
    
    static func loadMyCellData(completionHandler: @escaping (_ sections: [[MyCellModel]]) -> ()) {
    let url = BASE_URL + "/user/tab/tabs/?"
    let params = ["device_id": device_id]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                //let sections = json["data"]["sections"][0][0]["text"]
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    if let sections = data["sections"]?.array {
                        var sectionArray = [[MyCellModel]]()
                        for item in sections {
                            var rows = [MyCellModel]()
                            for row in item.arrayObject! {
                                let myCellModel = MyCellModel.deserialize(from: row as? NSDictionary)
                                rows.append(myCellModel!)
                                
                            }
                            sectionArray.append(rows)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    
    
    static func loadRelationUserRecommend(user_id: Int,completionHandler: @escaping (_ sections: [UserCard]) -> ()) {
        let url = BASE_URL + "/user/relation/user_recommend/v1/supplement_recommends/?"
        let params = ["device_id": device_id,
                      "follow_user_id": user_id,
                      "iid": iid,
                      "scene": "follow",
                      "source": "follow"] as [String: Any]
        
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["err_no"] == 0 else {
                    return
                }
                if let user_cards = json["user_cards"].arrayObject {
                    completionHandler(user_cards.compactMap({
                        UserCard.deserialize(from: $0 as? NSDictionary)
                    }))
                }
            }
        }
    }
    
    static func loadUserDetailDongtaiList(user_id: Int,completionHandler: @escaping (_ sections: [UserDetailDongtai]) -> ()) {
        let url = BASE_URL + "/dongtai/list/v15/?"
        let params = ["user_id":user_id]
        
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                        if let datas = data["data"]?.arrayObject {
                            completionHandler(datas.compactMap({
                                UserDetailDongtai.deserialize(from: $0 as? NSDictionary)
                            }))
                        }
                }
            }
        }
    }

    
   
    static func loadRelationUnfollow(user_id: Int,completionHandler: @escaping (_ user: ConcernUser) -> ()) {
        let url = BASE_URL + "/2/relation/unfollow"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                
                if let data = json["data"].dictionaryObject {
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(user!)
                }
            }
        }
    }
    
    static func loadMyConcern(completionHandler: @escaping (_ concerns: [MyConcern]) -> ()) {
        let url = BASE_URL + "/concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else { return }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else { return }
                if let datas = json["data"].arrayObject {
                    completionHandler(datas.compactMap({
                        MyConcern.deserialize(from: $0 as? NSDictionary)
                    }))
                }
            }
        }
        
    }
    
    
    
    static func loadRelationFollow(user_id: Int,completionHandler: @escaping (_ user: ConcernUser) -> ()) {
        let url = BASE_URL + "/2/relation/follow/v2/?"
        let params = ["user_id": user_id,
                      "device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    if let data = json["data"].dictionaryObject {
                        SVProgressHUD.showInfo(withStatus: data["description"] as? String)
                        SVProgressHUD.setForegroundColor(.white)
                        SVProgressHUD.setBackgroundColor(UIColor(r: 0, g: 0, b: 0, alpha: 0.3))
                        return
                    }
                    return
                }
                
                if let data = json["data"].dictionaryObject {
                    let user = ConcernUser.deserialize(from: data["user"] as? NSDictionary)
                    completionHandler(user!)
                }
            }
        }
    }
    
    static func loadHomeNewsTitleData(completionHandler: @escaping(_ newsTitle: [HomeNewsTitle]) -> ()) {
        let url = BASE_URL + "/article/category/get_subscribed/v1/?"
        let params = ["device_id": device_id, "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let dataDict = json["data"].dictionary {
                    if let data = dataDict["data"]?.arrayObject {
                        var titles = [HomeNewsTitle]()
                        let jsonString = "{\"category:\": \"\", \"name\": \"推荐\"}"
                        let recommend = HomeNewsTitle.deserialize(from: jsonString)
                        titles.append(recommend!)
                        for item in data {
                            let newsTitle = HomeNewsTitle.deserialize(from: item as? NSDictionary)
                            titles.append(newsTitle!)
                        }
                        completionHandler(titles)
                    }
                }
            }
        }
    }
    
    
    
    static func loadHomeSearchSuggestInfo(completionHandler: @escaping(_ suggestInfo: String) -> ()) {
        let url = BASE_URL + "/search/suggest/homepage_suggest/?"
        let params = ["device_id": device_id,
                      "iid": iid]
        
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"] == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    completionHandler(data["homepage_search_suggest"]!.string!)
                }
            }
        }
    }
    
}


