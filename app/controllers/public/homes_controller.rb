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
    @theme = Challenge.last&.theme || "No theme today"
  end

  def guideline
  end
end
