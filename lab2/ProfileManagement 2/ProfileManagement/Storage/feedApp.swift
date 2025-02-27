import Foundation

//@main
//struct FeedApp {
//    static func main() {
//        let feedSystem = FeedSystem()
//        feedSystem.loadJson()
//        
//        if let feedUserCashe = feedSystem.getUserCache(), let feedPosts = feedSystem.getFeedPosts() {
//            print("✅ JSON Loaded Successfully!")
//            print("📄 JSON users : \(feedUserCashe)")
//            print("📄 JSON posts ----- : \(feedPosts)")
//        } else {
//            print("❌ Failed to Load Initial Data")
//        }
//        let post = Post(
//            id: UUID(),
//            authorId: UUID(),
//            content: "Check out my latest post! #Swift",
//            likes: 100,
//            images: ["post1", "post2"]
//            
//        )
//
//        let uiImages = post.getImages()
//        print("Loaded images: \(uiImages)")
//    }
//}
