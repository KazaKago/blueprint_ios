//
//  AboutScreen.swift
//  Presentation.View
//
//  Created by Kensuke Tamura on 2021/05/10.
//

import SwiftUI
import Presentation_ViewModel
import Domain_Model

struct AboutScreen: View {

    let uiState: AboutUiState
    let onClickWebSite: (_ url: URL) -> Void
    let onClickMail: (_ mail: Email) -> Void

    init(
        uiState: AboutUiState,
        onClickWebSite: @escaping (_ url: URL) -> Void,
        onClickMail: @escaping (_ mail: Email) -> Void
    ) {
        self.uiState = uiState
        self.onClickWebSite = onClickWebSite
        self.onClickMail = onClickMail
    }

    var body: some View {
        ScrollView {
            VStack {
                Group {
                    Image("profile", bundle: Bundle.current)
                    Spacer()
                        .frame(height: 16)
                    Text("app_name".localized)
                        .font(.largeTitle)
                    Spacer()
                        .frame(height: 8)
                    Text(uiState.classify(
                        onLoading: {
                            "loading".localized
                        },
                        onCompleted: { appInfo, developerInfo in
                            String(format: "about_ver".localized, appInfo.versionName.value, appInfo.versionCode.value)
                        }
                    ))
                    .font(.caption)
                    Spacer()
                        .frame(height: 4)
                    Text(uiState.classify(
                        onLoading: {
                            "loading".localized
                        },
                        onCompleted: { appInfo, developerInfo in
                            String(format: "about_develop_by".localized, developerInfo.name)
                        }
                    ))
                    .font(.caption)
                    Spacer()
                        .frame(height: 16)
                }
                Group {
                    Button(action: { uiState.onDeveloperMailAddress(onClickMail) }) {
                        HStack(spacing: 48) {
                            Image(systemName: "mail")
                            Text("about_email".localized)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                    Button(action: { uiState.onDeveloperSiteUrl(onClickWebSite) }) {
                        HStack(spacing: 48) {
                            Image(systemName: "book")
                            Text("about_web_site".localized)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.init(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                }
                Group {
                    Spacer()
                        .frame(height: 16)
                    Text(uiState.classify(
                        onLoading: {
                            "loading".localized
                        },
                        onCompleted: { appInfo, developerInfo in
                            String(format: "about_copyright".localized, Calendar.current.component(.year, from: Date()), developerInfo.name)
                        }
                    ))
                    .font(.caption)
                    Spacer()
                        .frame(height: 16)
                }
            }
        }
        .navigationBarTitle("about_title".localized)
    }
}

struct AboutScreenOnLoading_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen(
            uiState: .loading,
            onClickWebSite: { url in },
            onClickMail: { mail in }
        )
    }
}

struct AboutScreenOnCompleted_Previews: PreviewProvider {
    static var previews: some View {
        AboutScreen(
            uiState: .completed(
                appInfo: AppInfo(
                    versionName: VersionName("1.0.0"),
                    versionCode: VersionCode(1)
                ),
                developerInfo: DeveloperInfo(
                    name: "KazaKago",
                    mailAddress: Email("kazakago@gmail.com"),
                    siteUrl: URL(string: "https://blog.kazakago.com")!
                )
            ),
            onClickWebSite: { _ in },
            onClickMail: { _ in }
        )
    }
}
