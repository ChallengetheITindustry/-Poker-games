require "minitest/autorun"
require "pry"
# ポーカーゲーム(テキサスホールデム)
# 最大プレイ人数5人
# →ユーザーに人数を入力させる。

# ルール
#

# ロジック
# 最初にSBとBBが設定され、選ばれた二人は指定の金額をベット必要がある。
# ユーザーにランダムに2枚のカードを配る。（それぞれのカードは等確率で配分される）
# ホールカードは5枚。ラウンドは1ゲームに４回。ラウンド終了後にホールカードが一枚ずつ開かれていく。
# ラウンド毎にユーザーはチェック、コール、レイズ、フォールドの行動を選択できる。

class Player
    def initialize(name)
        @name = name
    end

    def bet

    end

    def check

    end

    def call

    end

    def raise

    end

    def fold

    end
end

# class Game(cards)
#     def initialize()

#     end

#     def BB

#     end

#     def SB

#     end

#     def deal_cards
#         cards.sample(2)
#     end
# end

# ゲームの設定
class Setting
  def initialize
    points = 3000
  end

  def set_rate
    puts "まず、SBとBBを設定します。"

    while true
      print "SBを設定してください"
      small_blinds = gets.to_i
      if small_blinds <= 500
        break
      else
        puts "500以下の値を入力してください。"
      end
    end

    big_blinds = small_blinds * 2

    puts <<~TEXT
           SBとBBを以下の通り設定いたしました。
           これでよろしいですか？

           SB：#{small_blinds}
           BB：#{big_blinds}

           決定：1を押下
           再設定：2を押下
         TEXT

    while true
      setted_rate = gets.to_i
      if setted_rate == 1
        break
      elsif setted_rate == 2
        puts "再設定。"
        set_rate
      else
        puts "正しい値を入力してください"
      end
    end
  end

  def number_of_people(users)
    @users = users
    puts <<~TEXT
           プレイヤーの人数は#{@users}でよろしいですか？

           決定：1を押下
           再設定：2を押下
         TEXT

    while true
      setted_peoples = gets.to_i
      if setted_peoples == 1
        break
      elsif setted_peoples == 2
        puts "再設定。"
        number_of_people
      else
        puts "正しい値を入力してください"
      end
    end
  end

#   入力されたプレイヤーの人数分Playerを作成する
  def create_user(player)
    @users.times.with_index(1) do |user, i| 
        player << Player.new(name: "player#{i}")
    end
  end
end

class Dealer
  def initialize(cards, users)
    @cards = cards
    @users = users
  end

  def distribute_hand(p)
    binding.pry
    p.each do |play|
        play[:card1] << @cards.sample(1)
        play[:card2] << @cards.sample(1)
    end
  end
end

# =========================================================
cards = ["A", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"] * 4
cards.shuffle!
game = Setting.new
game.set_rate

# プレイヤーの人数を入力
while true
  puts <<~TEXT
         プレイヤーの人数を入力してください。
         ※2人以上5人以下で入力してください。
       TEXT
  users = gets.to_i
  if users >= 2 && users <= 5
    break
  else
    puts "2人以上5人以下で入力してください。"
  end
end

game.number_of_people(users)
dealer = Dealer.new(cards, users)
player = []
p = game.create_user(player)
dealer.distribute_hand(p)