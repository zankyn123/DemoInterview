//
//  MainViewController.swift
//  ProjectDemo
//
//  Created by Manh Hung on 25/10/24.
//

import UIKit

final class MainViewController: UIViewController {
    enum MainCellReuseIdentifier: String, CellReuseIdentifier {
        case mainClvCell = "MainCollectionViewCell"
        var cellClass: AnyClass {
            switch self {
            case .mainClvCell:
                return MainCollectionViewCell.self
            }
        }
    }
    enum MainHeaderFooterReuseIdentifier: String, HeaderFooterReuseViewIdentifier {
        case loadMore = "LoadMoreReusableView"
        var headerFooterClass: AnyClass {
            switch self {
            case .loadMore:
                return LoadMoreReusableView.self
            }
        }
    }
    
    typealias SnapShot = NSDiffableDataSourceSnapshot<Int, MainViewControllerEntity>
    typealias DataSource = UICollectionViewDiffableDataSource<Int, MainViewControllerEntity>
    // MARK: - Variables
    private let presenter: MainViewControllerPresenter
    private var snapShot: SnapShot = SnapShot()
    private var dataSource: DataSource?
    private var hasMoreItems: Bool = true
    // MARK: - IBOutlets
    @IBOutlet private weak var mainClv: UICollectionView!
    // MARK: Initialize
    init(presenter: MainViewControllerPresenter) {
        self.presenter = presenter
        super.init(nibName: "MainViewController", bundle: .main)
        self.presenter.delegate = self
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter.getListAnimes()
    }
    
    private func setupUI() {
        title = "Top Anime"
        // Collection view
        mainClv.delegate = self
        mainClv.registerReuseCellIdentifier(MainCellReuseIdentifier.self)
        mainClv.registerHeaderFooterReuseIdentifier(MainHeaderFooterReuseIdentifier.self, ofKind: UICollectionView.elementKindSectionFooter)
        // Items
        dataSource = DataSource(collectionView: mainClv, cellProvider: { collectionView, indexPath, entity in
            guard let cell = collectionView.dequeueCellReuseIdentifier(MainCellReuseIdentifier.mainClvCell, for: indexPath) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setEntity(entity)
            return cell
        })
        // Footer
        dataSource?.supplementaryViewProvider = { [weak self] collectionView, elementKind, indexPath in
            guard let self else {
                return nil
            }
            guard elementKind == UICollectionView.elementKindSectionFooter else {
                return UICollectionReusableView()
            }
            let loadMoreReusableView = collectionView.dequeueHeaderFooterReuseViewIdentifier(MainHeaderFooterReuseIdentifier.loadMore,
                                                                                             ofKind: UICollectionView.elementKindSectionFooter,
                                                                                             for: indexPath)
            guard let loadMoreReusableView = loadMoreReusableView as? LoadMoreReusableView else {
                return nil
            }
            if self.hasMoreItems {
                loadMoreReusableView.startAnimation()
            } else {
                loadMoreReusableView.stopAnimation()
            }
            return loadMoreReusableView
        }
        snapShot.appendSections([1])
    }
    
    private func triggerLoadMore(currentIndexPath indexPath: IndexPath) {
        if indexPath.row == (snapShot.numberOfItems - 1), hasMoreItems {
            presenter.getListAnimes()
        }
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        triggerLoadMore(currentIndexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let minimumInteritemSpacing: CGFloat = (flowLayout?.minimumInteritemSpacing ?? 0)
        return CGSize(width: collectionView.bounds.width / 3 - (minimumInteritemSpacing),
                      height: collectionView.bounds.height / 4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: hasMoreItems ? 50 : .zero)
    }
}

// MARK: - MainViewControllerPresenterDelegate
extension MainViewController: MainViewControllerPresenterDelegate {
    func onLoadedEntities(_ entities: [MainViewControllerEntity], hasMore: Bool) {
        hasMoreItems = hasMore
        snapShot.appendItems(entities)
        dataSource?.apply(snapShot)
    }
}
