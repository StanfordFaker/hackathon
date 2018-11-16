//
//  ViewController.swift
//  StanfordFaker
//
//  Created by qbbang on 16/11/2018.
//  Copyright © 2018 qbbang. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
  
  var currentParsingElement = ""
  var trafficallInfo = xmlInfo()
  var info = TrafficInfo()
  
  var tempCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    print("viewDidLoad")
    requestInfo()
    sortInfo()
    
    print(info.installationPurpose.count)
    print(info.roadAddress.count)
    print(info.latitude.count)
    print(info.longitude.count)
    
    print(info.installationPurpose[0])
    print(info.roadAddress[10])
    print(info.latitude[50])
    print(info.longitude[88])
    
  }
  
  func sortInfo() {
    for index in 0..<trafficallInfo.installationPurpose.count {
      if trafficallInfo.installationPurpose[index] == "교통단속" {
        info.installationPurpose.append(trafficallInfo.installationPurpose[index])
        info.roadAddress.append(trafficallInfo.roadAddress[index])
        info.latitude.append(trafficallInfo.latitude[index])
        info.longitude.append(trafficallInfo.longitude[index])
      }
    }
  }
  
  func requestInfo() {
    // OPEN API 주소
    let url = "https://raw.githubusercontent.com/qbbang/XMLParser/master/parking.xml"
    
    guard let xmlParser = XMLParser(contentsOf: URL(string: url)!) else { return print("else") }
    xmlParser.delegate = self;
    xmlParser.parse()
  }
}


extension FirstViewController: XMLParserDelegate {
  //MARK:- XML Delegate methods
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    currentParsingElement = elementName
    if elementName == "Row" {
      print("Started parsing...")
    }
  }
  
  // 현재 테그에 담겨있는 문자열 전달
  public func parser(_ parser: XMLParser, foundCharacters string: String)
  {
    if currentParsingElement == "소재지도로명주소" {
      trafficallInfo.roadAddress.append(string)
      //      adress.append(string)
      //      print(1)
      //      print(string)
    }
    
    if currentParsingElement == "설치목적구분" {
      
      trafficallInfo.installationPurpose.append(string)
      //        += string
      //      print(string)
      //      print(2)
      //      print(string)
    }
    
    if currentParsingElement == "위도" {
      
      trafficallInfo.latitude.append(string)
      //      print(3)
      //      print(string)
    }
    
    if currentParsingElement == "경도" {
      
      trafficallInfo.longitude.append(string)
      //      print(4)
      //      print(string)
    }
  }
  
  // XML 파서가 종료 테그를 만나면 호출됨
  public func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
  {
    
    if (elementName == "Row") {
      print("/Row")
      //      print(trafficallInfo.installationPurpose)
      
      //      if trafficallInfo.installationPurpose == "교통단속" {
      //        print("교통단속")
      //      }
      
      print("End parsing...")
    }
    
  }
}


