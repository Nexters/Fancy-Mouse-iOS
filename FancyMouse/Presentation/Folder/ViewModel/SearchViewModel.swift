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
    }
    
    //TODO: DB연동 후 삭제 예정
    struct MockStruct {
        let spelling: String
        let meaning: String
    }
    
    //TODO: DB연동 후 수정 예정
    private let mockData = [
        MockStruct(spelling: "Apple", meaning: "사과"),
        MockStruct(spelling: "Annoying", meaning: "성가신"),
        MockStruct(spelling: "Hate", meaning: "싫다"),
        MockStruct(spelling: "Happy", meaning: "행복한"),
        MockStruct(spelling: "Beggar", meaning: "거지같은"),
        MockStruct(spelling: "Xcode", meaning: "엑스코드")
    ]
    
    private let searchText = PublishSubject<String>()
    private let searchResult = BehaviorSubject<[String: String]>(value: [:])
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        input.searchTextInput
            .bind(to: searchText)
            .disposed(by: disposeBag)
        
        searchText
            .bind(onNext: { str in
                var resultList = [String: String]()
                
                for item in self.mockData where !str.isEmpty {
                    let target = item.spelling.uppercased()
                    let input = str.uppercased()
                    
                    let equal = target.hasPrefix(input)
                    if equal { resultList[item.spelling] = item.meaning }
                }
                self.searchResult.onNext(resultList)
            }).disposed(by: disposeBag)
        
        return Output(searchResultOutput: searchResult)
    }
}
