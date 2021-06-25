//
//  Fruit.swift
//  SampleTableAppB
//
//  Created by Mine Rala on 24.06.2021.
//

import Foundation
class Fruit {
    
    var image: String = ""
    var title: String = ""
    var desc: String = ""
    var isFavorited: Bool = false
    
    static func all() -> [Fruit] {
        
        var arrFruits: [Fruit] = []
        var fruit: Fruit
        
        fruit = Fruit()
        fruit.title = "Elma"
        fruit.desc = "En yakın akrabaları armut  ve malta eriğidir . 5–12 m’ye kadar uzanan yaprak döken tacı geniş küçük bir ağaçtır . Yapraklar  karşılıklı dizilişli, basit oval biçiminde, ucu sivri ve kenarları dişli, alt yüzü hafif tüylüdür. 5–12 cm uzunluğunda 3–6 cm genişliğindeki yaprakların sapı 2–5 cm kadardır. Çiçekler  yapraklarla birlikte açar. Beyaz olan çiçekler genellikle ilk açtığında açık pembedir. 2,5-3,5 cm çapında 5 taç yapraklıdır . Meyve sonbaharda olgunlaşır, ekseriya 5–8 cm çapındadır."
        fruit.image = "elma"
        fruit.isFavorited = false
        
        arrFruits.append(fruit)
        
        fruit = Fruit()
        fruit.title = "Armut"
        fruit.desc = "Her iki yarıkürenin ılıman iklim kuşağı ülkelerinde yetiştirilen armut, dünyanın en önemli meyve ağaçlarından biridir. Armut ağacı tepeye doğru genişleyen ve olgunlaştığında 13 m’ye ulaşan boyuyla elma ağacından daha uzun ve daha diktir.Armut, genellikle bir yaşındaki anaç armut fidanları üzerine aşılama ya da çelikleme yoluyla üretilir. Armut ağaçları oldukça uzun ömürlüdür (50-75 yıl) ve iyi bakılıp budanmazsa boyları iyice uzar. Dikildikten 4-7 yıl sonra meyve vermeye başlayan bir armut ağacı 8-10 yaşlarındayken 25–50 kg meyve verebilir."
        fruit.image = "armut"
        fruit.isFavorited = false
        
        arrFruits.append(fruit)
        
        fruit = Fruit()
        fruit.title = "Çilek"
        fruit.desc = "Tohumları meyvenin üzerinde (dışarıda) bulunan birkaç meyveden biridir. Bu yönüyle, çilek bir istisnadır, çünkü çoğu meyvenin tohumları meyvenin içinde bulunur."
        fruit.image = "cilek"
        fruit.isFavorited = false
        
        arrFruits.append(fruit)
        
        fruit = Fruit()
        fruit.title = "Karpuz"
        fruit.desc = "Karpuz, sıcak ve ılıman iklimde yetişir. Soğuklardan çok etkilendiği için yetişme devresinde don tehlikesi olmamalıdır. Tohum ekiminde toprak sıcaklığı 12 °C’nin üzerinde olmalıdır. Nem oranı fazla olan yerlerde hastalıklar görülebilir."
        fruit.image = "karpuz"
        fruit.isFavorited = false
        arrFruits.append(fruit)
        
        fruit = Fruit()
        fruit.title = "Muz"
        fruit.desc = "Dünya üzerinde meyvesi belki de en fazla tüketilen bitkilerden biridir. Muzun bu kadar aranmasının sebebi sadece kolay erişilebilen ve kolay tüketilebilen bir bitki olması değildir. Bu tüketimin ardında muzun çok besleyici bir besin kaynağı olması, birçok vitamin, protein, mineral ve aminoasiti içeriyor olması yatmaktadır. Batı Avrupa ülkelerinde sadece tadı ve kokusu için aranan bir meyve konumunda ise de üçüncü dünya ülkelerinde çok önemli bir besin maddesidir. Az gelişmiş ülkelerde çocuklar ihtiyaçları olan proteini muz yiyerek almaktadırlar. Faydaları şunlardır: Muz kemik gelişimini sağlar, sinir zafiyeti ve yorgunluğu giderir. Böbrek ve mafsal iltihabında, bağırsak hastalıklarında faydalıdır."
        fruit.image = "muz"
        fruit.isFavorited = false
        
        arrFruits.append(fruit)
        
        fruit = Fruit()
        fruit.title = "Uzüm"
        fruit.desc = "Üzüm 15 ila 300’lük gruplar halinde büyüyen ve kıpkırmızı, siyah, lacivert, sarı, yeşil, turuncu ve pembe renkli olabilen meyve  türüdür. “Beyaz” üzümler aslında yeşil renktedir ve evrimsel olarak mor üzümden elde edilir. Beyaz üzümün iki düzenleyici genindeki  mutasyon  mor üzümlerin renginin sorumlusu antosiyanin üretimini durdurur."
        fruit.image = "uzum"
        fruit.isFavorited = false
        
        arrFruits.append(fruit)
        
        return arrFruits
    }
}
