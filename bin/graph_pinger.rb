#!/usr/bin/ruby

require "open3"

def spark(histo, ticks=%w[▁ ▂ ▃ ▄ ▅ ▆ ▇])
  range = histo.max - histo.min

  if range == 0
    return ticks.first * histo.size
  end

  scale = ticks.size - 1
  distance = histo.max.to_f / scale

  histo.map do |val|
    tick = (val / distance).round
    tick = 0 if tick < 0
    tick = 1 if val > 0 && tick == 0 # show at least something for very small values

    ticks[tick]
  end.join
end

target=ARGV.first

print "\e[2J"
print "\e[H"
puts "Pinging #{target}"

# 64 bytes from 172.17.219.102: icmp_seq=3 ttl=63 time=1.07 ms
Open3.popen3("ping #{target}") do |stdin, stdout, stderr|
  times=Array.new
  while line = stdout.readline
    next if line =~ /^PING/

    match = line.match(/time=(.*) /)
    time = (match[1].to_f*100).to_i
    times << time


    if times.length>40
      #print "\e[2;1f"
      times=times[5..-1]
    end
    print "\e[K"
    print "\e[2;1f" # move to 3,$
    print spark(times)

    print "\e[3;1f" # move to 3,1
    print "\e[K"
    printf "Min: %8s ms\n", "#{times.min/100.to_f}"
    print "\e[K"
    printf "Max: %8s ms\n", "#{times.max/100.to_f}"
    times.reverse[0..10].each do |t|
      printf "\e[K%13s ms\n", "#{(t/100.to_f).to_s}"
    end
    STDOUT.flush
  end
end
