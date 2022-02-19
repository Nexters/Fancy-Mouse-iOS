//
//  SearchViewModel.swift
//  FancyMouse
//
//  Created by 한상진 on 2022/02/19.
//

import RxSwift

final class SearchViewModel {
    struct Input {
        var searchTextInput: Observable<String>
    }
    
    struct Output {
        var searchResultOutput: Observable<[String: String]>
        var recentSearchWordsOutput: Observable<[String: String]>
    }
    
    //TODO: DB연동 후 삭제 예정
    struct MockWordStruct {
        let spelling: String
        let meaning: String
    }
    struct MockRecentWordsStruct {
        let spelling: String
        let date: String
    }
    
    //TODO: DB연동 후 수정 예정
    private let mockWordsData = [
        MockWordStruct(spelling: "Apple", meaning: "사과"),
        MockWordStruct(spelling: "Annoying", meaning: "성가신"),
        MockWordStruct(spelling: "Hate", meaning: "싫다"),
        MockWordStruct(spelling: "Happy", meaning: "행복한"),
        MockWordStruct(spelling: "Beggar", meaning: "거지같은"),
        MockWordStruct(spelling: "Xcode", meaning: "엑스코드")
    ]
    
    private let mockRecentWordsData = [
        MockRecentWordsStruct(spelling: "Xcode", date: "02-19"),
        MockRecentWordsStruct(spelling: "Hate", date: "02-19")
    ]
    
    private let searchText = PublishSubject<String>()
    private let searchResult = BehaviorSubject<[String: String]>(value: [:])
    private let recentSearch = BehaviorSubject<[String: String]>(value: [:])
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.searchTextInput
            .bind(to: searchText)
            .disposed(by: disposeBag)
        
        searchText
            .bind { str in
                var resultList = [String: String]()
                
                for item in self.mockWordsData where !str.isEmpty {
                    let target = item.spelling.uppercased()
                    let input = str.uppercased()
                    
                    let equal = target.hasPrefix(input)
                    if equal { resultList[item.spelling] = item.meaning }
                }
                self.searchResult.onNext(resultList)
            }.disposed(by: disposeBag)
        
        var recentList = [String: String]()
        for item in self.mockRecentWordsData {
            recentList[item.spelling] = item.date
        }
        recentSearch.onNext(recentList)
        
        return Output(searchResultOutput: searchResult, recentSearchWordsOutput: recentSearch)
    }
}
