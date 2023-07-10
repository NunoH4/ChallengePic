class Public::HomesController < ApplicationController
  # お題テーブル
  # t.string: :color

  # 答えテーブル
  # t.integer :お題テーブル_id
  # t.text :回答

  # コントローラー(1の場合)
  # def お題
  #   @お題 = お題テーブル.last
  # end

  # 1. デイリーで、wheneverでお題を作りお題テーブルに入れるバッチ処理を組む
  #     Refs: https://qiita.com/hirotakasasaki/items/3b31966294a809b99c4c
  #     Refs: https://zenn.dev/yusuke_docha/articles/2d2cfd1030f6ac
  # 2. 前回作成したお題から日付が変更されていたら新しいお題を作り、お題テーブルへ


  def top
    @daily_theme = Faker::Color.color_name
  end

  def top
    #お題を表示する際、まずキャッシュをチェックする。キャッシュが存在する場合はそれを使用し、存在しない場合は新たなお題を生成する。その際、現在の日付をキーとしてテーマをキャッシュする。
    @daily_theme = Rails.cache.fetch("daily_theme/#{Date.current.to_s}", expires_in: 24.hours) do
      Faker::Color.name
    end
  end

  def guideline
  end
end
