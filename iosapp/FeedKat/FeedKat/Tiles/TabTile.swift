import UIKit
import Charts
import MadJohTools

class TabTile:Tile, UITextFieldDelegate, ChartViewDelegate
{
    var UiImage:UIImageView!
    var cat:Cat
    var type:Int?
    var nameText:UILabel?
    var nameEdit:UITextField?
    var name:String = ""
    var eLabel:UILabel?
    var tLabel:UILabel?
    var parent:DetailsCatBoardVC
    var tDate:UILabel?
    var eDate:UITextField?
    var date:Date?
    var text1:UILabel?
    
    var ajout: UILabel!
    var feedTimeViews = [UIView]()
    
    var eFeed:[UILabel] = []
    var tFeed:[UILabel] = []
    var modWeight:[UITextField] = []
    var modHour:[UITextField] = []
    var deleteList:[UIImageView] = []
    let timeFormatter = DateFormatter()
    var feedList:[FeedTime] = []
    
    init(cat:Cat, type:Int, parent:DetailsCatBoardVC, UiImage:UIImageView?, UiDate:UITextField?)
    {
        self.cat = cat
        self.type = type
        self.parent = parent
        self.eDate = UiDate
        
        switch type
        {
        case 0:
            super.init(type: type)
            self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*3)
            self.UiImage = UiImage!
            break
        case 1:
            super.init(height: CGFloat(cat.feeds.count+2)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5))
            break
        case 2:
            super.init(type: type)
            self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*6)
            self.heightAnchor.constraint(equalToConstant: Static.tileHeight*6).isActive = true
            
            break
        default:
            super.init(type: type)
            break
        }
        
    }
    
    func setContent()
    {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        banner = UIView()
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = Static.OrangeColor
        addSubview(banner)
        addConstraint(NSLayoutConstraint(item: banner, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: banner, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0.01, constant: 0))
        
        let top = UIView(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        top.backgroundColor = Static.BlueColor
        var title:String = ""
        switch type!
        {
        case 0:
            title = "Informations"
            self.UiImage = UiImage!
        case 1:
            title = "FeedTimes"
        case 2:
            title = "Graphiques"
        default: break
        }
        tLabel = UILabel(frame: CGRect(x: Static.tileWidth*0.02, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        tLabel!.text = title
        tLabel!.textColor = UIColor.white
        tLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        top.addSubview(tLabel!)
        self.addSubview(top)

        
        switch type!
        {
        case 0:
            initInfo()
        case 1:
            initFeed()
        case 2:
            initGraph()
        default: break
            
        }
    }
    
    func initInfo()
    {
        let offsetx = Static.tileWidth*0.04 + Static.tileHeight*1.2
        let offsety = Static.tileHeight*0.6 + Static.tileWidth*0.02
        self.name = cat.getName()
        self.date = cat.Birthdate
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TabTile.resignInfoResponder)))
        timeFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .none
    
        eDate!.text = timeFormatter.string(from: self.date!)
        
        eLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth - Static.tileWidth*0.02, height: Static.tileHeight*0.6))
        eLabel!.text = "Editer"
        eLabel!.textColor = UIColor.white
        eLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        eLabel!.textAlignment = NSTextAlignment.right
        eLabel!.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(TabTile.InfoTapped)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        eLabel!.addGestureRecognizer(tapGesture)
        
        nameText = UILabel(frame:CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.2 + offsety, width: Static.tileWidth*0.6, height: Static.tileHeight*0.2))
        nameText!.text = "Nom : " + name
        nameText!.textColor = UIColor.black
        nameText!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        nameText!.textAlignment = NSTextAlignment.left
        nameText!.isHidden = false
        
        tDate = UILabel(frame:CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.5 + offsety, width: Static.tileWidth*0.8, height: Static.tileHeight*0.2))
        tDate!.textColor = UIColor.black
        tDate!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        tDate!.textAlignment = NSTextAlignment.left
        tDate!.isHidden = false
        reloadDate()
        
        nameEdit = UITextField(frame:CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.2 + offsety, width: Static.tileWidth*0.4, height: Static.tileHeight*0.2))
        nameEdit!.text = name
        nameEdit!.textColor = Static.BlueColor
        nameEdit!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        nameEdit!.textAlignment = NSTextAlignment.left
        nameEdit!.isHidden = true
        nameEdit!.autocorrectionType = .no
        nameEdit!.textAlignment = .center
        nameEdit!.layer.borderWidth = 1
        nameEdit!.layer.cornerRadius = 10

        addSubview(nameText!)
        addSubview(nameEdit!)
        addSubview(eLabel!)
        
        addSubview(UiImage)
        
        addSubview(tDate!)
        addSubview(eDate!)
        
        
        let bat = UILabel(frame: CGRect(x: offsetx, y: offsety, width: Static.tileWidth*0.6, height: Static.tileHeight*0.3))
        bat.text = "Batterie : \(cat.statusBattery)%"
        bat.textColor = UIColor.black
        bat.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        bat.textAlignment = NSTextAlignment.left
        addSubview(bat)
        
        let weight = UILabel(frame: CGRect(x: offsetx, y: offsety + Static.tileHeight*0.3, width: Static.tileWidth*0.6, height: Static.tileHeight*0.3))
        weight.text = "Poids : \(Double(cat.weight)*0.001)Kg"
        weight.textColor = UIColor.black
        weight.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        weight.textAlignment = NSTextAlignment.left
        addSubview(weight)
        
    }
    
    func initFeed()
    {
        var i = 1;
        var v:DragToActionView
        for feed in cat.feeds
        {
            self.feedList.append(feed)
            v = DragToActionView(frame: CGRect(x: Static.tileWidth*0.05, y: CGFloat(i)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5), width: Static.tileWidth*0.95, height: Static.tileHeight*0.5))
            addSubview(v)
            self.feedTimeViews.append(v)
            
            let utFeed = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.5))
            utFeed.text = " \(feed.Weight)g à \(feed.Hour)"
            utFeed.textColor = UIColor.black
            utFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
            utFeed.textAlignment = NSTextAlignment.left
            
            tFeed.append(utFeed)
            
            let ueFeed = UILabel(frame: CGRect(x: Static.tileWidth*0.7, y: 0, width: Static.tileWidth*0.2, height: Static.tileHeight*0.5))
            ueFeed.text = "Editer"
            ueFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            ueFeed.textAlignment = NSTextAlignment.right
            ueFeed.isUserInteractionEnabled = true
            ueFeed.tag = i-1
            let aSelector : Selector = #selector(TabTile.FeedTapped(_:))
            let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
            tapGesture.numberOfTapsRequired = 1
            ueFeed.addGestureRecognizer(tapGesture)
            
            eFeed.append(ueFeed)

            let umodWeight = UITextField(frame: CGRect(x: 0, y: 0, width: Static.tileWidth*0.2, height: Static.tileHeight*0.5))
            umodWeight.text = "\(feed.Weight)"
            umodWeight.delegate = self
            umodWeight.textColor = Static.BlueColor
            umodWeight.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            umodWeight.textAlignment = .center
            umodWeight.layer.borderWidth = 1
            umodWeight.layer.borderColor = UIColor.black.cgColor
            umodWeight.layer.cornerRadius = 10
            umodWeight.isHidden = true
            umodWeight.keyboardType = .numberPad
            
            self.modWeight.append(umodWeight)
            
            let umodHour = UITextField(frame: CGRect(x: Static.tileWidth*0.3, y: 0, width: Static.tileWidth*0.3, height: Static.tileHeight*0.5))
            umodHour.text = "\(feed.Hour)"
            umodHour.delegate = self
            umodHour.textColor = Static.BlueColor
            umodHour.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            umodHour.textAlignment = .center
            umodHour.layer.borderWidth = 1
            umodHour.layer.borderColor = UIColor.black.cgColor
            umodHour.layer.cornerRadius = 10
            umodHour.isHidden = true
            //umodHour.addTarget(self, action: #selector(DetailsCatBoardVC.txtFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
            umodHour.addTarget(self, action: #selector(TabTile.feedTimeField(_:)), for: .editingDidBegin)
            
            self.modHour.append(umodHour)
            
            let iDelete = UIImageView(frame: CGRect(x: Static.tileWidth*0.62, y: Static.tileHeight*0.1, width: Static.tileHeight*0.3, height: Static.tileHeight*0.3))
            iDelete.image = Static.getScaledImageWithHeight("Icon_cross", height: Static.tileHeight*0.5)
            iDelete.isHidden = true;
            iDelete.isUserInteractionEnabled = true
            let aSelectorD : Selector = #selector(TabTile.deleteFeedTime)
            let tapGestureD = UITapGestureRecognizer(target: self, action: aSelectorD)
            tapGestureD.numberOfTapsRequired = 1
            iDelete.addGestureRecognizer(tapGestureD)
            
            self.deleteList.append(iDelete)
            
            v.addSubview(utFeed)
            v.addSubview(ueFeed)
            v.addSubview(umodWeight)
            v.addSubview(umodHour)
            v.addSubview(iDelete)
            i+=1
            
            v.actionWidth = Static.tileWidth*0.20
            v.setActionHeightMultiplier(0.8)
            v.setActionColor(color: Static.TransparentColor)
            v.setActionImage(img: Static.getScaledImageWithHeight("Icon_cross", height: Static.tileHeight))
            
            v.addActionTarget {
                
                FeedKatAPI.deleteFeedTime(feed.ID, handler: {_,_ in })
                
                for view in self.feedTimeViews
                {
                    view.removeFromSuperview()
                }
                let offset = v.height + Static.tileSpacing*0.5
                
                self.parent.list_tile.last!.y -= offset
                self.parent.list_tile.last!.heightAnchor.constraint(equalToConstant: self.parent.list_tile.last!.height - offset).isActive = true
                self.parent.scrollView.contentSize.height -= offset
                self.banner.height -= offset
                self.heightAnchor.constraint(equalToConstant: self.height - offset).isActive = true
                self.ajout.removeFromSuperview()
                self.cat.feeds.remove(at: self.cat.feeds.index(of: feed)!)
                self.initFeed()
            }
        }
        
        ajout = UILabel(frame: CGRect(x: Static.tileWidth*0.05, y: CGFloat(i)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5), width: Static.tileWidth, height: Static.tileHeight*0.5))
        ajout.text = "Ajouter un FeedTime"
        ajout.textColor = UIColor.darkGray
        ajout.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        ajout.textAlignment = NSTextAlignment.center
        ajout.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(TabTile.addFeedTime)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        
        ajout.addGestureRecognizer(tapGesture)
        
        insertSubview(ajout, at: 0)
    }
    
    func initGraph()
    {
        
        let barActivity = BarChartView(frame: CGRect(x: Static.tileWidth*0.06, y: Static.tileHeight*0.9, width: Static.tileWidth*0.9, height: Static.tileHeight*2.2))
        barActivity.delegate = self
        barActivity.chartDescription?.text = "";
        barActivity.noDataText = "Data will be loaded soon."
        barActivity.rightAxis.enabled = false
        barActivity.xAxis.drawGridLinesEnabled = false
        barActivity.xAxis.labelPosition = .bottom
        
        barActivity.drawBarShadowEnabled = false
        barActivity.drawValueAboveBarEnabled = false
        
        barActivity.maxVisibleCount = 6
        barActivity.fitBars = true
        barActivity.pinchZoomEnabled = true
        barActivity.drawGridBackgroundEnabled = false
        barActivity.gridBackgroundColor = Static.TransparentColor
        barActivity.drawBordersEnabled = false
        barActivity.dragEnabled = true
        barActivity.drawValueAboveBarEnabled = false
        
        var yValsActivity: [BarChartDataEntry] = []
        for idx in 0..<cat.historyActivity.count {
            yValsActivity.append(BarChartDataEntry(x: Double(Float(idx)), y: Double(cat.historyActivity[idx])))
        }
        
        let set1Activity = BarChartDataSet(values: yValsActivity, label: "Activité")
        set1Activity.setColor(Static.OrangeColor)
        
        let dataActivity = BarChartData(dataSet: set1Activity)
        dataActivity.setValueFont(UIFont(name: "Arial Rounded MT Bold", size: 0))
        if(cat.historyActivity.count > 0)
        {
            barActivity.data = dataActivity
        }
        
        addSubview(barActivity)
        
        let lineWeight = LineChartView(frame: CGRect(x: Static.tileWidth*0.06, y: Static.tileHeight*3.6, width: Static.tileWidth*0.9, height: Static.tileHeight*2.2))
        
        lineWeight.chartDescription?.text = "";
        lineWeight.noDataText = "Data will be loaded soon."
        lineWeight.rightAxis.enabled = false
        lineWeight.xAxis.labelPosition = .bottom
        lineWeight.gridBackgroundColor = Static.TransparentColor
        lineWeight.xAxis.drawGridLinesEnabled = false
        
        lineWeight.tintColor = UIColor.black
        
        lineWeight.maxVisibleCount = 6
        lineWeight.pinchZoomEnabled = false
        lineWeight.drawGridBackgroundEnabled = true
        lineWeight.drawBordersEnabled = false
        lineWeight.dragEnabled = true
        
        var yValsWeight: [ChartDataEntry] = []
        for idy in 0..<cat.historyWeight.count {
            yValsWeight.append(ChartDataEntry(x: Double(idy), y: Double(cat.historyWeight[idy])))
        }
        
        let set1Weight = LineChartDataSet(values: yValsWeight, label: "Poids par jour (en g)")
        set1Weight.setCircleColor(Static.TransparentColor)
        set1Weight.circleHoleColor = Static.OrangeColor
        set1Weight.setColor(Static.BlueColor)
        
        let dataWeight = LineChartData(dataSet: set1Weight)
        dataWeight.setValueFont(UIFont(name: "Arial Rounded MT Bold", size: 0))
        
        if(cat.historyWeight.count > 0)
        {
            lineWeight.data = dataWeight
        }
        
        addSubview(lineWeight)
    }
    
    func InfoTapped()
    {
        if(nameText!.isHidden)
        {
            _ = InfoShouldReturn(userText: nameEdit!)
        }
        else
        {
            UiImage.isUserInteractionEnabled = true
            eLabel!.text = "Valider"
            eLabel!.textColor = UIColor.red
            nameText!.isHidden = true
            nameEdit!.isHidden = false
            eDate!.isHidden = false
            tDate!.isHidden = true
        }
    }
    
    func FeedTapped(_ sender: UITapGestureRecognizer)
    {
        let idx = eFeed.index(of: sender.view! as! UILabel)
        currentInd = idx!
        
        if(!modHour[currentInd].isHidden)
        {
            _ = FeedShouldReturn(userText: modHour[currentInd])
        }
        else
        {
            modHour[currentInd].isHidden = false
            modWeight[currentInd].isHidden = false
            deleteList[currentInd].isHidden = false
            tFeed[currentInd].isHidden = true
            eFeed[currentInd].text = "Valider"
            eFeed[currentInd].textColor = UIColor.red
        }
    }
    
    func InfoShouldReturn(userText: UITextField) -> Bool
    {
        resignInfoResponder()
        UiImage.isUserInteractionEnabled = false
        nameEdit!.isHidden = true
        nameText!.isHidden = false
        eDate!.isHidden = true
        tDate!.isHidden = false
        name = nameEdit!.text!
        nameText!.text = "Nom : " + name
        eLabel!.text = "Editer"
        eLabel!.textColor = UIColor.white
        reloadDate()
        
        FeedKatAPI.modifyCat(cat.getID(), name: name, UiImage: (parent.isNewImage ? self.UiImage.image! : nil), birth: self.date)
        {
            response, error in
            if(error == nil)
            {
                self.cat.Name = self.name
                self.parent.UITitle.text = self.name
                if(self.parent.isNewImage){self.cat.image = self.UiImage.image}
                self.cat.Birthdate = self.date!
                self.parent.isNewImage = false
                self.parent.isNewDate = false
            }
            else
            {
                print("err : \(error)")
            }
        }
        return true
    }
    
    func FeedShouldReturn(userText: UITextField) -> Bool
    {
        resignFeedResponder()
        
        modHour[currentInd].isHidden = true
        modWeight[currentInd].isHidden = true
        tFeed[currentInd].isHidden = false
        deleteList[currentInd].isHidden = true
        eFeed[currentInd].text = "Editer"
        eFeed[currentInd].textColor = UIColor.black
        
        FeedKatAPI.modifyFeedTime(feedList[currentInd].ID, weight: Int(modWeight[currentInd].text!)!, Time: modHour[currentInd].text!)
        {
            response, error in
            if(error == nil)
            {
                self.feedList[self.currentInd].Weight = Int(self.modWeight[self.currentInd].text!)!
                self.feedList[self.currentInd].Hour = self.modHour[self.currentInd].text!
                self.reloadFeed()
            }
            else
            {
                
            }
        }
    
        
        return true
    }
    
    func reloadDate()
    {
        tDate!.text = "Naissance : \(timeFormatter.string(from: self.date!))"
    }
    
    func reloadFeed()
    {
        tFeed[currentInd].text = "- \(feedList[currentInd].Weight)g à \(feedList[currentInd].Hour)"
    }
    
    func resignInfoResponder()
    {
        eDate?.resignFirstResponder()
        nameEdit?.resignFirstResponder()
    }
    
    func resignFeedResponder()
    {
        modHour[currentInd].resignFirstResponder()
        modWeight[currentInd].resignFirstResponder()
    }
    
    private var currentInd = 0
    
    func feedTimeField(_ sender: UITextField)
    {
        currentInd = modHour.index(of: sender)!
        
        let feedPickerView  : UIDatePicker = UIDatePicker()
        feedPickerView.datePickerMode = UIDatePickerMode.time
        sender.inputView = feedPickerView
        feedPickerView.addTarget(self, action: #selector(TabTile.handleFeedTimePicker(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleFeedTimePicker(_ sender: UIDatePicker)
    {
//        InfoTab!.eDate!.text = timeFormatter.string(from: sender.time)
//        self.InfoTab!.date! = sender.date
        let feedFormatter = DateFormatter()
        feedFormatter.dateFormat = "H:mm"
        modHour[currentInd].text = feedFormatter.string(from: sender.date)
    }
    
    func addFeedTime()
    {
        Static.startLoading(view: parent.view)
        FeedKatAPI.addFeedTime(cat.getID())
        {
            response, error in
            if(error == nil)
            {
                let ids_ft = response!.value(forKey: "id_feedtime") as! String
                let id_ft = Int(ids_ft)!
                
                self.cat.feeds.append(FeedTime(ID: id_ft, Id_cat: self.cat.getID(), Id_dispenser: 0, Weight: 0, Hour: "00:00", Enable: true))
                self.feedList = self.cat.feeds
                Static.stopLoading()
                
                let feed = self.cat.feeds.last
                
                let height = self.subviews.last!.height
                let y = self.subviews.last!.y + height + Static.tileSpacing * 0.5
                
                 let tmp   = UIView(frame: CGRect(x: Static.tileWidth*0.05, y: y, width: Static.tileWidth*0.9, height: Static.tileHeight*0.5))
                self.addSubview(tmp)
                
                let utFeed = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.5))
                utFeed.text = "- \(feed!.Weight)g à \(feed!.Hour)"
                utFeed.textColor = UIColor.black
                utFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
                utFeed.textAlignment = NSTextAlignment.left
                
                self.tFeed.append(utFeed)
                
                let ueFeed = UILabel(frame: CGRect(x: Static.tileWidth*0.7, y: 0, width: Static.tileWidth*0.2, height: Static.tileHeight*0.5))
                ueFeed.text = "Editer"
                ueFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
                ueFeed.textAlignment = NSTextAlignment.right
                ueFeed.isUserInteractionEnabled = true
                ueFeed.tag = self.tFeed.count - 1
                let aSelector : Selector = #selector(TabTile.FeedTapped)
                let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
                tapGesture.numberOfTapsRequired = 1
                ueFeed.addGestureRecognizer(tapGesture)
                
                self.eFeed.append(ueFeed)
                
                let umodWeight = UITextField(frame: CGRect(x: 0, y: 0, width: Static.tileWidth*0.2, height: Static.tileHeight*0.5))
                umodWeight.text = "\(feed!.Weight)"
                umodWeight.delegate = self
                umodWeight.textColor = Static.BlueColor
                umodWeight.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
                umodWeight.textAlignment = .center
                umodWeight.layer.borderWidth = 1
                umodWeight.layer.borderColor = UIColor.black.cgColor
                umodWeight.layer.cornerRadius = 10
                umodWeight.isHidden = true
                umodWeight.keyboardType = .numberPad
                
                self.modWeight.append(umodWeight)
                
                let umodHour = UITextField(frame: CGRect(x: Static.tileWidth*0.3, y: 0, width: Static.tileWidth*0.3, height: Static.tileHeight*0.5))
                umodHour.text = "\(feed!.Hour)"
                umodHour.delegate = self
                umodHour.textColor = Static.BlueColor
                umodHour.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
                umodHour.textAlignment = .center
                umodHour.layer.borderWidth = 1
                umodHour.layer.borderColor = UIColor.black.cgColor
                umodHour.layer.cornerRadius = 10
                umodHour.isHidden = true
                umodHour.addTarget(self, action: #selector(TabTile.feedTimeField(_:)), for: .editingDidBegin)
                
                self.modHour.append(umodHour)
                
                let iDelete = UIImageView(frame: CGRect(x: Static.tileWidth*0.62, y: Static.tileHeight*0.1, width: Static.tileHeight*0.3, height: Static.tileHeight*0.3))
                iDelete.image = Static.getScaledImageWithHeight("Icon_cross", height: Static.tileHeight*0.3)
                iDelete.isHidden = true;
                iDelete.isUserInteractionEnabled = true
                let aSelectorD : Selector = #selector(TabTile.deleteFeedTime)
                let tapGestureD = UITapGestureRecognizer(target: self, action: aSelectorD)
                tapGestureD.numberOfTapsRequired = 1
                iDelete.addGestureRecognizer(tapGestureD)
                
                self.deleteList.append(iDelete)
                
                tmp.addSubview(utFeed)
                tmp.addSubview(ueFeed)
                tmp.addSubview(umodWeight)
                tmp.addSubview(umodHour)
                tmp.addSubview(iDelete)
                self.feedTimeViews.append(tmp)

                let offset = Static.tileSpacing * 0.5
                
                self.height += tmp.height + offset
                self.parent.list_tile.last!.y += tmp.height + offset
                self.ajout.y += tmp.height + offset
                self.parent.scrollView.contentSize.height += tmp.height + offset
            }
            else
            {
                print("err : \(error)")
            }
        }
    }
    
    func deleteFeedTime()
    {
        let id = feedList[currentInd].ID
        
        FeedKatAPI.deleteFeedTime(id)
        {
            response, error in
            if(error == nil)
            {
                self.cat.feeds.remove(at: self.currentInd)
                self.feedList.remove(at: self.currentInd)
                self.feedTimeViews[self.currentInd].removeFromSuperview()
                self.feedTimeViews.remove(at: self.currentInd)
                self.eFeed.remove(at: self.currentInd)
                self.tFeed.remove(at: self.currentInd)
                self.modHour.remove(at: self.currentInd)
                self.modWeight.remove(at: self.currentInd)
                
                let height = Static.tileHeight*0.5
                let offset = Static.tileSpacing * 0.5
                
                self.height -= height + offset
                for i in self.currentInd..<self.feedList.count
                {
                    self.feedTimeViews[i].y -= height+offset
                }
                self.parent.list_tile.last!.y -= height + offset
                self.ajout.y -= height + offset
                self.parent.scrollView.contentSize.height -= height + offset
            }
            else
            {
                print("err : \(error)")
            }
        }
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
