////
////  ViewModel.swift
////  MovieMania
////
////  Created by Sushant Dhakal on 2025-02-20.
////
//
//import SwiftUI
//
//struct ViewModel: View {
//    @StateObject var viewModel = DatabaseManagerViewModel()
//    let column = [GridItem(), GridItem()]
//    
//    @State var CategoryType: CategoryTitle
//
//    var body: some View {
//        NavigationView{
//            ScrollView{
//                if !viewModel.viewManagerModel.isEmpty{
//                    LazyVGrid(columns: column){
//                        ForEach(viewModel.viewManagerModel){ movie in
//                            NavigationLink{
//                                MovieDetails(movieDetails: movie)
//                                
//                            }label:{
//                                MovieCardView(movies: movie)
//                            }
//                        }
//                    }
//                }else{
//                    Text(CategoryType.emptyScreenTitle)
//                        .font(.title2)
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.gray)
//                        .padding()
//                }
//            
//            }.navigationTitle(CategoryType.navigationTitle)
//        }
//        }
//    }
//
//
//extension ViewModel{
//    enum CategoryTitle{
//        case favourite, wishList, watched
//        
//        var emptyScreenTitle: String{
//            switch self {
//            case .favourite:
//                "No Favourite Movies"
//            case .wishList:
//                "No WishList Movies"
//            case .watched:
//                "No Wathced List Added"
//            }
//        }
//         
//         var navigationTitle:String {
//             switch self {
//             case .favourite:
//                 "Favourites"
//             case .wishList:
//                 "WishList"
//             case .watched:
//                 "WatchedList"
//             }
//         }
//    }
//}
//
//#Preview {
//    ViewModel(viewModel: DatabaseManagerViewModel(), CategoryType: .favourite)
//}
