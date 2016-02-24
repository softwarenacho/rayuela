get '/_postgame/:player1&:player2&:score_p1&:score_p2' do
  name1 = params[:player1]
  name2 = params[:player2]
  score_p1 = params[:score_p1]
  score_p2 = params[:score_p2]
  score_p1 = score_p1.slice(3..5).to_i
  score_p2 = score_p2.slice(3..5).to_i
  @player1 = Player.find_by(name: name1)
  @player2 = Player.find_by(name: name2)
  if (score_p1 > 80) && (score_p2 > 80)
    #LOS DOS PIERDEN
    Game.create(player_1: @player1.id, player_2: @player2.id, winner: 0)
    @winner = "Both players have lost"
  elsif (score_p1 > score_p2) && (score_p1 <= 80)
    #PLAYER 1 GANA
    Game.create(player_1: @player1.id, player_2: @player2.id, winner: @player1.id)
    @winner = "#{@player1.name} won!"
  elsif (score_p1 <= 80) && (score_p2 > 80)
    #PLAYER 1 GANA
    Game.create(player_1: @player1.id, player_2: @player2.id, winner: @player1.id)
    @winner = "#{@player1.name} won!"
  elsif (score_p1 < score_p2) && (score_p2 <= 80)
    #PLAYER 2 GANA
    Game.create(player_1: @player1.id, player_2: @player2.id, winner: @player2.id)
    @winner = "#{@player2.name} won!"
  elsif (score_p2 <= 80) && (score_p1 > 80)
    #PLAYER 2 GANA
    Game.create(player_1: @player1.id, player_2: @player2.id, winner: @player2.id)
    @winner = "#{@player2.name} won!"
  elsif (score_p1 == score_p2)
    #EMPATE
    Game.create(player_1: @player1.id, player_2: @player2.id, winner: 0)
    @winner = "It's a tie!"
  end
  erb :_postgame, layout: false
end