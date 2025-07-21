//
//  AgreementItem.swift
//  NBCinema
//
//  Created by estelle on 7/21/25.
//

struct AgreementItem {
    let title: String
    let isRequired: Bool
    let button: AgreeButton
    
    init(title: String, isRequired: Bool) {
        self.title = title
        self.isRequired = isRequired
        self.button = AgreeButton(title: title)
    }
}
