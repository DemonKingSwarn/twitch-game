#import "System";

delta_time :: (last_time: *Apollo_Time) -> float {
  current_time := current_time_monotonic();
  duration := current_time - last_time.*;
  dt := cast(float) to_float64_seconds(duration);
  last_time.* = current_time;
  
  return dt;
}
