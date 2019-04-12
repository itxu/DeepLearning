//
//  SQLiteManager.swift
//  Donghong
//
//  Created by Donghong on 2019/3/14.
//  Copyright © 2019 Donghong. All rights reserved.
//

import Foundation
import SQLite

struct SQLiteManager {
    var database: Connection!
    
    init() {
        do {
            let path = NSHomeDirectory() + "/Documents/news.sqlite3"
            database = try Connection(path)
        } catch {
            print(error)
        }
    }
}

struct NewsTitleTable {
    private let sqlManager = SQLiteManager()
    
    private let news_title = Table("new_title")
    
    let id = Expression<Int64>("id")
    let category = Expression<String>("category")
    let tip_new = Expression<Int64>("tip_new")
    let default_add = Expression<Int64>("default_add")
    let web_url = Expression<String>("web_url")
    let concern_id = Expression<String>("concern_id")
    let icon_url = Expression<String>("icon_url")
    let flags = Expression<Int64>("flags")
    let type = Expression<Int64>("type")
    let name = Expression<String>("name")
    let selected = Expression<Bool>("selected")
    
    init() {
        do {
            try sqlManager.database.run(news_title.create(ifNotExists: true, block: { t in
                t.column(id, primaryKey: true)
                t.column(category)
                t.column(tip_new)
                t.column(default_add)
                t.column(web_url)
                t.column(concern_id)
                t.column(icon_url)
                t.column(flags)
                t.column(type)
                t.column(name)
                t.column(selected)
            }))
        } catch {
            print(error)
        }
    }
    
    
    func insert(_ titles: [HomeNewsTitle]) {
        for title in titles {
            insert(title)
        }
    }
    
    func insert(_ title: HomeNewsTitle) {
        if !exist(title) {
            let insert = news_title.insert(category <- title.category, tip_new <- Int64(title.tip_new), default_add <- Int64(title.default_add),concern_id <- title.concern_id, web_url <- title.web_url, icon_url <- title.icon_url, flags <- Int64(title.flags), type <- Int64(title.type), name <- title.name, selected <- title.selected)
            do {
                try sqlManager.database.run(insert)
            } catch {
                print(error)
            }
        }
        
    }
    
    func exist(_ title: HomeNewsTitle) -> Bool {
        let title = news_title.filter(category == title.category)
        do {
            let count = try sqlManager.database.scalar(title.count)
            return count != 0
        } catch {
            print(error)
        }
        return false
    }
    
    func selectAll() -> [HomeNewsTitle] {
        var allTitles = [HomeNewsTitle]()
        do {
            for title in try sqlManager.database.prepare(news_title) {
                let newTitle = HomeNewsTitle(category: title[category], tip_new: Int(title[tip_new]),default_add: Int(title[default_add]), web_url: title[web_url], concern_id: title[concern_id], icon_url: title[icon_url], flags: Int(title[flags]), type: Int(title[type]), name: title[name], selected: title[selected])
                allTitles.append(newTitle)
            }
            return allTitles
        } catch {
            print(error)
        }
        return []
    }

    
    func update(_ newsTitle: HomeNewsTitle) {
        do {
            let title = news_title.filter(category == newsTitle.category)
            try sqlManager.database.run(title.update(selected <- newsTitle.selected))
        } catch {
            print(error)
        }
    }
    
    
}
