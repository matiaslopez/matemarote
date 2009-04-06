
//Seleccionar al player 1
$.ajax({url:'/select_player/', async:false, data:{'player_id':1}, type:'POST', dataType:'json'});

var id_juego;
//Crear un juego nuevo, nos guardamos el id
$.ajax({url:'/create_stroop_game/', async:false, dataType:'json',
        success:function(x){
            id_juego = x.game_id;
        }})

///////
log = '{"type":"eventoDummy", "time": 10000, "data": {"arg1":"un arg", "arg2":"otro argumento"}, "order": 1}\n'+
      '{"type":"eventoDummy", "time": 20100, "data": {"otra_cosa":"otro arg"}, "order": 2}\n'

$.ajax({url:'/save_stroop_game/', data:{'game_id':id_juego, 'log': log}, method:'POST', dataType:'json'})
