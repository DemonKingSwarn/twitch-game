#import "Basic";
#import "Window_Creation";
#import "Input";
#import "System";

Simp :: #import "Simp";
Texture :: Simp.Texture;

running := true;

#load "player.jai";
#load "constants.jai";
#load "time.jai";

player: Player;

game_window :: () {
  window := create_window(width, height, title);
  Simp.set_render_target(window);
  
  last_time := current_time_monotonic();
  
  while running {
      
      dt := delta_time(*last_time);
      
      update_window_events();
      
      for events_this_frame { 
        if it.type == .QUIT return;
        game_loop(it, dt);
      }
      
      Simp.clear_render_target(0.1, 0.1,0.15, 1.0);
      draw_player(); 
      Simp.swap_buffers(window);
  }
}


game_loop :: (ev: Event, dt: float) {
  move_player(*player, dt, ev);
}

