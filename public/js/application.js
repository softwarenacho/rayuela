$(document).ready(function() {

  var player1 = ""
  var player2 = ""
  var data = ""
  var check1 = ""
  var check2 = ""
  var counter = 3;
	
  $("#game_area").on("submit","#players_name",function(event) {
    event.preventDefault();
    player1 = $('input[name=player1]').val();
    player2 = $('input[name=player2]').val();
    data = ""
    $("#message").html(data);
    if (player1 == "" || player2 == "") {
      data = "One or two fields are empty";
      $("#message").html(data);
    } else {
      $("#game_area").load("/game/" + player1 + "&" + player2);
    }
  });

  //BOTON DE PLAY
  $("#game_area").on("click", "#new_game", function(){
    event.preventDefault();
    counter = 3;
    counter_time(counter);
    player1 = $('input[name=player1]').val();
    player2 = $('input[name=player2]').val();
  });

  $("#game_area").on("click", "#stats", function(){
    event.preventDefault();
    $("#game_area").load("/stats/" + player1 + "&" + player2);
  });

  $(document).keyup(function(event){
    var key = event.which;
    if (key == 65) {
      check1 = true;
    }
    if (key == 53) {
      check2 = true;
    } 
  });

//FUNCIONANDO!!!
  function game_animation() {
    final1 = $("#player1").find(".active.td_final").attr("id");
    final2 = $("#player2").find(".active.td_final").attr("id");
    $("#counter_div").html("GO!");

    if (final1 == "p1_100" || final2 == "p2_100") {
      var data_to = score();
      $("#unlock_buttons").load(data_to);
      return "\nFINISH\n"
      // break();
    } 

    //LOS DOS APRETARON
    else if(check1 == true && check2 == true) {
      var data_to = score();
      $("#unlock_buttons").load(data_to);
      return "\nFINISH\n"
      // break();
      // ("#game_area").stop();
    } 
    
    //FUNCIONES DE MOVIMIENTO
    if (check1 == true && check2 == false) {
      move_player("#player2");
    }
    if (check1 == false && check2 == true) {
      move_player("#player1");
    }
    if (check1 == false && check2 == false) {
      move_player("#player1");
      move_player("#player2");
    }
    setTimeout(game_animation, 10);

  }

  function move_player(player){
    $(player).find(".active").next().addClass("active");
    $(player).find(".active").first().removeClass("active");
  }

  function score(){
    var score_p1 = $("#player1").find(".active").attr("id");
    var score_p2 = $("#player2").find(".active").attr("id");
    //MANDAMOS AL METODO postgame
    var data_to = "/_postgame/" + player1 + "&" + player2 + "&" + score_p1 + "&" + score_p2;
    return data_to;
  }

  function reset_td(){
    $("#player1").find(".active").first().removeClass("active");
    $("#player1").find(".td_game").first().addClass("active");
    $("#player2").find(".active").first().removeClass("active");
    $("#player2").find(".td_game").first().addClass("active");
  }

  function counter_time(){
    if (counter != 0){
      $("#counter_div").html(counter)
      counter--;
      setTimeout(counter_time, 1000);
    } else {
      check1 = false;
      check2 = false;
      reset_td();
      game_animation(); 
    }
  }




});
