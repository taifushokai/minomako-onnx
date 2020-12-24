#!/usr/local/bin/ruby

include Math
PI_180 = PI / 180

require 'onnxruntime'
Model = OnnxRuntime::Model.new("model.onnx")

def main
  print("x, sin(x), nnsin(x)\n")
  0.step(360, 3) do |x|
    printf("%d, %.2f, %.2f\n", x, sin(PI_180 * x), nnsin(x))
  end
end

def nnsin(x)
  return Model.predict({Input: [[x]]})["Affine_3"][0][0]
end

main

