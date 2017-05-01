ExUnit.start

defmodule ArithTest do
  use ExUnit.Case, async: true
  ExUnit.start(timeout: 100)

  test 'type' do
    assert Arith.type(:true) == :bool
    assert Arith.type(:false) == :bool
    assert Arith.type(:zero) == :nat

    assert Arith.type({:is_zero, :zero}) == :bool
    assert Arith.type({:pred, :zero}) == :nat
    assert Arith.type({:succ, :zero}) == :nat

    assert_raise Arith.NotWellTyped, fn ->
      Arith.type({:succ, :true})
    end

    assert Arith.type({:if, :true, :true, :false}) == :bool
    assert Arith.type({:if, :false, :zero, :zero}) == :nat

    assert_raise Arith.NotWellTyped, fn ->
      Arith.type({:if, :zero, :true, :false})
    end

    assert_raise Arith.NotWellTyped, fn ->
      Arith.type({:if, :false, :zero, :true})
    end
    
    assert_raise Arith.NotWellFormed, fn ->
      Arith.type({:is_zero, :bananas})
    end
  end
end
