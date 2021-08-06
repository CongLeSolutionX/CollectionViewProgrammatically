Initial setup: 
- remove Main.storyboard file and its configuration in Info.plist 
- remove SceneDelegate.swift file and its configuration  in Info.plist 
- setup the window with navigationController with a root view controller 

Using UICollectionViewFlowLayout  to build collectionView: 
- create a avaiable UICollectionViewFlowLayout
- create a variable UICollectionView using defined flowlayout ealier, assign delegates to self, and register a reusable UICollectionViewCell with unique identifier
- create a class type UICollectionViewCell with a unique static identifier string. Then, calls designated initializer
- create extensions and conform to UICollectionView delegates (UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout)
- add collectionview as the subview inside loadView() and setup constraints for it


Notes: 
- Compositional layout only  supports for iOS 13 and above 

- Resource: 
  + https://www.zealousweb.com/how-to-use-compositional-layout-in-collection-view
  + https://lickability.com/blog/getting-started-with-uicollectionviewcompositionallayout/

