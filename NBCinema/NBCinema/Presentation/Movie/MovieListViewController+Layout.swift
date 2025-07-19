//
//  MovieListViewController+Layout.swift
//  NBCinema
//
//  Created by Milou on 7/18/25.
//

import UIKit

extension MovieListViewController {
    internal func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let section = MovieSection(rawValue: sectionIndex)!
            
            switch section {
            case .nowPlaying:
                return self.createRankingSection()
            default:
                return self.createPosterSection(sectionType: section)
            }
        }
    }
    
    internal func createRankingSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.6),
            heightDimension: .fractionalWidth(0.85)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        section.visibleItemsInvalidationHandler = { visibleItems, offset, environment in
            // 화면(컨테이너)의 실제 콘텐츠 크기
            let containerSize = environment.container.effectiveContentSize
            
            // 현재 화면에 보이는 아이템들 중 실제 셀만 필터링 (supplementary view는 제외)
            for item in visibleItems.filter({ $0.representedElementCategory == .cell }) {
                
                // 현재 화면에 보이는 영역을 직사각형으로 정의
                let rect = CGRect(
                    x: offset.x,                    // 화면 시작점 X좌표
                    y: offset.y,                    // 화면 시작점 Y좌표
                    width: containerSize.width,     // 화면 너비
                    height: item.frame.height       // 셀 높이
                )
                
                // 셀과 화면 영역의 교집합(겹치는 부분) 계산
                // intersection = 셀이 화면에 실제로 보이는 영역
                let intersection = item.frame.intersection(rect)
                
                // intersection.width: 셀이 화면에 보이는 너비
                // item.frame.width: 셀의 전체 너비
                let scale = 0.8 + (0.2 * (intersection.width / item.frame.width))
                
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }
        
        return section
    }
    
    internal func createPosterSection(sectionType: MovieSection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.36),
            heightDimension: .absolute(230)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.interGroupSpacing = 20
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 0)
        
        if sectionType.showHeader {
            section.boundarySupplementaryItems = [createSectionHeader()]
        }
        
        return section
    }
    
    internal func createSectionHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(44)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
