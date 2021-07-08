<img width="300" alt="kirico-logo" src="https://cloud.githubusercontent.com/assets/2214179/22500174/267fa8a8-e8a6-11e6-905f-fc79a049afab.png">

# kirico [ ![](https://img.shields.io/gem/v/kirico.svg)](https://rubygems.org/gems/kirico) [ ![](https://img.shields.io/gem/dt/kirico.svg)](https://rubygems.org/gems/kirico)

[![CircleCI](https://circleci.com/gh/kufu/kirico.svg?style=svg)](https://circleci.com/gh/kufu/kirico)

A Ruby implementation of 届書作成プログラム

## 理念

2008 年より[電子政府（e-Gov）のウェブサイト](https://shinsei.e-gov.go.jp/)上で社会保険・労働保険関連手続きの電子申請の受付が開始されました。
2010 年には e-Gov の使い勝手の向上を図り、一括申請機能の提供が開始されました。
そして 2014 年 10 月、さらなる利便性の向上を目的に、外部連携 API 仕様が公開されました。

これまで様々な取組が行われてきた一方で、確定申告などで利用される国税の電子申告（e-Tax）と比べるとまだまだ普及度が低いのが実情です。
また、一部の電子申請では年金機構の公開する「届書作成プログラム」を利用して CSV ファイルを生成する必要があり、一般利用者、ソフトウェア開発者共に負担となるものでした。

わたしたちは kirico の開発・公開によって CSV 形式の電子申請への対応を容易にすることで e-Gov 外部連携 API に対応したソフトウェアが増えることを期待します。
そして、電子政府の認知度の向上、利用率の向上、及び利用の拡大に貢献し、もってユーザの利便性の向上を目指します。


## インストール

Gemfile に追記して:

```ruby
gem 'kirico'
```

bundle コマンドを実行します:

```bash
$ bundle
```

もしくは、直接インストール:

```bash
$ gem install kirico
```

## 使い方


<img width="500" alt="data structure" src="https://cloud.githubusercontent.com/assets/2214179/23646339/c7f056b6-0353-11e7-9632-b1aeb0ed3458.png">

_データ構造: 仕様書 p.6-2 より_


**FD 管理レコード**

```ruby
require 'kirico'
require 'i18n'
I18n.locale = :ja

# FD 管理レコード
fd = Kirico::FDManagementRecord.new do |rec|
  rec.prefecture_code = '21'
  rec.area_code = '03'
  rec.office_code = 'ｷﾘｺ'
  rec.fd_seq_number = '001'
  rec.created_at = Date.new(2017, 1, 1)
end

fd.valid? #=> true

fd.office_code = 'ほげ'
fd.valid? #=> false
fd.errors #=> 略
```

**事業所情報**

```ruby
require 'kirico'
require 'i18n'
I18n.locale = :ja

# 事業所情報
company = Kirico::Company.new do |rec|
  rec.prefecture_code = '21'
  rec.area_code = '03'
  rec.office_code = 'ｷﾘｺ'
  rec.office_number = '1234'
  rec.zip_code1 = '123'
  rec.zip_code2 = '4567'
  rec.address = '東京都世田谷区上馬0-0-0'
  rec.name = '株式会社印度カレー'
  rec.owner_name = '内藤　キリコ'
  rec.tel_area_code = '03'
  rec.tel_city_code = '0000'
  rec.tel_subscriber_number = '0000'
end

company.valid? #=> true

company.name = '株式会社印度咖喱'
company.valid? #=> false
company.errors #=> 略
```

**データレコード（住所変更届）**

```ruby
require 'kirico'
require 'i18n'
I18n.locale = :ja

# 住所変更届データレコード
address_record = Kirico::DataRecord22187041.new do |rec|
  rec.area_code = '03'
  rec.office_code = 'ｷﾘｺ'
  rec.ip_code = '100'
  rec.basic_pension_number1 = '1234'
  rec.basic_pension_number2 = '567890'
  rec.birth_at = Date.new(1984, 7, 23)
  rec.zip_code1 = '123'
  rec.zip_code2 = '4567'
  rec.new_address_yomi = 'ﾄｳｷｮｳﾄｼﾌﾞﾔｸｻｸﾗｶﾞｵｶ'
  rec.new_address = '東京都渋谷区桜丘'
  rec.updated_at = Date.new(2017, 3, 7)
  rec.ip_name_yomi = 'ﾀﾅｶ ﾀﾛｳ'
  rec.ip_name = '田中　太郎'
  rec.old_address_yomi = 'ﾄｳｷｮｳﾄｵｵﾀｸｳﾉｷ'
  rec.old_address = '東京都大田区鵜の木'
  rec.memo = 'メモメモ'
end

address_record.valid? #=> true

address_record.ip_name_yomi = 'タナカタロウ'
address_record.valid? #=> false
address_record.errors #=> 略
```

**CSV 生成用フォーム**

```ruby
require 'kirico'
require 'i18n'
I18n.locale = :ja

# FD 管理用レコード
fd = Kirico::FDManagementRecord.new do |rec|
  rec.area_code = '03'
  # ...
end

company = Kirico::Company.new do |rec|
  rec.area_code = '03'
  # ...
end

address_record = Kirico::ChangingAddressRecord.new do |rec|
  rec.area_code = '03'
  # ...
end

form = Kirico::Form.new(fd: fd, company: company, records: [address_record])
form.valid? #=> true

# CSV ファイルの生成
File.open(Kirico::Form::FILE_NAME, 'w') do |f|
  f.puts(form.to_csv)
end
```


## 生成した CSV の検証

日本年金機構の公開している検証プログラムで生成した CSV ファイルを検証することもできます。
※動作には Windows 環境が必要となります

<img width="400" alt="kirico-logo" src="https://cloud.githubusercontent.com/assets/2214179/23650706/609ed1e6-0366-11e7-92d9-625354982b9f.png">

検証プログラムのダウンロードはこちらから。
[電子申請を利用中の方へ｜日本年金機構](https://www.nenkin.go.jp/denshibenri/program/download.html)


## 対応手続き

|  データレコード | クラス名 | 実装状況 |
|  ------ | ------ | ------ |
|  資格取得届データレコード | Kirico::DataRecord22007041 | △ |
|  資格喪失届データレコード | Kirico::DataRecord22017041 | △ |
|  住所変更届データレコード | Kirico::DataRecord22187041 | ◯ |
|  算定基礎届データレコード | Kirico::DataRecord2225700 | ◯ |
|  月額変更届データレコード | Kirico::DataRecord2221700 | ◯ |
|  賞与支払届データレコード | Kirico::DataRecord2265700 | ◯ |
|  被扶養者（異動）届データレコード | Kirico::DataRecord22027051 | △ |
|  3号関係届（資格取得）データレコード | Kirico::DataRecord52805011 | △ |
|  3号関係届（資格喪失）データレコード | Kirico::DataRecord52805021 | △ |
|  3号関係届（死亡）データレコード | Kirico::DataRecord52805031 | △ |
|  国民年金第3号被保険者<br>被扶養配偶者非該当届データレコード | Kirico::DataRecord52811001 | △ |


※実装状況について

- ◯: 実装、テスト済み
- △: 実装予定

## 参考リンク

- [電子申請を利用中の方へ｜日本年金機構](https://www.nenkin.go.jp/denshibenri/program/download.html)
    届書作成プログラム仕様について

## Contributing

1. Fork it ( https://github.com/kufu/kirico/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Code of Conduct

Everyone interacting in the kirico project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/kufu/kirico/blob/master/CODE_OF_CONDUCT.md).


## Copyright

Copyright (c) 2017 Kensuke NAITO and SmartHR, Inc.
ライセンスはこちら: [kirico/LICENSE.md](https://github.com/kufu/kirico/blob/master/LICENSE.md)


# SmartHR について

<img src="https://user-images.githubusercontent.com/2214179/30309095-3fb58b08-97c4-11e7-939b-b4b97414bb1d.png" width="300">

kirico は株式会社 SmartHR によってメンテナンス、開発が行われています。
わたしたちは OSS の力を信じています。

SmartHR では OSS 活動に積極的なエンジニアを募集しています！

[「雇用」×「国のAPI」をハックする Ruby エンジニア募集！](https://www.wantedly.com/projects/3788)


# kirico について

切子（kirico）とは江戸時代末期より生産されている伝統的なガラス細工です。
中でも薩摩切子は薩摩藩御用達の工芸品であり、多くの大名に珍重されてきました。
色付きの厚いガラスを被せ文様を彫るため、薄く繊細な江戸切子と比較すると、重厚な印象が特徴的です。
幕末の動乱の中で生産設備に壊滅的な被害を受け、その技術は一時途絶えていましたが、
近年、各地の職人の努力により復刻に成功しました。
