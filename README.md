# Pokemon Card Database using POKEMON TGC API

![This is an image](https://i.ibb.co/rctGR3H/Group-1.png)

## Features
- List of pokemon card
- Search specfic card
- Detail of card

## Project

### Clean Architecture VIPER
[View-Interactor-Presenter-Entity-Routing (VIPER)](https://www.objc.io/issues/13-architecture/viper/)
I use the exotic architecture that might be worth looking into in larger projects.
```
├─ Core/Networking
├─ Extensions
├─ Utils
├─ Modules
    ├─ CardDetails
    ├─ Discoveries
        ├─ Presenter
        ├─ Router
        ├─ Models
        ├─ Interactor
        ├─ Protocol
        ├─ VC
├─ AppDelegate
```

### Programatically UI
I'm more confident to use programatically to avoid error or conflict on the XIB or Storyboard
```
private let lbl0CardName: UILabel = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 20)
            v.textColor = .white
            v.text = "Detective Pikachu"
        }
        
view.addSubview(lbl0CardName)
```

### Auto Layout
To configure auto layout I use [SnapKit](https://github.com/SnapKit/SnapKit) to reduce the code and make development faster.

Instead of doing this
```
  imageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
  imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
  imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
```

Do this 
```
imageView.snp.makeConstraints { make in
    make.width.equalTo(200)
    make.height.equalTo(280)
    make.top.equalTo(contentView).offset(20)
    make.centerX.equalTo(contentView)
}
```

### Constants
```
public class Color {
    static let background = UIColor.init("#1A202C");
    static let navigation = UIColor.init("#161B22");
    static let foreground = UIColor.init("#FFFFFF");
    static let yelloWPokemon = UIColor.init("#FFE55A");
}
```

### Networking
Using [Alamofire](https://github.com/Alamofire/Alamofire) to manage the request

## Getting Started
### 1. Clone this project
You can clone the project by Http or Ssh on your terminal
- HTTP ``` git clone https://github.com/mikekaels/PokemonCard.git ```
- SSH ``` git clone git@github.com:mikekaels/PokemonCard.git ```
- Or [download the project](https://github.com/mikekaels/PokemonCard/archive/refs/heads/main.zip)
### 2. Instalation
Make sure you have installed [cocoapods](https://cocoapods.org/) on your machine, if not please do this command in your Terminal: 
```bash
$ sudo gem install cocoapods
```
If you already install cocoapods, in your terminal go to inside the project directory and do this command: 
```bash
pod install
```
### 3. Open the .xcworkspace file
![This is an image](https://i.ibb.co/WkFcwjQ/Screen-Shot-2022-02-12-at-13-09-25.png)
open the file
### 4. Run
![This is an image](https://i.ibb.co/98GNPjQ/Screen-Shot-2022-02-12-at-13-11-31.png)
Select the simulator or device
and Run the project!
### 5. Done


## Dependency
- Networking  using **Alamofire** -> 5.5
- Auto Layout using **Snapkit** -> 5.0.0
- Handling image using **Kingfisher** -> 7.0
- Indicator and Skeleton view using **SkeletonView**
