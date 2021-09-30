//
//  ContentView.swift
//  WetaherApp
//
//  Created by user on 30.09.2021.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ContentView: View {
    @State var city = ""
    @State var temp = ""
    @State var showAlert = false
    @State var showMessage = ""
    var body: some View {
        VStack {
            Text(temp == "" ? "0"  : temp)
                .padding()
            Text("Hello, world!")
                .padding()
            TextField("Введите город:", text: $city)
            Button {
                let token = "41aec4693a1c4c13928105800213009"
                let url = "https://api.weatherapi.com/v1/current.json?key=\(token)&q=\(city)&aqi=no"
                AF.request(url, method: .get).validate().responseJSON {
                    response in
                    switch response.result {
                    case .success(let value):
                        let json = JSON(value)
                        temp = json["current"]["temp_c"].stringValue
                        print("JSON: \(json)")
                    case .failure(let error):
                        showMessage = error.localizedDescription
                        showAlert.toggle()
                        print(error)
                    }
                }
            } label: {
                    Text("Узнать погоду")
                }
            
        }.alert(isPresented: $showAlert, content: {
            Alert(title: Text("Ошибка"), message: Text(showMessage), dismissButton: .cancel())
        })
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 12")
    }
}
