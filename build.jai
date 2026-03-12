#import "Basic";
#import "Compiler";

#run build();

build :: () {
  w := compiler_create_workspace("Twitch Game");
  options := get_build_options(w);
  options.output_path = "bin/";
  options.output_executable_name = "twitch-game";
  set_build_options(options, w);
  compiler_begin_intercept(w);
  add_build_file("main.jai", w);

  while true {
    message := compiler_wait_for_message();
    if message.kind == .COMPLETE break;
  }

  compiler_end_intercept(w);
  set_build_options_dc(.{do_output=false});
}
