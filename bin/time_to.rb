#!/usr/bin/env ruby
#
require 'time'

class String
  # Normal colors
  def black;       colorize(self, "\e[0m\e[30");     end
  def red;         colorize(self, "\e[0m\e[31");     end
  def green;       colorize(self, "\e[0m\e[32");     end
  def yellow;      colorize(self, "\e[0m\e[33");     end
  def blue;        colorize(self, "\e[0m\e[34");     end
  def purple;      colorize(self, "\e[0m\e[35");     end
  def cyan;        colorize(self, "\e[0m\e[36");     end
  def white;       colorize(self, "\e[0m\e[37");     end

  # Fun stuff
  def clean;       colorize(self, "\e[0");           end
  def bold;        colorize(self, "\e[1");           end
  def underline;   colorize(self, "\e[4");           end
  def blink;       colorize(self, "\e[5");           end
  def reverse;     colorize(self, "\e[7");           end
  def conceal;     colorize(self, "\e[8");           end

  # Blanking
  def clear_scr;   colorize(self, "\e[2", mode="J"); end

  # Placement
  def place(line, column)
    colorize(self, "\e[#{line};#{column}", mode='f')
  end

  def save_pos;    colorize(self, "\e[", mode='s');  end
  def return_pos;  colorize(self, "\e[", mode='u');  end

  def colorize(text, color_code, mode='m')
    "#{color_code}#{mode}#{text}\e[0m"
  end

end

anims1 = [
"╔════╤╤╤╤╤════╗
║    ││││ \\   ║
║    ││││  "+"O".red+"  ║
║    OOOO     ║",
]

anims2 = [

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    OOOO"+"O".red+"    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    OOO"+"O".yellow+"O    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    OO"+"O".green+"OO    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    O"+"O".blue+"OOO    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    "+"O".purple+"OOOO    ║",

]

anims3 = [

"╔════╤╤╤╤╤════╗
║   / ││││    ║
║  "+"O".purple+"  ││││    ║
║     OOOO    ║",

]

anims4 = [

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    "+"O".purple+"OOOO    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    O"+"O".blue+"OOO    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    OO"+"O".green+"OO    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    OOO"+"O".yellow+"O    ║",

"╔════╤╤╤╤╤════╗
║    │││││    ║
║    │││││    ║
║    OOOO"+"O".red+"    ║",

]

in_loop=true
print "\e[?25l"
while in_loop do
time_to_lunch=(Time.parse('14:05')-Time.now).to_i
mm, ss = time_to_lunch.divmod(60)
hh, mm = mm.divmod(60)
dd, hh = hh.divmod(24)
puts "\e[KTime to lunch: %d days, %d hours, %d minutes and %d seconds" % [dd, hh, mm, ss]
anims1.each do |anim|
  puts anim
  print "\e[4A"
  sleep 0.30
end
anims2.each do |anim|
  puts anim
  print "\e[4A"
  sleep 0.07
end
anims3.each do |anim|
  puts anim
  print "\e[4A"
  sleep 0.30
end
anims4.each do |anim|
  puts anim
  print "\e[4A"
  sleep 0.07
end
print "\e[1A"
in_loop=false if time_to_lunch==0
end
print "\e[6B"
puts "spis!"
print "\e[?25h"
