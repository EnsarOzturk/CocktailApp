
import SwiftUI

struct RandomCocktailSwiftUIView: View {
    @ObservedObject var viewModel: RandomCocktailViewModel
    @StateObject private var timer: CocktailTimer

    init(viewModel: RandomCocktailViewModel) {
        self.viewModel = viewModel
        _timer = StateObject(wrappedValue: CocktailTimer(viewModel: viewModel))
    }

    var body: some View {
        VStack {
            if let cocktail = viewModel.randomCocktail {
                Text(cocktail.strDrink ?? "Unknown")
                    .font(.largeTitle)
                    .padding()

                if let imageUrl = URL(string: cocktail.strDrinkThumb ?? "") {
                    AsyncImage(url: imageUrl) { image in
                        image.resizable()
                             .aspectRatio(contentMode: .fit)
                             .frame(height: 200)
                             .cornerRadius(3.0)
                    } placeholder: {
                        ProgressView() // Yükleniyor
                    }
                }
            } else {
                Text("No cocktail")
                    .font(.title)
                    .padding()
            }
            
            Button(timer.isUpdating ? "Stop" : "Shuffle") {
                if timer.isUpdating {
                    timer.stopUpdatingCocktails()
                } else {
                    timer.startUpdatingCocktails()
                }
            }
            .padding()
            .foregroundColor(.black)
        }
        .padding()
        .onAppear {
            viewModel.fetchRandomCocktail() // Sayfa yüklendiğinde default gelen kokteyl
        }
    }
}









