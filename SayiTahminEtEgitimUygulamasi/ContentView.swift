//
//  ContentView.swift
//  SayiTahminEtEgitimUygulamasi
//
//  Created by Atakan Cengiz KURT on 2.12.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            VStack(spacing: 100){
                Text("Tahmin Oyunu").font(.largeTitle)
                    .foregroundColor(.gray)
                
                Image(systemName: "dice.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                NavigationLink {
                    TahminEkrani()
                } label: {
                    Text("Oyuna Başla")
                        .frame(width: 300, height: 100).font(.largeTitle)
                        .background(.pink)
                        .foregroundColor(.white)
                        .cornerRadius(50)
                }

            }.navigationTitle("Anasayfa")
            
        }
    }
}

struct TahminEkrani: View {
    
    @State private var tahminGirdisi = ""
    @State private var sayfaAcilsinmi = false
    @State private var sonuc = false
    
    @State private var kalanHak = 5
    @State private var yonlendirme = ""
    @State private var rasgeleSayi = 0
    @FocusState private var isTahminGirdisiFocused : Bool
     
    var body: some View {
        VStack(spacing: 50){
            Text("Kalan Hak: \(kalanHak)")
                .font(.largeTitle)
                .foregroundColor(.pink)
            
            Text("\(yonlendirme)")
                .font(.largeTitle)
                
            TextField("Tahmin Giriniz", text: $tahminGirdisi)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.largeTitle)
                .padding()
                .focused($isTahminGirdisiFocused)
            
            Button {
                
                
                if let tahmin = Int(self.tahminGirdisi){
                    
                    self.kalanHak -= 1
                    
                if self.kalanHak != 0{
                    if tahmin > self.rasgeleSayi{
                        self.yonlendirme = "Azalt"
                    }else if tahmin < self.rasgeleSayi{
                        self.yonlendirme = "Arttır"
                    }else if tahmin == self.rasgeleSayi{
                        self.sonuc = true
                        self.sayfaAcilsinmi = true
                        oyunuSifirla()
                    }
                    
                }else{
                    //Haklarımız bitti
                    self.sonuc = false
                    self.sayfaAcilsinmi = true
                    oyunuSifirla()
                }
                    self.tahminGirdisi = ""
                }else{
                    self.tahminGirdisi = ""
                }
                
            } label: {
                Text("TAHMİN ET")
                    .frame(width: 300, height: 100).font(.largeTitle)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }
            .sheet(isPresented: $sayfaAcilsinmi) {
                SonucEkrani(gelenSonuc: sonuc)
            }.onAppear {
                self.rasgeleSayi = Int.random(in: 0...100)
                print("⚡️⚡️Rasgele Sayı: \(rasgeleSayi)")
                self.isTahminGirdisiFocused = true
            }
   
        }.navigationTitle("Tahmin Ekranı")
    }
    
    func oyunuSifirla(){
        self.rasgeleSayi = Int.random(in: 0...100)
        print("⚡️⚡️Rasgele Sayı: \(rasgeleSayi)")
        self.kalanHak = 5
        self.yonlendirme = ""
    }
}

struct SonucEkrani: View {
    @Environment(\.presentationMode) var sunumModu
    var gelenSonuc: Bool
    
    var body: some View {
        VStack(spacing: 50){
          
            if gelenSonuc{
            Image(systemName: "face.smiling.fill")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundColor(.green)
            
            Text("Kazandınız")
                .font(.largeTitle)
                .foregroundColor(.pink)
            }else{
                Image(systemName: "plusminus.circle.fill")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.red)
                
                Text("Kaybettiniz")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
                
           
            
            Button {
                self.sunumModu.wrappedValue.dismiss()
            } label: {
                Text("Tekrar Dene")
                    .frame(width: 300, height: 100).font(.largeTitle)
                    .background(.pink)
                    .foregroundColor(.white)
                    .cornerRadius(50)
            }

            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
