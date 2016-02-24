get '/game/:player1&:player2' do
  name1 = params[:player1]
  name2 = params[:player2]
  @player1 = Player.find_or_create_by(name: name1)
  @player2 = Player.find_or_create_by(name: name2)
  erb :_game, layout: false
end

get '/stats/:player1&:player2' do
  name1 = params[:player1]
  name2 = params[:player2]
  @player1 = Player.find_by(name: name1)
  @player2 = Player.find_by(name: name2)
  score_p1 =  Game.where("player_1 = #{@player1.id} or player_2 = #{@player1.id}")
  score_p2 =  Game.where("player_1 = #{@player2.id} or player_2 = #{@player2.id}")
  total_games_p1 = score_p1.length
  total_games_p2 = score_p2.length
  wins_p1 = score_p1.where(winner: @player1.id).length
  wins_p2 = score_p2.where(winner: @player2.id).length
  ties_p1 = score_p1.where(winner: 0).length
  ties_p2 = score_p2.where(winner: 0).length
  loses_p1 = total_games_p1 - wins_p1 - ties_p1
  loses_p2 = total_games_p2 - wins_p2 - ties_p2
  success_rate_p1 = wins_p1.to_f/total_games_p1*100
  success_rate_p2 = wins_p2.to_f/total_games_p2*100
  @p1_stats = [total_games_p1, wins_p1, ties_p1, loses_p1, success_rate_p1.round(2)]
  @p2_stats = [total_games_p2, wins_p2, ties_p2, loses_p2, success_rate_p2.round(2)]
  erb :_stats, layout: false
end