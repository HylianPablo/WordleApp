//
//  ViewController.swift
//  Wordle
//
//  Created by Pablo Martinez Lopez on 15/4/22.
//

import UIKit

class ViewController: UIViewController {
    
    let answer = "pablo"
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    
    let keyboradVC = KeyboardViewController()
    let boardVC = BoardViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGray4
        self.addChildren()
    }
    
    private func addChildren() {
        self.addChild(keyboradVC)
        keyboradVC.didMove(toParent: self)
        keyboradVC.delegate = self
        keyboradVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(keyboradVC.view)
        
        self.addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.datasource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(boardVC.view)
        
        self.addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            boardVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboradVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6),
            
            keyboradVC.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            keyboradVC.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            keyboradVC.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        var stop = false
        for i in 0..<guesses.count {
            for j in 0..<guesses[i].count {
                if guesses[i][j] == nil {
                    guesses[i][j] = letter
                    stop = true
                    break
                }
            }
            if stop {
                break
            }
        }
        self.boardVC.reloadData()
    }
}

extension ViewController: BoardViewControllerDatasource {
    var currentGuesses: [[Character?]] {
        return guesses
    }
    
    func boxColor(at indexPath: IndexPath) -> UIColor? {
        let rowIndex = indexPath.section
        let count = guesses[rowIndex].compactMap({$0}).count
        guard count == 5 else { return nil }
        
        let indexedAnswer = Array(answer)
        guard let letter = guesses[indexPath.section][indexPath.row],
              indexedAnswer.contains(letter) else {
            return nil
        }
        
        if indexedAnswer[indexPath.row] == letter {
            return .systemGreen
        }
        return .systemOrange
    }
}

