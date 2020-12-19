#!/usr/local/bin/ruby

include Math
require 'onnxruntime'

PI_180 = PI / 180

def main
  xa  = []
  0.step(90, 10) do |x| xa << x; end

  yaB = []
  time0 = Time::now
  xa.each do |x|
    yaB << sin(PI_180 * x)
  end
  time1 = Time::now
  printf("BI %6.1fμs\n", (time1 - time0) * 1000000)

  yaX = []
  model = OnnxRuntime::Model.new("model.onnx")
  time0 = Time::now
  xa.each do |x|
    yaX << model.predict({Input: [[x]]})["Affine_3"][0][0]
  end
  time1 = Time::now
  printf("OX %6.1fμs\n", (time1 - time0) * 1000000)

  yaM = []
  time0 = Time::now
  xa.each do |x|
    xr = PI_180 * x
    yaM << xr - (xr**3 / 6) + (xr**5 / 120) - (xr**7 / 5040)
  end
  time1 = Time::now
  printf("MC %6.1fμs\n", (time1 - time0) * 1000000)

  print("       BI    OX    MC\n")
  xa.each do |x|
    yB = yaB.shift
    yX = yaX.shift
    yM = yaM.shift
    printf("  %3d %5.2f %5.2f %5.2f\n", x, yB, yX, yM)
  end
end

main

