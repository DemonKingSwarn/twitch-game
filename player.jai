#import "Input";
#import "Math";


#load "constants.jai";

Player :: struct {
  position: Vector2;
  velocity: Vector2;
}

load_player :: () -> Simp.Texture {
  result: Texture;
  Simp.texture_load_from_file(*result, player_image);
  return result;
}

draw_player :: () {
  player_texture := load_player();
  Simp.set_shader_for_images(*player_texture);
  Simp.immediate_begin();
  Simp.immediate_quad(player.position.x, player.position.y, player.position.x + size, player.position.y + size, .{1, 1, 1, 1});
  Simp.immediate_flush();
}

move_player :: (player: *Player, delta_time: float, ev: Event) {
  if ev.type == .KEYBOARD {
    mul := ifx ev.key_pressed then 1.0 else 0.0;
    if ev.key_code == {
      case #char "W"; player.velocity.y = speed * mul;
      case #char "S"; player.velocity.y = -speed * mul;
      case #char "A"; player.velocity.x = -speed * mul;
      case #char "D"; player.velocity.x = speed * mul;
    }
  }
}
