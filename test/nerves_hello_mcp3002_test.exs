defmodule NervesHelloMcp3002Test do
  use ExUnit.Case
  doctest NervesHelloMcp3002

  test "greets the world" do
    assert NervesHelloMcp3002.hello() == :world
  end
end
