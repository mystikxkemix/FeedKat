import UIKit

class TabTile:Tile
{
    init(cat:Cat, type:Int)
    {
        super.init(type: type)
        frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*3)
        let top = UIView(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        top.backgroundColor = Static.BlueColor
        var title:String
        switch type
        {
        case 0:
            title = "Informations"
        case 1:
            title = "FeedTimes"
        case 2:
            title = "Graphiques"
        default:
            title = "test"
        }
        let tLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        tLabel.text = title
        tLabel.textColor = UIColor.white
        tLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        tLabel.textAlignment = NSTextAlignment.center
        top.addSubview(tLabel)
        
        addSubview(top)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
