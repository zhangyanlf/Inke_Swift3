//
//	ZylLabel.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ZylLabel{

	var cl : [Int]!
	var tabKey : String!
	var tabName : String!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cl = dictionary["cl"] as? [Int]
		tabKey = dictionary["tab_key"] as? String
		tabName = dictionary["tab_name"] as? String
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if cl != nil{
			dictionary["cl"] = cl
		}
		if tabKey != nil{
			dictionary["tab_key"] = tabKey
		}
		if tabName != nil{
			dictionary["tab_name"] = tabName
		}
		return dictionary
	}

}