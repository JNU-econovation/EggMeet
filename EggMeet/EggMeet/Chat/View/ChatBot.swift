//
//  ChatBot.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/23.
//

import Foundation

protocol ChatBot{
    func sendMentorRequest()
    func sendWelcomeChatroom()
    func sendRegisterSchedule()
    func sendConfirmMentoring()
    func sendRejectMentoring()
    func sendChatBotTest()
}
