//
//  Hero.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 21/08/23.
//

import Foundation
import UIKit

enum PrimaryAttribute: String, Codable {
    case all
    case agi
    case int
    case str
    
    var title: String {
        switch self {
        case .all:
            return "Universal"
        case .agi:
            return "Agility"
        case .int:
            return "Intelligence"
        case .str:
            return "Strength"
        }
    }
    
    var color: UIColor? {
        switch self {
        case .all:
            return .systemPurple
        case .agi:
            return .systemGreen
        case .int:
            return .systemBlue
        case .str:
            return .systemRed
        }
    }
    
    var icon: String {
        switch self {
        case .all:
            return "🟪"
        case .agi:
            return "🟩"
        case .int:
            return "🟦"
        case .str:
            return "🟥"
        }
    }
}

enum AttackType: String, Codable {
    case melee = "Melee"
    case ranged = "Ranged"
    
    var icon: String {
        switch self {
        case .melee:
            return "🗡️"
        case .ranged:
            return "🏹"
        }
    }
}

struct Hero: Codable {
    var id: Int
    var name: String
    var localizedName: String
    var primaryAttr: PrimaryAttribute
    var attackType: AttackType
    var roles: [String]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case localizedName  = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles = "roles"
    }
}

struct HeroDetail: Codable {
    var id: Int
    var name: String
    var localizedName: String
    var primaryAttr: PrimaryAttribute
    var attackType: AttackType
    var roles: [String]
    var img: String
    var icon: String
    var baseHealth: Int
    var baseHealthRegen: Double
    var baseMana: Int
    var baseManaRegen: Double
    var baseArmor: Double
    var baseMr: Int
    var baseAttackMin: Int
    var baseAttackMax: Int
    var baseStr: Int
    var baseAgi: Int
    var baseInt: Int
    var strGain: Double
    var agiGain: Double
    var intGain: Double
    var attackRange: Int
    var projectileSpeed: Int
    var attackRate: Double
    var baseAttackTime: Int
    var attackPoint: Double
    var moveSpeed: Int
    var turnRate: Double?
    var cmEnabled: Bool
    var legs: Int
    var dayVision: Int
    var nightVision: Int
    var heroID: Int
    var turboPicks: Int
    var turboWINS: Int
    var proBan: Int
    var proWin: Int
    var proPick: Int
    var the1_Pick: Int
    var the1_Win: Int
    var the2_Pick: Int
    var the2_Win: Int
    var the3_Pick: Int
    var the3_Win: Int
    var the4_Pick: Int
    var the4_Win: Int
    var the5_Pick: Int
    var the5_Win: Int
    var the6_Pick: Int
    var the6_Win: Int
    var the7_Pick: Int
    var the7_Win: Int
    var the8_Pick: Int
    var the8_Win: Int
    var nullPick: Int
    var nullWin: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case localizedName = "localized_name"
        case primaryAttr = "primary_attr"
        case attackType = "attack_type"
        case roles = "roles"
        case img = "img"
        case icon = "icon"
        case baseHealth = "base_health"
        case baseHealthRegen = "base_health_regen"
        case baseMana = "base_mana"
        case baseManaRegen = "base_mana_regen"
        case baseArmor = "base_armor"
        case baseMr = "base_mr"
        case baseAttackMin = "base_attack_min"
        case baseAttackMax = "base_attack_max"
        case baseStr = "base_str"
        case baseAgi = "base_agi"
        case baseInt = "base_int"
        case strGain = "str_gain"
        case agiGain = "agi_gain"
        case intGain = "int_gain"
        case attackRange = "attack_range"
        case projectileSpeed = "projectile_speed"
        case attackRate = "attack_rate"
        case baseAttackTime = "base_attack_time"
        case attackPoint = "attack_point"
        case moveSpeed = "move_speed"
        case turnRate = "turn_rate"
        case cmEnabled = "cm_enabled"
        case legs = "legs"
        case dayVision = "day_vision"
        case nightVision = "night_vision"
        case heroID = "hero_id"
        case turboPicks = "turbo_picks"
        case turboWINS = "turbo_wins"
        case proBan = "pro_ban"
        case proWin = "pro_win"
        case proPick = "pro_pick"
        case the1_Pick = "1_pick"
        case the1_Win = "1_win"
        case the2_Pick = "2_pick"
        case the2_Win = "2_win"
        case the3_Pick = "3_pick"
        case the3_Win = "3_win"
        case the4_Pick = "4_pick"
        case the4_Win = "4_win"
        case the5_Pick = "5_pick"
        case the5_Win = "5_win"
        case the6_Pick = "6_pick"
        case the6_Win = "6_win"
        case the7_Pick = "7_pick"
        case the7_Win = "7_win"
        case the8_Pick = "8_pick"
        case the8_Win = "8_win"
        case nullPick = "null_pick"
        case nullWin = "null_win"
    }
}
