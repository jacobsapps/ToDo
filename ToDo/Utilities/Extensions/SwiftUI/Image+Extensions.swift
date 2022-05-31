//
//  Image+Extensions.swift
//  ToDo
//
//  Created by Jacob Bartlett on 29/05/2022.
//

import SwiftUI

/// **ImageEnum**
/// A simple protocol to enable semantic-style image selection.
/// Create enums to group and access images based on their purpose *(e.g. icon or photo)*.
///
protocol ImageEnum {
    var rawValue: String { get }
}

extension ImageEnum {
    
    var image: Image {
        Image(rawValue)
    }
}

extension Image {

    enum Picture: String, ImageEnum {
        case lightBanner
        case darkBanner
    }
    
    enum Icon: String, ImageEnum {
        case check
        case cross
        case moon
        case sun
    }
    
    static func fit(_ imageEnum: ImageEnum, renderingMode: TemplateRenderingMode = .original) -> some View {
        imageEnum.image
            .resizable()
            .renderingMode(renderingMode)
            .aspectRatio(contentMode: .fit)
    }
    
    static func fill(_ imageEnum: ImageEnum, renderingMode: TemplateRenderingMode = .original) -> some View {
        imageEnum.image
            .resizable()
            .renderingMode(renderingMode)
            .aspectRatio(contentMode: .fill)
    }
}

struct Image_Previews: PreviewProvider {
    
    static let pictures: [ImageEnum] = [
        Image.Picture.lightBanner,
        Image.Picture.darkBanner
    ]
    
    static let icons: [ImageEnum] = [
        Image.Icon.check,
        Image.Icon.cross,
        Image.Icon.moon,
        Image.Icon.sun
    ]
    
    static var previews: some View {
        VStack(spacing: 20) {
            ForEach(pictures, id: \.rawValue) {
                Image.fill($0)
                    .frame(height: 200)
            }
            HStack(spacing: 20) {
                ForEach(icons, id: \.rawValue) {
                    Image.fit($0)
                        .frame(width: 30, height: 30)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}
