//
//  ContentView.swift
//  SwitUiPrep
//
//  Created by Ronnie Otieno on 21/08/2021.
//
import SwiftUI
import SDWebImageSwiftUI

public struct ContentView: View {
    
    @ObservedObject var apiFetch = ApiFetch()
    
   public var body: some View {
        
        NavigationView{
            List(apiFetch.images){ image in
                
                NavigationLink(destination: DetailView(image: image)){
                    VStack{
                        Spacer()
                        VStack(alignment: .leading, spacing: 5){
                            if image.description != nil{
                                Text(image.description!).foregroundColor(.white).font(.system(size: 15))
                            }
                            HStack{
                                Text("By \(image.user.name)").foregroundColor(.white).font(.system(size: 16))
                                Spacer()
                                Text( "\(image.likes) likes").foregroundColor(.white).font(.system(size: 16))
                            }
                            
                        }.padding(10).background(Color.black.opacity(0.3))

                    
                    }.background(WebImage(url: URL(string: image.urls.regular)).resizable().placeholder(Image("loader")).scaledToFit().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).background(Color.gray.opacity(0.3))   .transition(.fade(duration: 0.5)))
                    .frame(minWidth: 0,
                            maxWidth: .infinity,
                            minHeight: 200,
                            maxHeight: .infinity)
                     .cornerRadius(10).listStyle(SidebarListStyle())
                    .navigationBarTitle("Images")
                }
            }.buttonStyle(PlainButtonStyle())
            
        }

    }
}

struct DetailView: View {
    var image: ImageResponse
    
    var body: some View {
        VStack{
            WebImage(url: URL(string: image.urls.regular)).resizable().placeholder(Image("loader")).scaledToFit().frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height).background(Color.gray.opacity(0.3))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        
    }
}


