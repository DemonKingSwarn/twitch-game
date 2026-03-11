#import "Basic";
#import "Window_Creation";
#import "Input";
#import "System";

Simp :: #import "Simp";
Texture :: Simp.Texture;

width :: 1280;
height :: 720;

title :: "Jai Window";

running := true;

#load "player.jai";

player: Player;

delta_time :: (last_time: *Apollo_Time) -> float {
  current_time := current_time_monotonic();
  duration := current_time - last_time.*;
  dt := cast(float) to_float64_seconds(duration);
  last_time.* = current_time;
  
  return dt;
}

game_window :: () {
  window := create_window(width, height, title);
  Simp.set_render_target(window);
  
  last_time := current_time_monotonic();
  
  while true {
      
      dt := delta_time(*last_time);
      
      update_window_events();
      
      for events_this_frame { 
        if it.type == .QUIT return;
        game_loop(it, dt);
      }
      
      player.position.x += player.velocity.x * dt;
      player.position.y += player.velocity.y * dt;
      
      Simp.clear_render_target(0.1, 0.1,0.15, 1.0);
      draw_player(); 
      Simp.swap_buffers(window);
  }
}


game_loop :: (ev: Event, dt: float) {
  move_player(*player, dt, ev);
}

main :: () {
  game_window();
}

#run main();
