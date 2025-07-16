//
//  KeychainService.swift
//  NBCinema
//
//  Created by seongjun cho on 7/16/25.
//

import Foundation
import Security

class KeychainService {

	// MARK: - Save
	// 성공시 true, 실패시 false 반환
	// 결과값 사용하지 않아도 경고 안뜸
	@discardableResult
	static func save(service: String, account: String, value: String) -> Bool {
		guard let valueData = value.data(using: .utf8) else { return false }

		// 기존 데이터 삭제
		delete(service: service, account: account)

		let query: [CFString: Any] = [
			kSecClass : kSecClassGenericPassword,
			kSecAttrService : service,
			kSecAttrAccount : account,
			kSecValueData : valueData
		]

		let status = SecItemAdd(query as CFDictionary, nil)
		return status == errSecSuccess
	}

	// MARK: - Load
	// 저장 되어있는 value값이 문자열로 반환됩니다.
	static func load(service: String, account: String) -> String? {
		let query: [CFString : Any] = [
			kSecClass : kSecClassGenericPassword,
			kSecAttrService : service,
			kSecAttrAccount : account,
			kSecReturnData : true,
			kSecMatchLimit : kSecMatchLimitOne
		]

		var item: CFTypeRef?
		let status = SecItemCopyMatching(query as CFDictionary, &item)

		guard status == errSecSuccess,
			  let data = item as? Data,
			  let result = String(data: data, encoding: .utf8) else {
			return nil
		}
		return result
	}

	// MARK: - Delete
	// 성공시 true, 실패시 false 반환
	// 결과값 사용하지 않아도 경고 안뜸
	@discardableResult
	static func delete(service: String, account: String) -> Bool {
		let query: [CFString : Any] = [
			kSecClass : kSecClassGenericPassword,
			kSecAttrService : service,
			kSecAttrAccount : account
		]

		let status = SecItemDelete(query as CFDictionary)
		return status == errSecSuccess
	}
}
