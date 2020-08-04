    //
    //  VmaxAdXmlParsing.swift
    //  IMASample
    //
    //  Created by admin_vserv on 28/07/20.
    //  Copyright © 2020 kaltura. All rights reserved.
    //

    import Foundation

    class VmaxAdXmlParsing: NSObject, XMLParserDelegate {
        
        var xmlString: String?
        static let shared = VmaxAdXmlParsing()
        var parser = XMLParser()
        var currentElement = ""
        var vastAdModel = VastAdModel()
        
        func setXmlString(xmlString: String) {
            self.xmlString = xmlString
            guard let xmlData = self.xmlString?.data(using: .utf8) else {return}
            parser = XMLParser(data: xmlData)
            parser.delegate = self
            parser.parse()
        }
        
        func setVastAd() -> VastAdModel {
            return self.vastAdModel
        }
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            self.currentElement = elementName
            
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            
           
        }
        
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
          
        }
        
        func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
            
            if self.currentElement == "MediaFile"{
                vastAdModel.videoUrl = String(describing: String(data: CDATABlock, encoding: .ascii) ?? "")
                
            }
            else if self.currentElement == "Tracking" {
                let eventUrl = String(describing: String(data: CDATABlock, encoding: .ascii) ?? "")
                
                if eventUrl.contains("event=start"){
                    self.vastAdModel.startUrl.append(eventUrl)
                }
                else if eventUrl.contains("event=firstQuartile"){
                    self.vastAdModel.firstQuartile.append(eventUrl)
                }
                else if eventUrl.contains("event=midpoint"){
                    self.vastAdModel.midpoint.append(eventUrl)
                }
                else if eventUrl.contains("event=thirdQuartile"){
                    self.vastAdModel.thirdQuartile.append(eventUrl)
                }
                else if eventUrl.contains("event=mute"){
                    self.vastAdModel.mute.append(eventUrl)
                }
                else if eventUrl.contains("event=unmute"){
                    self.vastAdModel.unmute.append(eventUrl)
                }
                else if eventUrl.contains("event=pause"){
                    self.vastAdModel.pause.append(eventUrl)
                }
                else if eventUrl.contains("event=resume"){
                    self.vastAdModel.resume.append(eventUrl)
                }
                else if eventUrl.contains("event=complete"){
                    self.vastAdModel.complete.append(eventUrl)
                }
                else if eventUrl.contains("event=skippableStateChange"){
                    self.vastAdModel.skippableStateChange.append(eventUrl)
                }
                else {
                    print("even not fount")
                }   
            }
            
        }
        
        
        
        
        
    }
