#!/usr/bin/env ruby

require 'descriptive_statistics'
require 'date'

#system("scp vs13n01z1.otl1:1ping.raw /tmp/ >/dev/null 2>&1")

result = Array.new

if File.exists?("/tmp/ping.raw")
  start_ts=File.open("/tmp/ping.raw").first.chomp
  start_time=DateTime.parse(start_ts).to_time
  File.open("/tmp/ping.raw").each do |line|
    m = line.match(/time=([\d\.]+)/)
    result.push m[1].to_f if m
  end
end

printf "%-20s%s\n", 'Start time', start_ts
printf "%-20s%d/%d (%-.1f%%)\n", "Status", result.number, 86400, result.number/86400*100

puts

printf "%-20s%10.2f\n", 'Min', result.min
printf "%-20s%10.2f\n", 'Max', result.max
printf "%-20s%10.2f\n", "Mean", result.mean
printf "%-20s%10.2f\n", '90% perc.', result.percentile(90)
printf "%-20s%10.2f\n", 'Std. dev.', result.standard_deviation

hist = Array.new(12,0)

result.each do |r|
  r_i = r.round
  case r_i
    when 0..10
      hist[0] += 1
    when 11..20
      hist[1] += 1
    when 21..50
      hist[2] += 1
    when 51..100
      hist[3] += 1
    when 101..200
      hist[4] += 1
    when 201..500
      hist[5] += 1
    when 501..1000
      hist[6] += 1
    when 1001..2000
      hist[7] += 1
    when 2001..5000
      hist[8] += 1
    when 5000..10000
      hist[9] += 1
    when 10001..20000
      hist[10] += 1
    else
      hist[11] += 1
  end
end

hist2 = Array.new
hist2max = Array.new
hist290 = Array.new

result.each_slice(1800) do |s|
  hist2.push s.mean
  hist2max.push s.max
  hist290.push s.percentile(90)
end

puts

puts "Range distribution:"
printf "%-20s %6s\n", 'Range', 'Count'
printf "%-20s %6s\n", '='*20, '='*5
printf "%-20s %6d\n", "0..10", hist[0]
printf "%-20s %6d\n", "11..20", hist[1]
printf "%-20s %6d\n", "21..50", hist[2]
printf "%-20s %6d\n", "51..100", hist[3]
printf "%-20s %6d\n", "101..200", hist[4]
printf "%-20s %6d\n", "201..500", hist[5]
printf "%-20s %6d\n", "501..1000", hist[6]
printf "%-20s %6d\n", "1001..2000", hist[7]
printf "%-20s %6d\n", "2001..5000", hist[8]
printf "%-20s %6d\n", "5001..10000", hist[9]
printf "%-20s %6d\n", "10001.20000", hist[10]
printf "%-20s %6d\n", "20001..\u221E", hist[11]

puts
puts "Time distribution (half hour):"
printf "%-20s %6s %6s %6s %s\n", 'Interval', 'Avg', 'Max', '90%', 'Avg. Index'
printf "%-20s %6s %6s %6s %s\n", '='*20, '='*5, '='*5, '='*5, '='*100
hist2.each_with_index do |h, i|
  time_from=start_time+(i*1800)
  time_to=time_from+1800
  time_from_fmt=format("%2d:%2d", time_from.hour, time_from.min)
  time_to_fmt=format("%2d:%2d", time_to.hour, time_to.min)
  printf "%-20s %6d %6d %6d %s\n", "#{time_from_fmt}-#{time_to_fmt}", h, hist2max[i], hist290[i], '*'*((h/hist2.sum*100).to_i)
end
