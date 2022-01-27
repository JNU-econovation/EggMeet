//
//  Location.swift
//  EggMeet
//
//  Created by asong on 2022/01/13.
//

import Foundation

enum Location: String, Codable, CaseIterable{
    case ALL = "전체",

         SEOUL_JONGRO_JUNGGU_YOUNGSAN = "서울 중구 용산",
         SEOUL_GANGNAM_SEOCHO_YANGZE = "서울 강남 서초 양제",
         SEOUL_MAPO_SEODAEMUN_EUNPYEONG = "서울 마포 서대문 은평",
         SEOUL_SONGPA_GANGDONG_ZAMSIL = "서울 송파 강동 잠실",
         SEOUL_DONGDAEMUN_JUNRANG_GWANGZIN_SEONGDONG = "서울 동대문 준랑 광진 성동",
         SEOUL_NOWON_DOBONG_GANGBUK_SEONGBUK = "서울 노원 도봉 강북 성북",
         SEOUL_GANGSEO_YANGCHEON_GEUMCHEON = "서울 강서 양천 금천",
         SEOUL_YEONGDEUNGPO_GURO_SINDORIM = "서울 영등포 구로 신도림",
         SEOUL_DONGZAK_KWANAK_SADANG = "서울 동작 관악 사당",

         GYEONGGI_SEONGNAM_BUNDANG_PANGYO = "경기 성남 분당 판교",
         GYEONGGI_YEONGIN_ZUKZEON_SUJI = "경기 영인 죽전 수지",
         GYEONGGI_SUWON_YEONGTONG_GWANGGYO = "경기 수원 영통 광교",
         GYEONGGI_ANYANG_GWACHEON_GUNPO_UIWANG = "경기 안양 과천 군포 의왕",
         GYEONGGI_ANSAN = "경기 안산",
         GYEONGGI_BUCHEON_GWANGMYEONG_SIHEUNG = "경기 부천 광명 시흥",
         GYEONGGI_HWASEONG_DONGTAN = "경기 화성 동탄",
         GYEONGGI_OSAN_PYEONGTAEK_ANSUN = "경기 오산 평택 안선",
         GYEONGGI_GURI_HANAM_NAMYANGJU = "경기 구리 하남 남양주",
         GYEONGGI_GAPYEONG_YANGPYEONG = "경기 가평 양평",
         GYEONGGI_GWANGJU_YICHEON_YEOJU = "경기 광주 이천 여주",
         GYEONGGI_GOYANG_GIMPO_PAJU_ILSAN = "경기 고양 김포 파주 일산",
         GYEONGGI_UIJUNGBU_YANGJU_DONGDUCHEON = "경기 의정부 양주 동두천",
         GYEONGGI_POCHEON_YEONCHEON = "경기 포천 연천",


         GYEONGBUK = "경북",
         GYEONGNAM = "경남",

         GWANGJU_BUKGU = "광주 북구",
         GWANGJU_SEOGU = "광주 서구",
         GWANGJU_NAMDONGGU_DONGGU = "광주 남동구 동구",
         GWANGJU_GWANGSANGU = "광주 광산구"
}
