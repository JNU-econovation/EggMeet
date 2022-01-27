//
//  Category.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case IT_WEB = "프로그래밍 > 웹프론트엔드 개발",
         IT_BACKEND = "프로그래밍 > 백엔드 개발",
         IT_APP = "프로그래밍 > 모바일 앱 개발",
         IT_GAME = "프로그래밍 > 게임 개발",
         IT_DEVOPS = "프로그래밍 > DepOps",
         IT_MACHINE_LEARNING = "프로그래밍 > 머신러닝",
         IT_DATA_ANALYSIS = "프로그래밍 > 데이터분석",
         IT_PROGRAMING_LANGUAGE = "프로그래밍 > 프로그래밍 언어",
         IT_ETC = "프로그래밍 > 기타",
         
         LANGUAGE_ENGLISH = "외국어 > 영어",
         LANGUAGE_JAPANESE = "외국어 > 일본어",
         LANGUAGE_CHINESE = "외국어 > 중국어",
         LANGUAGE_SPANISH = "외국어 > 스페인어",
         LANGUAGE_FRENCH = "외국어 > 프랑스어",
         LANGUAGE_GERMAN = "외국어 > 독일어",
         LANGUAGE_RUSSIAN = "외국어 > 러시아어",
         LANGUAGE_ARABIC = "외국어 > 아랍어",
         LANGUAGE_ITALIAN = "외국어 > 이탈리아어",
         LANGUAGE_ETC = "외국어 > 기타",
         
         JOB_EMPLOY = "취업준비 > 취업/이직 코칭",
         JOB_PAPER = "취업준비 > 자기소개서 코칭",
         JOB_SKILL = "취업준비 > 직무 스킬",
         JOB_ETC = "취업준비 > 기타",
         LICENSE_GOVERNMENT = "자격증 > 국가 공인 자격증",
         LICENSE_ETC = "자격증 > 기타",
         
         MEDIA_EDIT = "사진/영상촬영 및 편집 > 편집",
         MEDIA_FILMING = "사진/영상촬영 및 편집 > 촬영",
         MEDIA_CAMERA = "사진/영상촬영 및 편집 > 카메라 활용",
         MEDIA_ETC = "사진/영상촬영 및 편집 > 기타" ,
         
         DESIGN_ILLUSTRATION = "디자인 > 일러스트",
         DESIGN_CONCEPT_ART = "디자인 > 컨셉아트",
         DESIGN_EMOTICON = "디자인 > 이모티콘",
         DESIGN_DRAWING = "디자인 > 드로잉",
         DESIGN_CALLIGRAPHY = "디자인 > 캘리그라피",
         DESIGN_TOOL = "디자인 > 디자인 툴",
         DESIGN_UIUX = "디자인 > UI/UX",
         DESIGN_VISUAL = "디자인 > 시각디자인",
         DESIGN_ETC = "디자인 > 기타",
         
         MARKETING_DIGITAL = "마케팅 > 디지털/SNS 마케팅",
         MARKETING_COPYRIGHTING = "마케팅 > 카피라이팅",
         MARKETING_DATA = "마케팅 > 데이터 마케팅",
         MARKETING_ETC = "마케팅 > 기타",
         
         INVESTMENT_ACCOUNTING = "투자/재테크 > 회계/세무/재무",
         INVESTMENT_STOCK = "투자/재테크 > 주식 투자",
         INVESTMENT_PROPERTY = "투자/재테크 > 부동산 투자",
         INVESTMENT_ETC = "투자/재테크 > 기타",
         
         MUSIC_THEORY = "작사/작곡 > 실용음악이론",
         MUSIC_COMPOSITION = "작사/작곡 > 작곡 및 프로듀싱",
         MUSIC_WRITING_LYRICS = "작사/작곡 > 작사",
         MUSIC_ETC = "작사/작곡 > 기타",
         
         EXPERIENCE_TRAVEL = "경험/조언/노하우 > 여행기",
         EXPERIENCE_FOUNDATION = "경험/조언/노하우 > 창업 경험담",
         EXPERIENCE_FAIL = "경험/조언/노하우 > 실패 극복 경험",
         EXPERIENCE_EMPLOYMENT = "경험/조언/노하우 > 취업 성공 노하우",
         EXPERIENCE_ETC = "경험/조언/노하우 > 기타"
}
extension CaseIterable {
    static func from(string: String) -> Self? {
        return Self.allCases.first { string == "\($0)" }
    }
    func toString() -> String { "\(self)" }
}
