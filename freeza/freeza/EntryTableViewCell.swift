import UIKit
import QuartzCore

protocol EntryTableViewCellDelegate {
    
    func presentImage(withURL url: URL)
    func updateFavorites()
}

class EntryTableViewCell: UITableViewCell {

    static let cellId = "EntryTableViewCell"
    
    var entry: EntryViewModel? {
        
        didSet {
            
            self.configureForEntry()
        }
    }
    
    var delegate: EntryTableViewCellDelegate?
    
    @IBOutlet private weak var thumbnailButton: UIButton!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var commentsCountLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    @IBOutlet private weak var entryTitleLabel: UILabel!
    @IBOutlet private weak var nsfwLabel: UILabel!
    @IBOutlet private weak var favoriteButton: UIButton!
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        self.configureViews()
    }
    
    @IBAction func thumbnailButtonTapped(_ sender: AnyObject) {
        
        if let url = self.entry?.url {
            
            self.delegate?.presentImage(withURL: url)
        }
    }
    @IBAction func favoriteButtonTapped(_ sender: AnyObject) {
        self.favoriteButton.isSelected = !self.favoriteButton.isSelected
        if self.favoriteButton.isSelected {
            entry?.saveEntryToDB()
        } else {
            entry?.deleteEntryToDB(){
                self.delegate?.updateFavorites()
            }
        }
    }
    private func configureViews() {
        
        func configureThumbnailImageView() {
        
            self.thumbnailButton.layer.borderColor = UIColor.black.cgColor
            self.thumbnailButton.layer.borderWidth = 1
        }
        func configureFavoriteButton() {
            guard let isFavorite = self.entry?.isFavorite else { return }
            self.favoriteButton.isSelected = isFavorite
        }
        func configureCommentsCountLabel() {
            
            self.commentsCountLabel.layer.cornerRadius = self.commentsCountLabel.bounds.size.height / 2
        }
        
        func configureSafeMode() {
            self.nsfwLabel.layer.cornerRadius =  self.nsfwLabel.frame.size.height/3.0
            self.nsfwLabel.layer.masksToBounds = true
            
            guard let isAdult = self.entry?.isAdult else { return }
            self.nsfwLabel.isHidden = !isAdult
            self.enable(on: !(isAdult && AppData.enableSafeMode))
        }
        
        configureThumbnailImageView()
        configureFavoriteButton()
        configureCommentsCountLabel()
        configureSafeMode()
    }
    
    private func configureForEntry() {
        
        guard let entry = self.entry else {
            
            return
        }
        
        self.thumbnailButton.setImage(entry.thumbnail, for: [])
        self.authorLabel.text = entry.author
        self.commentsCountLabel.text = entry.commentsCount
        self.ageLabel.text = entry.age
        self.entryTitleLabel.text = entry.title
        
        entry.loadThumbnail { [weak self] in
            
            self?.thumbnailButton.setImage(entry.thumbnail, for: [])
        }
    }
}
