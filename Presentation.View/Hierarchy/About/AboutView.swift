//
//  AboutView.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import SwiftUI
import Presentation_ViewModel

struct AboutView: View {

    @ObservedObject private var aboutViewModel: AboutViewModel = resolver().resolve(AboutViewModel.self)!

    var body: some View {
        VStack {
            Text("app_name".localized)
                .font(.largeTitle)
            Spacer()
                .frame(height: 24)
            Text(String(format: "about_ver".localized, aboutViewModel.appInfo?.versionName.value ?? "", aboutViewModel.appInfo?.versionCode.value ?? 0))
                .font(.title2)
            Spacer()
                .frame(height: 16)
            Text(String(format: "about_develop_by".localized, aboutViewModel.developerInfo?.name ?? ""))
                .font(.caption)
            Spacer()
                .frame(height: 32)
            Button(action: {
                if let developerInfo = aboutViewModel.developerInfo {
                    UIApplication.shared.open(developerInfo.mailAddress.toURL())
                }
            }) {
                HStack(spacing: 48) {
                    Image(systemName: "mail")
                    Text("about_email".localized)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))
            }
            Button(action: {
                if let developerInfo = aboutViewModel.developerInfo {
                    UIApplication.shared.open(developerInfo.siteUrl)
                }
            }) {
                HStack(spacing: 48) {
                    Image(systemName: "book")
                    Text("about_web_site".localized)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))
            }
            Spacer()
                .frame(height: 32)
            Text(String(format: "about_copyright".localized, Calendar.current.component(.year, from: Date()), aboutViewModel.developerInfo?.name ?? ""))
                .font(.caption)
        }
        .navigationBarTitle("about_title".localized)
        .onAppear {
            aboutViewModel.initialize()
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
