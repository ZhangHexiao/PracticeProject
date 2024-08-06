//
//  ConcurrentImageViewModel.swift
//  PracticeProject
//
//  Created by Rodney Zhang on 2024-08-05.
//

import Foundation
import UIKit

class ImageMatrixViewModel {
    
    let imageURL: String = "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg"
    
    let imageURLsMatrix: [[String]] = [
          ["https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg", "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg", "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg"],
          ["https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg", "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg", "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg"],
          ["https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg", "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg", "https://img.cdn4dd.com/cdn-cgi/image/fit=contain,width=300,format=auto/https://doordash-static.s3.amazonaws.com/media/photos/e6801233-0609-41a7-8d05-542c0db491fd-retina-large-jpeg"]
      ]
    
    var imageList: [[UIImage?]] = [[nil,nil,nil],[nil,nil,nil],[nil,nil,nil]]
}
