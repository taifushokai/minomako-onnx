#!/usr/bin/env ruby

require 'csv'

def main
  CSV::open("sin_Training.csv", "w") do |csv|
    csv << ["x__0:in", "y__0:out"]
    0.step(360, 2) do |x|
      csv << [x, Math::sin(x * Math::PI / 180).round(3)]
    end
  end

  CSV::open("sin_Validation.csv", "w") do |csv|
    csv << ["x__0:in", "y__0:out"]
    1.step(360, 2) do |x|
      csv << [x, Math::sin(x * Math::PI / 180).round(3)]
    end
  end
end

main

