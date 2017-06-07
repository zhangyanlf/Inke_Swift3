//
//	ZylExtra.swift
//	模型生成器（小波汉化）JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ZylExtra{

	var cover : AnyObject!
	var label : [ZylLabel]!


	/**
	 * 用字典来初始化一个实例并设置各个属性值
	 */
	init(fromDictionary dictionary: NSDictionary){
		cover = dictionary["cover"] as? AnyObject
		label = [ZylLabel]()
		if let labelArray = dictionary["label"] as? [NSDictionary]{
			for dic in labelArray{
				let value = ZylLabel(fromDictionary: dic)
				label.append(value)
			}
		}
	}

	/**
	 * 把所有属性值存到一个NSDictionary对象，键是相应的属性名。
	 */
	func toDictionary() -> NSDictionary
	{
		var dictionary = NSMutableDictionary()
		if cover != nil{
			dictionary["cover"] = cover
		}
		if label != nil{
			var dictionaryElements = [NSDictionary]()
			for labelElement in label {
				dictionaryElements.append(labelElement.toDictionary())
			}
			dictionary["label"] = dictionaryElements
		}
		return dictionary
	}

}