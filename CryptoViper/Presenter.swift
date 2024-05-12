//
//  Presenter.swift
//  CryptoViper
//
//  Created by Aleyna Işıkdağlılar on 11.05.2024.
//

import Foundation

// Class, Protocol
// Talks to -> Interactor, Router, View

enum NetworkError: Error {
    case NetworkFailed
    case ParsingFailed
}

protocol AnyPresenter {
    
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? { get set}
    var view: AnyView? {get set}
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], Error>)
}

class CryptoPresenter: AnyPresenter {
    var router: (any AnyRouter)?
    
    var interactor: (any AnyInteractor)? {
        didSet {
            interactor?.downloadCryptos()
        }
    }
    
    var view: (any AnyView)?
    
    func interactorDidDownloadCrypto(result: Result<[Crypto], any Error>) {
        switch result {
        case .success(let cryptos):
            view?.update(with: cryptos)
        case .failure(_):
            view?.update(with: "Try again later ...")
        }
    }
    
    
}
